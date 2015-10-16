#pragma once
#include "stdafx.h"
#include "opencl_utilities.h"
#include "Utilities.h"

#include <iostream>
#include <iomanip>
#include <string>
#include <vector>
#include <fstream>

using std::string;
using std::vector;
using std::endl;

namespace ocl {

	vector<string> get_platform_names() {

		OCL_STATUS_INITIALIZE;

		// get the number of platforms;
		cl_uint num_platforms = 0;
		OCL_CHECK(clGetPlatformIDs(0, nullptr, &num_platforms));

		// get the platform IDs
		cl_platform_id *platform_ids = new cl_platform_id[num_platforms];
		OCL_CHECK(clGetPlatformIDs(num_platforms, platform_ids, nullptr));

		// get the name of each platform
		vector<string> platform_names{};
		for (size_t i = 0; i < num_platforms; ++i) {
			string name = get_platform_info(platform_ids[i], CL_PLATFORM_NAME);
			platform_names.push_back(name);
		}

		// release memory for platform IDs
		delete [] platform_ids;

		// return the names
		return platform_names;
	}

	cl_platform_id get_platform_id(string const & name_pattern) {

		OCL_STATUS_INITIALIZE;

		// get the number of platforms
		cl_uint num_platforms = 0;
		OCL_CHECK(clGetPlatformIDs(0, nullptr, &num_platforms));

		// get the platform IDs
		cl_platform_id* platform_ids = new cl_platform_id[num_platforms];
		OCL_CHECK(clGetPlatformIDs(num_platforms, platform_ids, nullptr));

		// find platform with name matching first argument
		cl_platform_id matching_id = 0;
		for (size_t platform_index = 0; matching_id == 0 && platform_index < num_platforms; ++platform_index) {

			size_t name_size = 0;

			// get size of name of currently index platform and allocate memory for storing name
			OCL_CHECK(clGetPlatformInfo(platform_ids[platform_index], CL_PLATFORM_NAME, 0,
				nullptr, &name_size));
			char * platform_name = new char[name_size];

			// get the name of the currently indexed platform
			OCL_CHECK(clGetPlatformInfo(platform_ids[platform_index], CL_PLATFORM_NAME, name_size,
				platform_name, nullptr));

			// save the current platform id if its name matches the passed argument
			if (string(platform_name).find(name_pattern) != string::npos) {
				matching_id = platform_ids[platform_index];
			}

			// release memory for platform name
			delete [] platform_name;
		}
	
		// release memory for platform IDs
		delete [] platform_ids;

		// report failure if no matching platform name was found
		if (matching_id == 0) throw std::invalid_argument("Platform not found");

		// return matching platform id
		return matching_id;
	}


	cl_device_id get_device_id(cl_platform_id platform_id, cl_device_type device_type) {

		OCL_STATUS_INITIALIZE;

		// make sure there is only one device on this platform with requested type
		cl_uint num_devices = 0;
		OCL_CHECK(clGetDeviceIDs(platform_id, device_type, 0, nullptr, &num_devices));
		if (num_devices == 0) throw std::invalid_argument("No device of requested type found");
		if (num_devices > 1) throw std::invalid_argument("Multiple devices of requested type found");

		// get the ID of the single device with the requested type
		cl_device_id device_id;
		OCL_CHECK(clGetDeviceIDs(platform_id, device_type, 1, &device_id, nullptr));

		// return the matching device ID
		return device_id;
	}

	cl_device_id get_device_id(string const & platform_name, cl_device_type device_type) {

		// look up the platform id from its name
		cl_platform_id platform_id = get_platform_id(platform_name);

		// return the single device of the specified type on that platform
		return get_device_id(platform_id, device_type);
	}

	string get_platform_info(cl_platform_id platformID, cl_device_info parameterID) {

		OCL_STATUS_INITIALIZE;

		// get size of the requested parameter value and allocate memory for it
		size_t size;
		OCL_CHECK(clGetPlatformInfo(platformID, parameterID, 0, nullptr, &size));
		char * parameter_value = new char[size];

		// get the requested parameter value and store in a string
		OCL_CHECK(clGetPlatformInfo(platformID, parameterID, size, parameter_value, nullptr));
		string result{ parameter_value };

		// release the memory for the value and return the string
		delete [] parameter_value;
		return result;
	}

	template<>
	string get_device_info<string>(cl_device_id deviceID, cl_device_info parameterID) {

		OCL_STATUS_INITIALIZE;

		// get size of the requested parameter value and allocate memory for it
		size_t size;
		OCL_CHECK(clGetDeviceInfo(deviceID, parameterID, 0, nullptr, &size));
		char * parameter_value = new char[size];

		// get the requested parameter value and store in a string
		OCL_CHECK(clGetDeviceInfo(deviceID, parameterID, size, parameter_value, nullptr));
		string result{ parameter_value };

		// release the memory for the value and return the string
		delete [] parameter_value;
		return result;
	}

	template<>
	bool get_device_info<bool>(cl_device_id device_id, cl_device_info parameter_id) {
		OCL_STATUS_INITIALIZE;
		cl_bool value;
		OCL_CHECK(clGetDeviceInfo(device_id, parameter_id, sizeof(value), &value, nullptr));
		return (value == CL_TRUE);
	}

	template<>
	void print_device_info<bool>(char const * label, cl_device_id device_id, cl_device_info parameter_id,
		std::ostream & os, size_t label_column_width) {
		os << std::left << std::setw(label_column_width) << label << " = ";
		os << (ocl::get_device_info<bool>(device_id, parameter_id) ? "true" : "false") << endl;
	}

	void print_platform_info(char const * label, cl_platform_id platform_id, cl_device_info parameter_id,
		size_t label_column_width, std::ostream & os) {
		os << std::left << std::setw(label_column_width) << label << " = ";
		os << ocl::get_platform_info(platform_id, parameter_id) << endl;
	}

	template<>
	void print_device_info<ocl_device_t>(char const * label, cl_device_id device_id, cl_device_info parameter_id,
		std::ostream & os, size_t label_column_width) {

		static std::vector<std::string> device_types{
			"CL_DEVICE_TYPE_DEFAULT",
			"CL_DEVICE_TYPE_CPU",
			"CL_DEVICE_TYPE_GPU",
			"CL_DEVICE_TYPE_ACCELERATOR",
			"CL_DEVICE_TYPE_CUSTOM",
		};

		OCL_STATUS_INITIALIZE;
	
		cl_device_type value;
		OCL_CHECK(clGetDeviceInfo(device_id, parameter_id, sizeof(value), &value, nullptr));

		os << std::left << std::setw(label_column_width) << label << " = ";
		for (int i = 0; i < device_types.size(); ++i) {
			if (value & 1) os << device_types[i] << ' ';
			value >>= 1;
		}
		os << endl;
	}

	string read_opencl_source(string filename) {
		std::ifstream ifs{ filename };
		return string((std::istreambuf_iterator<char>(ifs)), std::istreambuf_iterator<char>());
	}

	vector<unsigned char> read_opencl_binary(string filename) {

		FILE *file;
		size_t byteCount;

		errno_t err = fopen_s(&file, filename.c_str(), "rb");
		if (!file) throw std::invalid_argument("Unable to open file");

		//Get file length
		fseek(file, 0, SEEK_END);
		byteCount = ftell(file);
		fseek(file, 0, SEEK_SET);

		//Allocate memory in a vector
		vector<unsigned char> result(byteCount);

		//Read file contents into the vector
		fread(&result[0], byteCount, 1, file);

		// close the file
		fclose(file);

		return result;
	}

	cl_program createProgramFromBinary(cl_context context, cl_device_id device_id, std::string filePath) {
		OCL_STATUS_INITIALIZE;
		auto binary = ocl::read_opencl_binary(filePath.c_str());
		auto binarySize = binary.size();
		unsigned char const * binaryData = &binary[0];
		cl_program program = OCL_CHECK(clCreateProgramWithBinary(context, 1, &device_id, &binarySize, &binaryData, nullptr, &OCL_STATUS));
		return program;
	}

	cl_program createProgramFromSource(cl_context context, std::string filePath) {
		OCL_STATUS_INITIALIZE;
		std::string programSource = ocl::read_opencl_source(filePath).c_str();
		const char* sourceChars = programSource.c_str();
		cl_program program = OCL_CHECK(clCreateProgramWithSource(context, 1, &sourceChars, nullptr, &OCL_STATUS));
		return program;
	}

	cl_program buildProgramForDevice(
		string platform_name, cl_device_type device_type, bool useBinary,
		string const & binary_name, string const & source_name, string const & build_options, 
		cl_context& context, cl_command_queue& queue
	) {
		OCL_STATUS_INITIALIZE;

		// access the desired platform and device
		cl_platform_id platform_id = ocl::get_platform_id(platform_name);
		cl_device_id device_id = ocl::get_device_id(platform_id, device_type);

		// create a context and queue for the device
		context = OCL_CHECK(clCreateContext(nullptr, 1, &device_id, nullptr, nullptr, &OCL_STATUS));
		queue = OCL_CHECK(clCreateCommandQueue(context, device_id, 0, &OCL_STATUS));

		// create the program from an opencl binary file or a source file
		cl_program program = useBinary ? ocl::createProgramFromBinary(context, device_id, binary_name)
			: ocl::createProgramFromSource(context, source_name);

		// compile the opencl program and report errors
		OCL_CHECK_BUILD(clBuildProgram(program, 1, &device_id, build_options.c_str(), nullptr, nullptr), program, device_id);

		return program;
	}


	void throw_build_exception(cl_int status, cl_program program, cl_device_id device_id, string name) {

		OCL_STATUS_INITIALIZE;

		// start the error message for the exception
		std::stringstream message;
		message << "Error " << status << " building OpenCL program " << name << std::endl;

		// get the size of build log and allocate memory for storing it
		size_t buildlogSize;
		OCL_CHECK(clGetProgramBuildInfo(program, device_id, CL_PROGRAM_BUILD_LOG, 0, nullptr, &buildlogSize));
		char* buildlog = new char[buildlogSize];

		// get the build log
		OCL_CHECK(clGetProgramBuildInfo(program, device_id, CL_PROGRAM_BUILD_LOG, buildlogSize, buildlog, nullptr));

		// append the build log to the error message
		message << buildlog << std::endl;
		
		// release the memory for build log
		delete [] buildlog;

		// write the error message to stderr, the debug window, and the exception to be thrown 
		std::cerr << message.str();
		printResults(message.str());
		throw std::runtime_error{ message.str() };
	}

	void throw_status_exception(cl_int const & status, string const & description, char const * file, int line) {
		std::stringstream message;
		message << "Error " << status << " on line " << line << " of " << file << ": " << description << std::endl;
		std::cerr << message.str();
		printResults(message.str());
		throw std::runtime_error{ message.str() };
	}

	template <>
	cl_int const & check_status<cl_int>(cl_int const & opencl_object, cl_int & status,
		char const * file, int line) {
		status = opencl_object;
		if (status != 0) ocl::throw_status_exception(status, "", file, line);
		return opencl_object;
	}
}
