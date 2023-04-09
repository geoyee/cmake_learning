# 查找头文件和库的路径
FIND_PATH(HELLO_INCLUDE_DIR hello.h /usr/include/hello /usr/local/include/hello ../../t4/usr/include/hello)
FIND_LIBRARY(HELLO_LIBRARY libhello.so /usr/lib /usr/local/lib ../../t4/usr/lib)

SET(CMAKE_ALLOW_LOOSE_LOOP_CONSTRUCTS ON)

IF(HELLO_INCLUDE_DIR AND HELLO_LIBRARY)
	IF(NOT HELLO_FIND_QUIETLY)
		MESSAGE(STATUS "Found hello include: " ${HELLO_INCLUDE_DIR})
		MESSAGE(STATUS "Found hello library: " ${HELLO_LIBRARY})
	ENDIF()
        SET(HELLO_FOUND TRUE)
ELSE()
	IF(HELLO_FIND_REQUIRED)
                MESSAGE(TATAL_ERROR "Could not find package named hello")
        ENDIF()
ENDIF()
