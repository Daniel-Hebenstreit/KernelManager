# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appKernelManager_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appKernelManager_autogen.dir/ParseCache.txt"
  "appKernelManager_autogen"
  )
endif()
