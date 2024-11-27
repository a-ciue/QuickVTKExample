# QuickVTKExample: QFileLoader

## Prerequisites 前置条件

- Qt >= 6.5
- VTK >= 9.3.1
  - Debug VTK build needed when building in Debug mode
  - 在Debug模式构建项目时同样需要Debug模式构建的VTK

## Build 构建

### Normal Build 正常构建

```bash
cd QuickVTKExample
mkdir build
cd build
cmake .. "-DCMAKE_PREFIX_PATH=<qtdir>;<vtkdir>" -G<multiconfig_generator>
cmake --build . --config <config>
```

### Build With Presets and Visual Studio 使用Presets&Visual Studio构建

Modify cache variable `"CMAKE_PREFIX_PATH"` of `"windows-base"` preset in `CMakePresets.json`. Fill in the right dirs of Qt/VTK package.

修改`CMakePresets.json`里的`"CMAKE_PREFIX_PATH"`缓存变量，为Qt/VTK的正确安装位置。

## Install 安装

```bash
cd build
cmake --install . --config <config> --prefix <absolute_path_where_install>
```
> 安装时需要填写绝对路径
