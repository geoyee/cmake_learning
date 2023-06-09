CMAKE_MINIMUM_REQUIRED(VERSION 3.0.2 FATAL_ERROR)

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

# 安装目标
INSTALL(TARGETS sqrt DESTINATION bin)
INSTALL(FILES "${PROJECT_BINARY_DIR}/ProjectConfig.h" DESTINATION include)

# 可以在CMake中进行测试
# 定义宏简化测试过程
MACRO(DO_TEST ARG RESULT)
	ADD_TEST(SQRT${ARG} sqrt ${ARG})
	SET_TESTS_PROPERTIES(SQRT${ARG} PROPERTIES PASS_REGULAR_EXPRESSION ${RESULT})
	MESSAGE(STATUS "[TEST PASS]: SQRT${ARG}")
ENDMACRO(DO_TEST)
# 进行测试
# 1. 是否正常运行
DO_TEST(25, "25 is 5")
# 2. 是否能处理负数
DO_TEST(-9, "-9 is 0")
# 3. 是否能处理小数
DO_TEST(0.0001, "0.0001 is 0.01")
# 4. 用法信息是否可用（也可以不使用上述宏）
ADD_TEST(USAGE sqrt)
SET_TESTS_PROPERTIES(USAGE PROPERTIES PASS_REGULAR_EXPRESSION "Usage: .* number")
MESSAGE(STATUS "[TEST PASS]: USAGE")

# 添加CPack打包
INCLUDE(InstallRequiredSystemLibraries)
SET(CPACK_RESOURCE_FILE_LINCENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
SET(CPACK_PACKAGE_VERSION_MAJOR "${PROJECT_VERSION_MAJOR}")
SET(CPACK_PACKAGE_VERSION_MINOR "${PROJECT_VERSION_MINOR}")
INCLUDE(CPack)
