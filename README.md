# cmake_learning

学习[**CMake Practice.pdf**](./CMake%20Practice.pdf)的入门记录。

## 环境

- 系统：WLS Ubuntu 22.04.2 LTS
- cmake版本：3.25.0

## 勘误

1. 使用`SET`创建变量后，使用时应该加上`${}`，如：
``` cmake
SET(SRC_LIST main.c)

# ADD_EXECUTABLE(hello SRC_LIST)  # 报错找不到SRC_LIST
ADD_EXECUTABLE(hello ${SRC_LIST})  # 可以使用
```
