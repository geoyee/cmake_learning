# CMake Handbook

学习[**CMake Handbook.pdf**](./CMake_Handbook.pdf)的入门记录。

## 说明

1. 在步骤2中，导入`MathFunctions.h`报错找不到，可以修改为`MathFunctions/mysqrt.h`:

``` cpp
#ifdef USE_MYMATH 
// #include "MathFunctions.h"  // 找不大
#include "MathFunctions/mysqrt.h"  // 可以使用
#endif
```
