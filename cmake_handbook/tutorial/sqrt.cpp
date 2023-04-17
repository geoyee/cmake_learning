#include <iostream>
#include <cmath>
#include "ProjectConfig.h"  // 导入版本号

int main(int argc, char** argv)
{
	std::cout << "CURRENT SQRT VERSION: " << PROJECT_VERSION_MAJOR << "." << PROJECT_VERSION_MINOR << std::endl;
	if (argc != 2)
	{
		std::cerr << "Usage: " << argv[0] << " number" << std::endl;
		return 1;
	}
	double inputValue = atof(argv[1]);
	double outputValue = sqrt(inputValue);
	std::cout << "The square root of " << inputValue << " is " << outputValue << std::endl;
	return 0;
}
