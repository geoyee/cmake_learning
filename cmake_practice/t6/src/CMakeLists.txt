FIND_PACKAGE(HELLO REQUIRED)

IF(HELLO_FOUND)
	INCLUDE_DIRECTORIES(${HELLO_INCLUDE_DIR})
	ADD_EXECUTABLE(hello main.cpp)
	TARGET_LINK_LIBRARIES(hello ${HELLO_LIBRARY})
ENDIF(HELLO_FOUND)
