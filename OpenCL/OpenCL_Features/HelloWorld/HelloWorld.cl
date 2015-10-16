
__constant char greeting[] = "Hello World!";
	
__kernel void hello_kernel(__global char* C) {
	int tid = get_global_id(0);
	C[tid] = (tid < 13) ? greeting[tid] : 0;
}