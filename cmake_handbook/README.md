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
