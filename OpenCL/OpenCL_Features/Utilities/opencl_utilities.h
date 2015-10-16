#pragma once
#include "stdafx.h"

#include "CL\opencl.h"
#include <iostream>
#include <string>
#include <vector>

#define OCL_STATUS ocl_status_variable
#define OCL_STATUS_INITIALIZE cl_int OCL_STATUS = 0;
#define OCL_CHECK(apicall) ocl::check_status((apicall), (OCL_STATUS), __FILE__, __LINE__)
#define OCL_CHECK_BUILD(status, program, device) ocl::check_build((status), (program), (device), __FILE__, __LINE__)

namespace ocl {

	enum OCLDeviceT { INTEL_CPU, INTEL_GPU, NVIDIA_GPU, ALTERA_FPGA, ALTERA_EMULATOR };

	template<typename T>
	class OpenCLType {
	public:
		static std::string Name;
	};

	template<> std::string OpenCLType<cl_char>::Name("char");
	template<> std::string OpenCLType<cl_uchar>::Name("uchar");
	template<> std::string OpenCLType<cl_short>::Name("short");
	template<> std::string OpenCLType<cl_ushort>::Name("ushort");
	template<> std::string OpenCLType<cl_int>::Name("int");
	template<> std::string OpenCLType<cl_uint>::Name("uint");
	template<> std::string OpenCLType<cl_long>::Name("long");
	template<> std::string OpenCLType<cl_ulong>::Name("ulong");

	template<OCLDeviceT>
	class DeviceTraits {
	public:
		static std::string PlatformName;
		static std::string BinaryExtension;
		static cl_device_type DeviceType;
		static bool UseBinary;
	};

	template<> std::string DeviceTraits<INTEL_CPU>::PlatformName("Intel");
	template<> cl_device_type DeviceTraits<INTEL_CPU>::DeviceType = CL_DEVICE_TYPE_CPU;
	template<> std::string DeviceTraits<INTEL_CPU>::BinaryExtension("");
	template<> bool DeviceTraits<INTEL_CPU>::UseBinary = false;

	template<> std::string DeviceTraits<INTEL_GPU>::PlatformName("Intel");
	template<> cl_device_type DeviceTraits<INTEL_GPU>::DeviceType = CL_DEVICE_TYPE_GPU;
	template<> std::string DeviceTraits<INTEL_GPU>::BinaryExtension("");
	template<> bool DeviceTraits<INTEL_GPU>::UseBinary = false;

	template<> std::string DeviceTraits<NVIDIA_GPU>::PlatformName("NVIDIA");
	template<> cl_device_type DeviceTraits<NVIDIA_GPU>::DeviceType = CL_DEVICE_TYPE_GPU;
	template<> std::string DeviceTraits<NVIDIA_GPU>::BinaryExtension("");
	template<> bool DeviceTraits<NVIDIA_GPU>::UseBinary = false;

	template<> std::string DeviceTraits<ALTERA_FPGA>::PlatformName("Altera");
	template<> cl_device_type DeviceTraits<ALTERA_FPGA>::DeviceType = CL_DEVICE_TYPE_ACCELERATOR;
	template<> std::string DeviceTraits<ALTERA_FPGA>::BinaryExtension("_hw.aocx");
	template<> bool DeviceTraits<ALTERA_FPGA>::UseBinary = true;

	template<> std::string DeviceTraits<ALTERA_EMULATOR>::PlatformName("Altera");
	template<> cl_device_type DeviceTraits<ALTERA_EMULATOR>::DeviceType = CL_DEVICE_TYPE_ACCELERATOR;
	template<> std::string DeviceTraits<ALTERA_EMULATOR>::BinaryExtension("_em.aocx");
	template<> bool DeviceTraits<ALTERA_EMULATOR>::UseBinary = true;

	extern std::vector<std::string> device_types;

	size_t const DEFAULT_LABEL_COLUMN_WIDTH = 40;

	std::vector<std::string> get_platform_names();
	cl_platform_id get_platform_id(std::string const & platform_name);
	cl_device_id get_device_id(cl_platform_id platform_id, cl_device_type device_type);
	cl_device_id get_device_id(std::string const & platform_name, cl_device_type device_type);

	// functions for querying platform information
	std::string get_platform_info(cl_platform_id platformID, cl_device_info parameterID);
	void print_platform_info(char const * label, cl_platform_id platform_id, cl_device_info parameter_id,
		size_t label_length = DEFAULT_LABEL_COLUMN_WIDTH, std::ostream& os = std::cout);

	// functions for querying device information
	template<typename T> 
	T get_device_info(cl_device_id deviceID, cl_device_info parameterID)
	{
		OCL_STATUS_INITIALIZE;
		T value;
		OCL_CHECK(clGetDeviceInfo(deviceID, parameterID, sizeof(T), &value, nullptr));
		return value;
	}
	template<> std::string get_device_info<std::string>(cl_device_id deviceID, cl_device_info parameterID);
	template<> bool get_device_info<bool>(cl_device_id deviceID, cl_device_info parameterID);

	template<typename T, size_t N> 
	std::vector<T> get_device_info(cl_device_id device_id, cl_device_info parameter_id) {
		OCL_STATUS_INITIALIZE;
		T valueArray[N];
		OCL_CHECK(clGetDeviceInfo(device_id, parameter_id, sizeof(T) * N, valueArray, nullptr));
		std::vector<T> valueVector(N);
		std::copy(valueArray, valueArray + N, begin(valueVector));
		return valueVector;
	}

	cl_program buildProgramForDevice(std::string platform_name, cl_device_type device_type, bool useBinary,
		std::string const & binary_name, std::string const & source_name, std::string const & build_options,
		cl_context& context, cl_command_queue& queue);

	// functions for printing device information
	template<typename T>
	void print_device_info(char const * label, cl_device_id device_id, cl_device_info parameter_id,
		std::ostream & os = std::cout, size_t label_column_width = DEFAULT_LABEL_COLUMN_WIDTH) {
		os << std::left << std::setw(label_column_width) << label << " = ";
		os << ocl::get_device_info<T>(device_id, parameter_id) << endl;
	}

	template<>
	void print_device_info<bool>(char const * label, cl_device_id device_id, cl_device_info parameter_id,
		std::ostream & os, size_t label_column_width);

	class ocl_device_t {};
	template<>
	void print_device_info<ocl_device_t>(char const * label, cl_device_id device_id, cl_device_info parameter_id,
		std::ostream & os, size_t label_column_width);

	template<typename T, size_t N>
	void print_device_info(char const * label, cl_device_id device_id, cl_device_info parameter_id,
		std::ostream & os = std::cout, size_t label_column_width = DEFAULT_LABEL_COLUMN_WIDTH) {
		vector<T> values = ocl::get_device_info<T, N>(device_id, parameter_id);
		os << std::left << std::setw(label_column_width) << label << " = ";
		for (int i = 0; i < N; ++i) {
			os << values[i] << " ";
		}
		os << endl;
	}

	std::string read_opencl_source(std::string filename);
	std::vector<unsigned char> read_opencl_binary(std::string filename);

	cl_program createProgramFromBinary(cl_context context, cl_device_id device_id, std::string filePath);
	cl_program createProgramFromSource(cl_context context, std::string filePath);

	void throw_build_exception(cl_int status, cl_program program, cl_device_id device_id, std::string name = "");
	void throw_status_exception(cl_int const & status, std::string const & description, char const * file, int line);

	inline void check_build(cl_int status, cl_program program, cl_device_id device,
		char const * file, int line) {
		if (status != 0) ocl::throw_build_exception(status, program, device, "");
	}

	template <typename T>
	inline T const & check_status(T const & opencl_object, cl_int & status,
		char const * file, int line) {
		if (status != 0) ocl::throw_status_exception(status, "", file, line);
		return opencl_object;
	}

	template <>
	inline cl_int const & check_status<cl_int>(cl_int const & opencl_object, cl_int & status,
		char const * file, int line);
}


