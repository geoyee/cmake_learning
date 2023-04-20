#include <iostream>
#include <cmath>
#include "MathFunctions.h"

double mysqrt(const char* val)
{
	double inputValue = atof(val);
#if defined(HAVE_LOG) && defined(HAVE_EXP)
	std::cout << "[mysqrt] Use exp and log" << std::endl;
	double outputValue = exp(log(inputValue) * 0.5);
#else
	std::cout << "[mysqrt] Use sqrt" << std::endl;
	double outputValue = sqrt(inputValue);
#endif
	return outputValue;
}
