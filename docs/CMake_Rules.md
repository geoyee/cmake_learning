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

- CMake变量

| 语句 | 注释 |
| ---- | ---- |
| `PROJECT_BINARY_DIR` / `CMAKE_BINARY_DIR` / `<project_name>_BINARY_DIR` | 工程目标文件目录 |
| `PROJECT_SOURCE_DIR` / `CMAKE_SOURCE_DIR` / `<project_name>_SOURCE_DIR` | 工程源文件目录 |
| `CMAKE_CURRENT_BINARY_DIR` / `CMAKE_CURRENT_SOURCE_DIR` | 当前`CMakeLists.txt`所在的路径 |
| `CMAKE_CURRENT_LIST_FILE` | 输出调用这个变量的`CMakeLists.txt`的路径 |
| `CMAKE_CURRENT_LIST_LINE` | 输出调用这个变量的`CMakeLists.txt`的行号 |
| `EXECUTABLE_OUTPUT_PATH` | 二进制目标文件的输出路径 |
| `LIBRARY_OUTPUT_PATH` | 库目标文件的输出路径 |
| `CMAKE_INSTALL_PREFIX` | 目标文件的安装路径，默认为`usr/local/bin` |
| `CMAKE_MODULE_PATH` | 定义自己的CMake模块所在路径 |
| `PROJECT_NAME` | 通过`PROJECT`指令指定的项目名称 |
| `CMAKE_INCLUDE_CURRENT_DIR` | 自动添加`CMAKE_CURRENT_BINARY_DIR`和`CMAKE_CURRENT_SOURCE_DIR`到当前的`CMakeLists.txt`处理 |
| `CMAKE_INCLLUDE_DIRECTORIES_PROJECT_BEFORE` | 将工程提供的头文件目录始终置于系统头文件目录之前 |
| `CMAKE_MAJOR_VERSION` | CMake的主版本号 |
| `CMAKE_MINOR_VERSION` | CMake的次版本号 |
| `CMAKE_PATCH_VERSION` | CMake的补丁等级号 |
| `CMAKE_SYSTEM` | 系统全称 |
| `CMAKE_SYSTEM_NAME` | 系统名称 |
| `CMAKE_SYSTEM_VERSION` | 系统版本号 |
| `CMAKE_SYSTEM_PROCESSOR` | 系统处理器型号 |
| `UNIX` | 在所有的UNIX平台为TRUE，包括MacOS和Cygwin |
| `WIN32` | 在所有的WIN32平台为TRUE，包括Cygwin |
| `CMAKE_ALLOW_LOOSE_LOOP_CONSTRUCTS` | 控制IF ELSE书写方式的开关选项 |
| `BUILD_SHARED_LIBS` | 构建动态库的开关，默认为关闭（即构建静态库） |
| `CMAKE_C_FLAGS` | C编译选项 |
| `CMAKE_CXX_FLAGS` | C++编译选项 |

- CMake指令

| 语句 | 注释 |
| ---- | ---- |
| `PROJECT(<project_name>)` | 定义工程名，定义后自动添加两个变量`<project_name>_BINARY_DIR`和`<project_name>_SOURCE_DIR` |
| `SET(<var> <values>)` | 自定义变量，`<values>`可以是多个 |
| `MESSAGE([SEND_ERROR\|STATUS\|FATAL_ERROR] <message>)` | 输出消息，其中`SEND_ERROR`表示产生错误但跳过，`STATUS`表示输出一般信息，`FATAL_ERROR`则立即终止所有CMake过程 |
| `ADD_EXECUTABLE(<target> <source_file>)` | 增加可执行文件，由所有的`<source_file>`生成 |
| `ADD_SUBDIRECTORY(<source_dir>)` | 增加子目录 |
| `SUBDIRS(<dirs>)` | 一次性添加多个目录，即使外部编译，子目录体系依然被保存 |
| `INSTALL(TARGETS <targets> [ARCHIVE\|LIBRARY\|RUNTIME] [DESTINATION <dir>] [CONFIGGURATIONS [DUBUG\|RELEASE]] [...])` | 安装目标文件，其中`ARCHIVE`为静态库，`LIBRARY`为动态库，`RUNTIME`为可执行文件 |
| `INSTALL(FILES <files> [DESTINATION <dir>] [CONFIGGURATIONS [DUBUG\|RELEASE]] [...])` | 安装普通文件，默认为644权限 |
| `INSTALL(DIRECTORY <dirs> [DESTINATION <dir>] [CONFIGGURATIONS [DUBUG\|RELEASE]] [...])` | 安装目录，默认为644权限 |
| `ADD_LIBRARY(<lib_name> [SHARED\|STATIC\|MODULE] <sources>)` | 添加库，其中`MODULE`在使用dydl的系统有效，如果不支持dydl，默认为`SHARED` |
| `SET_TARGET_PROPERTIES(<targets> PROPERTIES <props and values>)` | 设置目标输出的名字和属性，由于TARGET名字不能重复，因此需要这个指令改名 |
| `GET_TARGET_PROPERTIES(<var> <target> <prop>)` | 获取目标的属性保存在变量中 |
| `$ENV{NAME}` | 调用系统环境变量 |
| `SET(ENV{NAME} <var>)` | 设置环境变量 |
| `ADD_DEFINITIONS(-D...)` | 向编译器添加-D定义 |
| `ADD_DEFINITIONS(<targer_name> <depend_targets>)` | 定义`<target>`依赖的其他`<target>` |
| `ADD_TEST(<test_name> <program> <args>)` | 添加测试，在启用`ENABEL_TESTING`后起效 |
| `ENABEL_TESTING` | 控制是否构建测试 |
| `AUX_SOURCE_DIRECTORY(<dir> <var>)` | 自动构建源文件列表 |
| `CMAKE_MINIMUM_REQUIRED(VERSION <version> [FATAL_ERROR])` | 检测CMake版本，不满足就提示或报错 |
| `EXEC_PROGRAM(<program> [ARGS <args>] [OUTPUT_VARIABLE <var>] [RETURN_VALUE <value>])` | 在文件夹运行某个程序 |
| `FILE([WRITE\|APPEND] <file_name> <text>)` | 写/追加文件 |
| `FILE(READ <file_name> <value>)` | 读文件 |
| `FILE(COPY <file_name> DESTINATION <dir>)` | 复制文件 |
| `FILE([REMOVE\|REMOVE_RECURSE] <dirs>)` | 移除/递归移除目录 |
| `FILE(MAKE_DIRECTORY <dir>)` | 创建目录 |
| `FILE([GLOB\|GLOB_RECURSE] <path> <globbing-expression>)` | 匹配/递归匹配规则在指定的目录内匹配到所需要的文件 |
| `INCLUDE([<file>\|<model>] [OPTIONAL])` | 用于载入`CMakeLists.txt`文件或CMake模块 |
| `FIND_FILE(<names> <path>)` | 查找文件 |
| `FIND_LIBRARY(<names> <path>)` | 查找库 |
| `FIND_PATH(<names> <path>)` | 查找路径 |
| `FIND_PROGRAM(<names> <path>)` | 查找程序 |
| `FIND_PACKAGE(<name> [<version>] [EXACT] [QUIET] [MODULE] [REQUIRED\|COMPONENTS] [components...])` | 查找第三方包 |


