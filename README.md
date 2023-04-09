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
./hello  # 可以使用
```

3. 在`t2`的示例中，需要在`src/CMakeLists.txt`中添加`INSTALL`，否则在安装时无法把对应的二进制文件安装到与`runhello.sh`同目录下：

``` cmake
# 添加如下这句
INSTALL(TARGETS hello DESTINATION bin)
```

4. 在`t4`的示例中，`usr`文件夹来自`t3`示例安装的库，在`t3`的安装中使用了如下命令：
``` shell
cmake -DCMAKE_INSTALL_PREFIX=~/cmake_learning/t4/usr ..
make && make install
```

5. 在`t6`的示例中，使用`FIND_LIBRARY`时对于库没有指定后缀将找不到，如下：
``` cmake
# 找不到HELLO_LIBRARY
FIND_LIBRARY(HELLO_LIBRARY NAMES hello PATH /usr/lib /usr/local/lib)
# 指定查找动态链接库则可以找到
FIND_LIBRARY(HELLO_LIBRARY NAMES libhello.so PATH /usr/lib /usr/local/lib)
```
