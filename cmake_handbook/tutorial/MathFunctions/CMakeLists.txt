SET(CMAKE_ALLOW_LOOSE_LOOP_CONSTRUCTS ON)

ADD_LIBRARY(MathFunctions mysqrt.cpp)

# 检查当前平台提供了log和exp函数吗
# CheckFunctionExists无法找到，需要在CMake3.0.2以上使用CheckSymbolExists
INCLUDE(CheckSymbolExists)
CHECK_SYMBOL_EXISTS(log "math.h" HAVE_LOG)
CHECK_SYMBOL_EXISTS(exp "math.h" HAVE_EXP)
# 有时一个库模块并不在平台上的标准库里，需要在编译时链接进来
IF(NOT(HAVE_LOG AND HAVE_EXP))
	# 清空
	UNSET(HAVE_LOG CACHE)
	UNSET(HAVE_EXP CACHE)
	# 连接进来重新找
	SET(CMAKE_REQUIRED_LIBRARIES "m")
	CHECK_SYMBOL_EXISTS(log "math.h" HAVE_LOG)
	CHECK_SYMBOL_EXISTS(exp "math.h" HAVE_EXP)
	IF(HAVE_LOG AND HAVE_EXP)
		TARGET_LINK_LIBRARIES(MathFunctions PRIVATE m)
		# 设置编译选项让源码知道
		TARGET_COMPILE_DEFINITIONS(MathFunctions PRIVATE HAVE_LOG HAVE_EXP)
	ENDIF()
ENDIF()

INSTALL(TARGETS MathFunctions DESTINATION bin)
INSTALL(FILES MathFunctions.h DESTINATION include)
