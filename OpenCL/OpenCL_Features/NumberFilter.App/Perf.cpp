#include <string>
#include <vector>
#include "Utilities.h"
#include "NumberFilter.h"

using std::vector;

int main() {

	NumberFilter::OpenCL::NumberFilter<cl_int> nf(ocl::DeviceTraits<ProjectDevice>::PlatformName, ocl::DeviceTraits<ProjectDevice>::DeviceType, ocl::DeviceTraits<ProjectDevice>::UseBinary);
	vector<cl_int> inValues{ 10, 3, 5, -18, 16, 403, -19 };
	auto outValues = nf.lowpassFilter(inValues, 10);
	std::cout << concatenate(outValues) << std::endl;
	exit(0);
}