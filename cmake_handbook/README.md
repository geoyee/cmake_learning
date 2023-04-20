# CMake Handbook

学习[**CMake Handbook.pdf**](./CMake_Handbook.pdf)的入门记录。

## 说明

1. 步骤3中的`make install`会遭遇错误：

```
CMake Error at cmake_install.cmake:xx (file):
  file INSTALL cannot copy file
  "xx/cmake_learning/cmake_handbook/tutorial/build/sqrt"
  to "/usr/local/bin/sqrt": Success.
```

这是因为在默认路径中移动需要权限，因此可以使用`sudo`或在`cmake`阶段指定`-DCMAKE_INSTALL_PREFIX`切换其他的文件夹。

2. 步骤4中的查找方法存在问题：

	- 首先`CHECK_FUNCTION_EXISTS`不适用，因为`log`和`exp`在多数平台上是内内联函数，在链接时无法检测到它们，需要使用`CHECK_SYMBOL_EXISTS`。

	- 直接使用`CHECK_SYMBOL_EXISTS`代替`CHECK_FUNCTION_EXISTS`并指定为查找`math.h`依旧找不到这两个函数，具体可以参考[这篇博客](https://zhuanlan.zhihu.com/p/525830239)进行修改。
