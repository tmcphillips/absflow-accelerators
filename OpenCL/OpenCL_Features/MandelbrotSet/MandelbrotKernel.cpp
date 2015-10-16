#include "MandelbrotKernel.h"
#include "opencl_utilities.h"

MandelbrotKernel::MandelbrotKernel(char const * platform_name, cl_device_type device_type, bool use_double_precision) 
	: double_precision(use_double_precision)
{
	OCL_STATUS_INITIALIZE;

	// access the desired platform and device
	platform_id = ocl::get_platform_id(platform_name);
	device_id = ocl::get_device_id(platform_id, device_type);

	// create a context and queue for the device
	context = OCL_CHECK(clCreateContext(nullptr, 1, &device_id, nullptr, nullptr, &OCL_STATUS));
	queue = OCL_CHECK(clCreateCommandQueue(context, device_id, 0, &OCL_STATUS));

	// create the program from an opencl binary file or a source file
	if (ocl::DeviceTraits<ProjectDevice>::UseBinary) {
		std::string filename = double_precision ?
			R"(D:\Accelerators\OpenCL\OpenCL_Features\x64\MandelbrotSet_double_unrolled)" + ocl::DeviceTraits<ProjectDevice>::BinaryExtension :
			R"(D:\Accelerators\OpenCL\OpenCL_Features\x64\MandelbrotSet_float_unrolled)" + ocl::DeviceTraits<ProjectDevice>::BinaryExtension;
		auto binary = ocl::read_opencl_binary(filename);
		auto binarySize = binary.size();
		unsigned char const * binaryData = &binary[0];
		program = OCL_CHECK(clCreateProgramWithBinary(context, 1, &device_id, &binarySize, &binaryData, nullptr, &OCL_STATUS));
	}
	else {
		std::string sourceString = ocl::read_opencl_source("MandelbrotSet.cl");
		char const * sourceChars = sourceString.c_str();
		program = OCL_CHECK(clCreateProgramWithSource(context, 1, &sourceChars, nullptr, &OCL_STATUS));
	}

	// compile the opencl program and report errors
	OCL_CHECK_BUILD(clBuildProgram(
		program, 1, &device_id, 
		double_precision ? "-D USE_DOUBLE_PRECISION" : "-D USE_SINGLE_PRECISION", 
		nullptr, nullptr), program, device_id);

	//create the kernel
	kernel = OCL_CHECK(clCreateKernel(program, "mandelbrot_kernel", &OCL_STATUS));
}

MandelbrotKernel::~MandelbrotKernel() {
	OCL_STATUS_INITIALIZE;
	if (bitmapBytes != 0) OCL_CHECK(clReleaseMemObject(d_bitmap));
	OCL_CHECK(clReleaseKernel(kernel));
	OCL_CHECK(clReleaseProgram(program));
	OCL_CHECK(clReleaseCommandQueue(queue));
	OCL_CHECK(clReleaseContext(context));
}

void MandelbrotKernel::compute(
	int columns,
	int rows,
	int center_col,
	int center_row,
	double center_x,
	double center_y,
	double scale,
	int rowByteCount,
	int maxIterations,
	void * h_bitmap
	)
{
	OCL_STATUS_INITIALIZE;

	size_t newBitmapBytes = rows * rowByteCount;
	if (newBitmapBytes != bitmapBytes) {
		if (bitmapBytes != 0) OCL_CHECK(clReleaseMemObject(d_bitmap));
		bitmapBytes = newBitmapBytes;
		d_bitmap = OCL_CHECK(clCreateBuffer(context, CL_MEM_WRITE_ONLY, bitmapBytes, nullptr, &OCL_STATUS));
		OCL_CHECK(clSetKernelArg(kernel, 0, sizeof(cl_mem), &d_bitmap));
	}

	OCL_CHECK(clSetKernelArg(kernel, 1, sizeof(int), &columns));
	OCL_CHECK(clSetKernelArg(kernel, 2, sizeof(int), &rows));
	OCL_CHECK(clSetKernelArg(kernel, 3, sizeof(int), &center_col));
	OCL_CHECK(clSetKernelArg(kernel, 4, sizeof(int), &center_row));

	if (double_precision) {
		OCL_CHECK(clSetKernelArg(kernel, 5, sizeof(double), &center_x));
		OCL_CHECK(clSetKernelArg(kernel, 6, sizeof(double), &center_y));
		OCL_CHECK(clSetKernelArg(kernel, 7, sizeof(double), &scale));
	}
	else {
		float center_x_float = (float) center_x;
		float center_y_float = (float) center_y;
		float scale_float = (float) scale;
		OCL_CHECK(clSetKernelArg(kernel, 5, sizeof(float), &center_x_float));
		OCL_CHECK(clSetKernelArg(kernel, 6, sizeof(float), &center_y_float));
		OCL_CHECK(clSetKernelArg(kernel, 7, sizeof(float), &scale_float));
	}

	OCL_CHECK(clSetKernelArg(kernel, 8, sizeof(int), &rowByteCount));
	OCL_CHECK(clSetKernelArg(kernel, 9, sizeof(int), &maxIterations));

	size_t globalWorkSize[2] = { 16 * (columns / 16 + 1), 16 * (rows / 16 + 1) };
	size_t localWorkSize[2] = { 16, 16 };
	OCL_CHECK(clEnqueueNDRangeKernel(queue, kernel, 2, nullptr, globalWorkSize, localWorkSize, 0, nullptr, nullptr));

	OCL_CHECK(clEnqueueReadBuffer(queue, d_bitmap, CL_TRUE, 0, bitmapBytes, h_bitmap, 0, nullptr, nullptr));
}
