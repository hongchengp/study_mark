# CMAKE generated file: DO NOT EDIT!
# Generated by "MinGW Makefiles" Generator, CMake Version 3.27

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

SHELL = cmd.exe

# The CMake executable.
CMAKE_COMMAND = D:\cmake\cmake-3.27.0-rc4-windows-x86_64\bin\cmake.exe

# The command to remove a file.
RM = D:\cmake\cmake-3.27.0-rc4-windows-x86_64\bin\cmake.exe -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = C:\Users\鲸云雾起\Desktop\学习笔记\c++\EffectiveModernCppChinese-master

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = C:\Users\鲸云雾起\Desktop\学习笔记\c++\EffectiveModernCppChinese-master\build

# Include any dependencies generated for this target.
include 1.DeducingTypes/CMakeFiles/base3.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include 1.DeducingTypes/CMakeFiles/base3.dir/compiler_depend.make

# Include the progress variables for this target.
include 1.DeducingTypes/CMakeFiles/base3.dir/progress.make

# Include the compile flags for this target's objects.
include 1.DeducingTypes/CMakeFiles/base3.dir/flags.make

1.DeducingTypes/CMakeFiles/base3.dir/base3.cpp.obj: 1.DeducingTypes/CMakeFiles/base3.dir/flags.make
1.DeducingTypes/CMakeFiles/base3.dir/base3.cpp.obj: C:/Users/鲸云雾起/Desktop/学习笔记/c++/EffectiveModernCppChinese-master/1.DeducingTypes/base3.cpp
1.DeducingTypes/CMakeFiles/base3.dir/base3.cpp.obj: 1.DeducingTypes/CMakeFiles/base3.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=C:\Users\鲸云雾起\Desktop\学习笔记\c++\EffectiveModernCppChinese-master\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object 1.DeducingTypes/CMakeFiles/base3.dir/base3.cpp.obj"
	cd /d C:\Users\鲸云雾起\Desktop\学习笔记\c++\EffectiveModernCppChinese-master\build\1.DeducingTypes && D:\mingw\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT 1.DeducingTypes/CMakeFiles/base3.dir/base3.cpp.obj -MF CMakeFiles\base3.dir\base3.cpp.obj.d -o CMakeFiles\base3.dir\base3.cpp.obj -c C:\Users\鲸云雾起\Desktop\学习笔记\c++\EffectiveModernCppChinese-master\1.DeducingTypes\base3.cpp

1.DeducingTypes/CMakeFiles/base3.dir/base3.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/base3.dir/base3.cpp.i"
	cd /d C:\Users\鲸云雾起\Desktop\学习笔记\c++\EffectiveModernCppChinese-master\build\1.DeducingTypes && D:\mingw\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E C:\Users\鲸云雾起\Desktop\学习笔记\c++\EffectiveModernCppChinese-master\1.DeducingTypes\base3.cpp > CMakeFiles\base3.dir\base3.cpp.i

1.DeducingTypes/CMakeFiles/base3.dir/base3.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/base3.dir/base3.cpp.s"
	cd /d C:\Users\鲸云雾起\Desktop\学习笔记\c++\EffectiveModernCppChinese-master\build\1.DeducingTypes && D:\mingw\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S C:\Users\鲸云雾起\Desktop\学习笔记\c++\EffectiveModernCppChinese-master\1.DeducingTypes\base3.cpp -o CMakeFiles\base3.dir\base3.cpp.s

# Object files for target base3
base3_OBJECTS = \
"CMakeFiles/base3.dir/base3.cpp.obj"

# External object files for target base3
base3_EXTERNAL_OBJECTS =

1.DeducingTypes/base3.exe: 1.DeducingTypes/CMakeFiles/base3.dir/base3.cpp.obj
1.DeducingTypes/base3.exe: 1.DeducingTypes/CMakeFiles/base3.dir/build.make
1.DeducingTypes/base3.exe: 1.DeducingTypes/CMakeFiles/base3.dir/linkLibs.rsp
1.DeducingTypes/base3.exe: 1.DeducingTypes/CMakeFiles/base3.dir/objects1.rsp
1.DeducingTypes/base3.exe: 1.DeducingTypes/CMakeFiles/base3.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=C:\Users\鲸云雾起\Desktop\学习笔记\c++\EffectiveModernCppChinese-master\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable base3.exe"
	cd /d C:\Users\鲸云雾起\Desktop\学习笔记\c++\EffectiveModernCppChinese-master\build\1.DeducingTypes && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles\base3.dir\link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
1.DeducingTypes/CMakeFiles/base3.dir/build: 1.DeducingTypes/base3.exe
.PHONY : 1.DeducingTypes/CMakeFiles/base3.dir/build

1.DeducingTypes/CMakeFiles/base3.dir/clean:
	cd /d C:\Users\鲸云雾起\Desktop\学习笔记\c++\EffectiveModernCppChinese-master\build\1.DeducingTypes && $(CMAKE_COMMAND) -P CMakeFiles\base3.dir\cmake_clean.cmake
.PHONY : 1.DeducingTypes/CMakeFiles/base3.dir/clean

1.DeducingTypes/CMakeFiles/base3.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MinGW Makefiles" C:\Users\鲸云雾起\Desktop\学习笔记\c++\EffectiveModernCppChinese-master C:\Users\鲸云雾起\Desktop\学习笔记\c++\EffectiveModernCppChinese-master\1.DeducingTypes C:\Users\鲸云雾起\Desktop\学习笔记\c++\EffectiveModernCppChinese-master\build C:\Users\鲸云雾起\Desktop\学习笔记\c++\EffectiveModernCppChinese-master\build\1.DeducingTypes C:\Users\鲸云雾起\Desktop\学习笔记\c++\EffectiveModernCppChinese-master\build\1.DeducingTypes\CMakeFiles\base3.dir\DependInfo.cmake "--color=$(COLOR)"
.PHONY : 1.DeducingTypes/CMakeFiles/base3.dir/depend

