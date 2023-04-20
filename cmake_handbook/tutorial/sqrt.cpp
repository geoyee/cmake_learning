#include <iostream>
#include <cmath>
#include "ProjectConfig.h"  // 导入版本号

// 是否使用自己的数据库
#ifdef USE_MYMATH
#include "MathFunctions.h"
#endif

int main(int argc, char** argv)
{
	std::cout << "CURRENT SQRT VERSION: " << PROJECT_VERSION_MAJOR << "." << PROJECT_VERSION_MINOR << std::endl;
	if (argc != 2)
	{
		std::cerr << "Usage: " << argv[0] << " number" << std::endl;
		return 1;
	}
#ifdef USE_MYMATH
	std::cout << "[sqrt] Use mysqrt" << std::endl;
	double outputValue = mysqrt(argv[1]);
#else
	std::cout << "[sqrt] Use atof and sqrt" << std::endl;
	double inputValue = atof(argv[1]);
	double outputValue = sqrt(inputValue);
#endif
	std::cout << "The square root of " << argv[1] << " is " << outputValue << std::endl;
	return 0;
}
