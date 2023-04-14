# 引入头文件搜索路径
INCLUDE_DIRECTORIES(../usr/include/hello)
# 引入库所搜路径
LINK_DIRECTORIES(../usr/lib)

ADD_EXECUTABLE(usehello main.cpp)
# 链接动态库
TARGET_LINK_LIBRARIES(usehello libhello.so)
# 链接静态库
# TARGET_LINK_LIBRARIES(usehello libhello.a)
