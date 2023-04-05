# cmake_learning

学习[**CMake Practice.pdf**](./CMake%20Practice.pdf)的入门记录。

## 环境

- 系统：WLS Ubuntu 22.04.2 LTS
- cmake版本：3.25.0

## 说明

1. 在`t1`示例中，使用`SET`创建变量后，使用时应该加上`${}`：

``` cmake
SET(SRC_FILES main.c)

# ADD_EXECUTABLE(hello SRC_FILES)  # 报错找不到SRC_FILES
ADD_EXECUTABLE(hello ${SRC_FILES})  # 可以使用
```

2. 在`t2`示例中，首先`runhello.sh`中的执行二进制文件前面需要加上当前路径：

``` shell
# hello  # 无法运行
./hello
```

3. 在`t2`的示例中，需要在`src/CMakeLists.txt`中添加`INSTALL`，否则在安装时无法把对应的二进制文件安装到与`runhello.sh`同目录下：

``` cmake
# 添加如下这句
INSTALL(TARGETS hello DESTINATION bin)
```
