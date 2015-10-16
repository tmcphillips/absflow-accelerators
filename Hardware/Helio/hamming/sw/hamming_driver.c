/* Character driver for running Hamming accelerator on Helio board */

#include <linux/module.h>
#include <linux/ioport.h>
#include <linux/fs.h>
#include <linux/cdev.h>
#include <asm/io.h>
#include <asm/uaccess.h>

#define HAMMING_PHYSICAL_BASE	0xFF210000
#define HAMMING_IOMEM_SIZE		0x600
#define HAMMING_MAX_OFFSET 		0x500
#define HAMMING_SEED_OFFSET 	0x404
#define HAMMING_CSR_OFFSET		0x400
#define HAMMING_OUT_OFFSET 		0x000

#define HAMMING_SEED_VALUE		0x01

#define DEVICE_MAJOR 235

#define DEBUG
#undef DEBUG

#ifdef DEBUG
# define DEBUG_PRINTK(x) printk x
#else
# define DEBUG_PRINTK(x) do {} while (0)
#endif

#define NDEBUG_PRINTK(x) printk x


typedef unsigned int uint32;

struct file_operations hamming_fops;
static volatile void *hamming_virtual_base;
static dev_t hamming_device_num;
struct cdev *hamming_cdev;

static int hamming_open(
	struct inode 	*inode, 
	struct file 	*file) 
{
	printk("hamming_open: successful\n");
	return 0;
}

static int hamming_release(
	struct inode 	*inode, 
	struct file 	*file) 
{
	printk("hamming_release: successful\n");
	return 0;
}

uint32 local_buffer[2000];
int eof;

static ssize_t hamming_read(
	struct file 	*file, 
	char __user		*user_buffer,
	size_t 			count,
	loff_t 			*ppos)
{
	int status;
	size_t i = 0;
	uint32* p_local_buffer = local_buffer;

	if (eof) return 0;

	for (i= 0; i < count; ++i) {
		*p_local_buffer = ioread32(hamming_virtual_base + HAMMING_OUT_OFFSET);
		DEBUG_PRINTK(("Read hamming output: %u\n", *p_local_buffer ));
		if (*p_local_buffer == 0) {
			eof = 1;
			break;
		}
		++p_local_buffer;
	}

	// return 0 if no results were obtained from accelerator
	if (p_local_buffer == local_buffer) return 0;

	status = copy_to_user(user_buffer, local_buffer, 4*i);

	if (status != 0)
		return status;
	else
		return 4 * i;
}

static ssize_t hamming_write(
	struct file 		*file,
	const char __user	*buffer,
	size_t 				count,
	loff_t 				*ppos)
{
//	uint32 hamming_out;
	uint32 hamming_max;
	uint32 status;

	// copy the maximum hamming number to compute from user space
	int result = copy_from_user(&hamming_max, buffer, 4);
	if (result < 0) {
		DEBUG_PRINTK(("error copying 1 byte from user space"));
		return result;
	}

	// wait for any previous computation to complete
	DEBUG_PRINTK(("Wait for accelerator to go idle:\n"));
	do {
		status = ioread32(hamming_virtual_base + HAMMING_CSR_OFFSET);
		DEBUG_PRINTK(("status = %u\n", status));
//		if (status != 1) {
//			hamming_out = ioread32(hamming_virtual_base + HAMMING_OUT_OFFSET);
//			printk("Drained hamming output: %u\n", hamming_out);
//		}
	} while (status != 1);

	// set max hamming number to compute on accelerator
	iowrite32(hamming_max, hamming_virtual_base + HAMMING_MAX_OFFSET);
	DEBUG_PRINTK(("Set hamming cutoff to %u\n", hamming_max));

	// set the seed value for inserting into the hamming dataflow
	iowrite32(HAMMING_SEED_VALUE, hamming_virtual_base + HAMMING_SEED_OFFSET);

	// write to bit 0 of the hamming controller CSR to start the computation
	iowrite32(1, hamming_virtual_base + HAMMING_CSR_OFFSET);

	eof = 0;

	DEBUG_PRINTK(("Started hamming computations/n"));
	return count;
}

static int __init hamming_init(void) {

	int result;

	printk("Starting to initialize Hamming accelerator driver\n");

	// reserve the device number
	hamming_device_num = MKDEV(DEVICE_MAJOR, 0);

	result = register_chrdev_region(hamming_device_num, 1, "hamming_driver");
	if (result < 0)
		printk("Error %d reserving device number\n", result);
	else
		printk("Registered device number\n");

	/* construct a char device structure */
	hamming_cdev = cdev_alloc();
	hamming_cdev->ops = &hamming_fops;
	hamming_cdev->owner = THIS_MODULE;

	/* register the device driver */
	result = cdev_add(hamming_cdev, hamming_device_num, 1);
	if (result)
		printk( "Error %d initializing hamming_driver\n", result);
	else
		printk( "Registered device driver\n");

	/* reserve access to IO memory controlling hamming */
	printk( "Requesting 48 bytes at physical address %x\n", HAMMING_PHYSICAL_BASE);
	request_mem_region(HAMMING_PHYSICAL_BASE, HAMMING_IOMEM_SIZE, "hamming_driver");

	/* map physical address of hamming to virtual address */
	hamming_virtual_base = ioremap(HAMMING_PHYSICAL_BASE, HAMMING_IOMEM_SIZE);
	printk( "Mapped physical address %x to virtual address %x\n",
			HAMMING_PHYSICAL_BASE, (unsigned) hamming_virtual_base);

	printk("Finished initializing Hamming accelerator driver\n");
	return 0;
}

static void __exit hamming_exit(void) {

	printk("Starting to shut down Hamming accelerator driver\n");

	/* unmap virtual address of hamming */
	iounmap(hamming_virtual_base);

	/* release reservation of memory controlling hamming */
	release_mem_region(HAMMING_PHYSICAL_BASE , HAMMING_IOMEM_SIZE);

	/* unregister the driver */
	cdev_del(hamming_cdev);

	/* release the device number */
	unregister_chrdev_region(hamming_device_num, 1);

	printk("Finished shutting down Hamming accelerator driver\n");
}

struct file_operations hamming_fops = {
	owner: 	 THIS_MODULE,
	read:	 hamming_read,
	write:	 hamming_write,
	open:	 hamming_open,
	release: hamming_release,
};

module_init(hamming_init);
module_exit(hamming_exit);

MODULE_AUTHOR("Tim McPhillips");
MODULE_DESCRIPTION("Hamming Accelerator Driver");
MODULE_LICENSE("GPL");


