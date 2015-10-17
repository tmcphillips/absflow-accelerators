/* Minimal character device driver for controlling state of 4 LEDs on Helio board */

#include <linux/module.h>
#include <linux/ioport.h>
#include <linux/fs.h>
#include <linux/cdev.h>
#include <asm/io.h>
#include <asm/uaccess.h>

#define LEDS_PHYSICAL_ADDRESS 0xFF210040
#define DEVICE_MAJOR 234

struct file_operations leds_fops;
static volatile void *leds_virtual_address;
static dev_t leds_device_num;
struct cdev *leds_cdev;

static int leds_open(
	struct inode 	*inode, 
	struct file 	*file) 
{
	printk("leds_open: successful\n");
	return 0;
}

static int leds_release(
	struct inode 	*inode, 
	struct file 	*file) 
{
	printk("leds_release: successful\n");
	return 0;
}

static ssize_t leds_read(
	struct file 	*file, 
	char __user		*buffer,
	size_t 			count,
	loff_t 			*ppos)
{
	ssize_t cnt = 1;
	char ledState = ioread8(leds_virtual_address);
	int status;

	printk("read LED state: %d\n", ledState);
	status = copy_to_user(buffer, &ledState, cnt);
	printk("copied 1 bytes to user space\n");
	return cnt;
}

static ssize_t leds_write(
	struct file 		*file,
	const char __user	*buffer,
	size_t 				count,
	loff_t 				*ppos)
{
	char ledState;
	int result = copy_from_user(&ledState, buffer, 1);
	if (result < 0)
		printk("error copying 1 byte to user space");
	else
		printk("copied 1 bytes from user space\n");
	iowrite8(ledState, leds_virtual_address);
	printk("wrote LED state: %d\n", ledState);
	return count;
}

static int __init leds_init(void) {

	int result;

	printk("Starting to initialize LED control driver\n");

	// reserve the device number
	leds_device_num = MKDEV(DEVICE_MAJOR, 0);
	result = register_chrdev_region(leds_device_num, 1, "led_driver");
	if (result < 0)
		printk(KERN_NOTICE "Error %d reserving device number\n", result);

	/* construct a char device structure */
	leds_cdev = cdev_alloc();
	leds_cdev->ops = &leds_fops;
	leds_cdev->owner = THIS_MODULE;

	/* register the device driver */
	result = cdev_add(leds_cdev, leds_device_num, 1);
	if (result) printk(KERN_NOTICE "Error %d initializing led_driver", result);

	/* reserve access to IO memory controlling LEDs */	
	request_mem_region(LEDS_PHYSICAL_ADDRESS, 1, "led_driver");

	/* map physical address of LEDs to virtual address */ 
	leds_virtual_address = ioremap(LEDS_PHYSICAL_ADDRESS, 1);

	printk("Finished initializing LED control driver\n");
	return 0;
}

static void __exit leds_exit(void) {

	printk("Starting to shut down LED control driver\n");

	/* unmap virtual address of LEDs */ 
	iounmap(leds_virtual_address);

	/* release reservation of memory controlling LEDs */
	release_mem_region(LEDS_PHYSICAL_ADDRESS , 1);

	/* unregister the driver */
	cdev_del(leds_cdev);

	/* release the device number */
	unregister_chrdev_region(leds_device_num, 1);

	printk("Finished shutting down LED control driver\n");
}

struct file_operations leds_fops = {
	owner: 	 THIS_MODULE,
	read:	 leds_read,
	write:	 leds_write,
	open:	 leds_open,
	release: leds_release,
};

module_init(leds_init);
module_exit(leds_exit);

MODULE_AUTHOR("Tim McPhillips");
MODULE_DESCRIPTION("LED Control Driver");
MODULE_LICENSE("GPL");


