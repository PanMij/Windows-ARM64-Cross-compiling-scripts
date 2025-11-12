
# 交叉编译方法

## 工作区结构

```text
.
├── Cross-compiling.md
├── arm-gnu-toolchain-14.3.rel1-mingw-w64-x86_64-aarch64-none-linux-gnu
├── build.bat
├── clean.bat
├── include
├── lib
├── main.c
└── src
```

`arm-gnu-toolchain-14.3.rel1-mingw-w64-x86_64-aarch64-none-linux-gnu`为交叉编译工具链目录，`include`目录存放头文件，`lib`目录存放动态库，`src`目录存放动态库源文件。`build.bat`为编译脚本，`clean.bat`为清理脚本，`main.c`为主程序。

## 编译命令

1. 将动态库的源文件编译为目标文件：

    ```bash
    path/to/cross-compiler-gcc -fPIC -Iinclude -c src/add.c -o src/add.o
    path/to/cross-compiler-gcc -fPIC -Iinclude -c src/sub.c -o src/sub.o
    ```

2. 将目标文件打包为动态库：

    ```bash
    path/to/cross-compiler-gcc -shared -o lib/libcalc.so src/add.o src/sub.o
    ```

3. 编译主程序并链接动态库：

    ```bash
    path/to/cross-compiler-gcc -Iinclude -Llib -lcalc main.c -o main
    ```

4. 运行主程序：

    ```bash
    ./main
    ```

    **注意**：运行主程序时可能会出现类似报错：  

    ```text
    ./main: error while loading shared libraries: libcalc.so: cannot open shared object file: No such file or directory
    ```

    这是因为系统找不到动态库`libcalc.so`，需要设置环境变量`LD_LIBRARY_PATH`，指定动态库的路径：

    ```bash
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/path/to/lib/directory
    ```

## 动态链接库编译脚本

动态链接库的编译脚本位于工作区根目录下，文件名为`build.bat`。  
该编译脚本可以自动编译`src`目录下的所有`.c`源文件，并将生成的目标文件打包为动态链接库，存放在`lib`目录下。  

动态链接库的清理脚本位于工作区根目录下，文件名为`clean.bat`。  
该清理脚本可以自动删除`src`目录下的所有`.o`目标文件，以及`lib`目录下的动态链接库文件。
