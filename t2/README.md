# HELLO

这是关于`hello`工程的说明文件。

## 外部编译

1. 进入到`build`文件夹：

``` shell
cd build
```

2. 使用`CMAKE_INSTALL_PREFIX`参数将工程安装到`/tmp/t2`目录：

``` shell
cmake -DCMAKE_INSTALL_PREFIX=/tmp/t2/usr ..
```

3. 使用`make`安装：

``` shell
make
make install
```
