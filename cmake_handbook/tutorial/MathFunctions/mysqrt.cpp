#include <cmath>
#include "mysqrt.h"

double mysqrt(const char* val)
{
	double inputValue = atof(val);
	double outputValue = sqrt(inputValue);
	return outputValue;
}
