# CMake语法介绍

学习[cmake-rules.pdf](https://github.com/Akagi201/learning-cmake/blob/master/docs/cmake-rules.pdf)，自己手打一边印象更深刻，同时`md`文件方便修改错误。

## CMake特点

1. 在每个源码的目录下都存在一个`CMakeLists.txt`。
2. CMake语句不区分大小写，一句一行，无行结束符号，注释用`#`号。
3. CMake也是一种编程语言，根据CMakeLists.txt自动生成Makfile。
4. CMake比Autotools更简单明了。

## CMake语法

1. 变量使用`${}`进行取值，但在`IF`语句中直接使用变量名：

``` cmake
# 这三句等效
MESSAGE(STATUS "This is bin dir" ${PROJECT_BINARY_DIR})
MESSAGE(STATUS "This is bin dir ${PROJECT_BINARY_DIR}")
MESSAGE(STATUS "This is bin dir" "${PROJECT_BINARY_DIR}")

# 但在IF中直接使用变量名
IF(WIN32)
	# ...
ELSE(WIN32)
	# ...
ENDIF(WIN32)
```

2. 一条指令中的参数用空格` `或分号`;`隔开：

``` cmake
# 这两句等效
SET(SRC_LIST main.cpp hello.cpp)
SET(SRC_LIST main.cpp;hello.cpp)
```

3. 两种构建方式：

	- 内部构建（In-source）：编译过程文件与源码文件在同一目录下，在工程目录下执行`cmake .`即为内部构建。
	- 外部构建（Out-source）：编译过程文件在指定文件夹内，在工程目录下新建文件夹，如`build`，进入`build`后执行`cmake ..`即为外部构建。通常建议使用外部构建。

4. 常用变量及指令：

*...*
