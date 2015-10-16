

__constant char complement[] = { 
    'T','-',
    'G','-','-','-',
    'C','-','-','-','-','-','-','-','-','-','-','-','-',
    'A','-','-','-','-','-','-' 
};

__kernel void reverse_complement(__global char* dna, __global char* cdna, int length) {
	int gid = get_global_id(0);
    cdna[length - gid - 1] = complement[dna[gid] - 'A'];
}