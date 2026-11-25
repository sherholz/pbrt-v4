BUILD_TYPE=Release
#BUILD_TYPE=Debug
HIP_PATH=/opt/rocm
C_COMPILER=/opt/rocm/llvm/bin/clang
CXX_COMPILER=/opt/rocm/llvm/bin/clang++
ROCM_VERSION=7.17

#HIP_PATH=/usr
#C_COMPILER=/usr/bin/clang
#CXX_COMPILER=/usr/bin/clang++
#ROCM_VERSION=7.1

rm -rdf install
###################################
# Clean HipRT folder
###################################
rm -rdf src/ext/hiprt/dist
rm src/ext/hiprt/scripts/bitcodes/*.bc
rm src/ext/hiprt/scripts/bitcodes/*.hipfb
rm src/ext/hiprt/hiprt/hiprt.h
rm src/ext/hiprt/hiprt/hiprtew.h
rm src/ext/hiprt/tmp.*

###################################
# Build PBRT-v4 with Hip support
###################################
rm -rdf build
cmake -DCMAKE_C_COMPILER=${C_COMPILER} -DCMAKE_CXX_COMPILER=${CXX_COMPILER} -DCMAKE_INSTALL_PREFIX=./install -DPBRT_ROCM_VERSION=${ROCM_VERSION} -DHIP_PATH=${HIP_PATH} -DPBRT_HIPRT=ON -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=${BUILD_TYPE} -S . -B build
cmake --build build --config ${BUILD_TYPE}
cmake --install build
#make -j10
