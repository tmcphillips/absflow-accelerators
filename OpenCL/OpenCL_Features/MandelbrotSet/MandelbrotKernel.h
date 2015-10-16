#pragma once

#include "opencl_utilities.h"
#include "Utilities.h"
#include "MandelbrotKernelConfig.h"

class MandelbrotKernel
{
public:
	MandelbrotKernel(char const * platform_name, cl_device_type device_type, bool double_precision);
	~MandelbrotKernel();

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
	);

	std::string platformName() { return trim(ocl::get_platform_info(platform_id, CL_PLATFORM_NAME)); }
	std::string deviceName() { return trim(ocl::get_device_info<std::string>(device_id, CL_DEVICE_NAME)); }

private:
	bool double_precision;
	cl_platform_id platform_id;
	cl_device_id device_id;
	cl_context context;
	cl_command_queue queue;
	cl_program program;
	cl_kernel kernel;
	cl_mem d_bitmap;
	size_t bitmapBytes{ 0 };
};

