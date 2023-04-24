#include <iostream>
#include <fstream>
#include <cmath>

int main(int argc, char** argv)
{
	if (argc < 2)
		return 1;
	std::ofstream fout(argv[1], std::ios::out);
	if (!fout)
		return 1;
	fout << "double sqrtTable[] = {\n";
	double result = 0;
	for (int i = 0; i < 10; ++i)
	{
		result = sqrt(static_cast<double>(i));
		fout << "\t" << i << ",\n";
	}
	fout << "}" << std::endl;
	fout.close();

	return 0;
}
