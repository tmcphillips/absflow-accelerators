//#define USE_DOUBLE_PRECISION

#ifdef USE_DOUBLE_PRECISION
#pragma OPENCL EXTENSION cl_khr_fp64: enable
#define DOUBLE double
#else
#define DOUBLE float
#endif

__constant uchar3 colors[16] = {
	(uchar3) (100, 100, 100),
	(uchar3) (100, 0, 0),
	(uchar3) (200, 0, 0),
	(uchar3) (100, 100, 0),
	(uchar3) (200, 100, 0),
	(uchar3) (200, 200, 0),
	(uchar3) (0, 200, 0),
	(uchar3) (0, 100, 100),
	(uchar3) (0, 200, 100),
	(uchar3) (0, 100, 200),
	(uchar3) (0, 200, 200),
	(uchar3) (0, 0, 200),
	(uchar3) (100, 0, 100),
	(uchar3) (200, 0, 100),
	(uchar3) (100, 0, 200),
	(uchar3) (200, 0, 200),
};

int iteratePoint(DOUBLE cReal, DOUBLE cImaginary, int maxIterations)
{
	DOUBLE zReal = cReal;
	DOUBLE zImaginary = cImaginary;
	DOUBLE zReal2;
	DOUBLE zImaginary2;
	int n;
	for (n = 0; n < maxIterations; ++n)
	{
		zReal2 = zReal * zReal;
		zImaginary2 = zImaginary * zImaginary;

		if (zReal2 + zImaginary2 > 4) break;

		zImaginary = 2 * zReal * zImaginary + cImaginary;
		zReal = zReal2 - zImaginary2 + cReal;
	}

	return n;
}

__kernel void mandelbrot_kernel(
	__global char* bitmap,
	int columns,
	int rows,
	int center_col,
	int center_row,
	DOUBLE center_x,
	DOUBLE center_y,
	DOUBLE scale,
	int rowByteCount,
	int maxIterations
	)
{
	DOUBLE x;
	DOUBLE y;
	int n;
	uchar3 pixelColor;
	int row = get_global_id(1);
	int col = get_global_id(0);
	int max = rows * rowByteCount;
	int offset = row * rowByteCount + col * 3;

	if (row < rows && col < columns && offset < max) {

		x = scale * (col - center_col) + center_x;
		y = scale * (row - center_row) + center_y;
		n = iteratePoint(x, y, maxIterations);
		pixelColor = (n < maxIterations) ? colors[n % 16] : (uchar3) (0, 0, 0);

		bitmap[offset + 0] = pixelColor.z;
		bitmap[offset + 1] = pixelColor.y;
		bitmap[offset + 2] = pixelColor.x;
	}
}
