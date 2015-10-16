#ifndef T
#define T int
#endif

#ifdef ALTERA_CL

#pragma OPENCL EXTENSION cl_altera_channels : enable

channel T chan __attribute__((depth(10)));

__kernel void filter_inputs(
	__global read_only T * inputBuffer, 
	T inputBufferElements,
	T max_value,
	T delimiter
) {
	T value;
	for (T i = 0; i <= inputBufferElements; ++i) {

		bool output_ok = false;

		if (i == inputBufferElements) {
			value = delimiter;
			output_ok = true;
		} else {
			value = inputBuffer[i];
			if (value <= max_value) output_ok = true;
		}
		
		if (output_ok) {
			write_channel_altera(chan, value);
		}
	}
}

__kernel void accumulate_outputs(
	__global write_only T * restrict outputBuffer, 
	__global write_only T * restrict outputCount,
	T outputBufferElements,
	T delimiter
) {
	T i = 0;
	for (i = 0; i < outputBufferElements; ++i) {
		T value = read_channel_altera(chan);
		if (value == delimiter) break;
		outputBuffer[i] = value;
	}
	*outputCount = i;
}

#endif