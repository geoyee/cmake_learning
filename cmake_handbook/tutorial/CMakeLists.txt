CMAKE_MINIMUM_REQUIRED(VERSION 2.6 FATAL_ERROR)

PROJECT(sqrt)

# 设置版本号
SET(PROJECT_VERSION_MAJOR 2)
SET(PROJECT_VERSION_MINOR 0)

# 包含一个库，可以选择是否使用
OPTION(USE_MYMATH "Use math functions implemented by us" ON)
IF(USE_MYMATH)
	INCLUDE_DIRECTORIES("${PROJECT_SOURCE_DIR}/MathFunctions")
	ADD_SUBDIRECTORY(MathFunctions)
	# 需要的都放在`EXTRA_LIBS`中
	SET(EXTRA_LIBS ${EXTRA_LIBS} MathFunctions)
ENDIF(USE_MYMATH)

# 配置一个头文件，通过该文件向源码传递CMake设置
CONFIGURE_FILE(
	"${PROJECT_SOURCE_DIR}/ProjectConfig.h.in"
	"${PROJECT_BINARY_DIR}/ProjectConfig.h"
)

# 将二进制的文件树包含到文件的搜索路径中，这样才能找到ProjrctConfig.h
INCLUDE_DIRECTORIES("${PROJECT_BINARY_DIR}")

ADD_EXECUTABLE(sqrt sqrt.cpp)
# 向可执行文件中引入库
TARGET_LINK_LIBRARIES(sqrt ${EXTRA_LIBS})
