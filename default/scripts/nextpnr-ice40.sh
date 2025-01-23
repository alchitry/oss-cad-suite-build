export PATH=${BUILD_DIR}/python3-native${INSTALL_PREFIX}/bin:$PATH
cd nextpnr
build_gui="OFF"

cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} \
      -DPython3_INCLUDE_DIR=${BUILD_DIR}/python3${INSTALL_PREFIX}/include/python3.11 \
      -DPython3_LIBRARY=${BUILD_DIR}/python3${INSTALL_PREFIX}/lib/libpython3.11${SHARED_EXT} \
      -DARCH=ice40 \
      -DIMPORT_BBA_FILES=${BUILD_DIR}/icestorm-bba/bba-files \
      -DBUILD_GUI=${build_gui} -DUSE_IPO=OFF \
      -DBBA_IMPORT=${BUILD_DIR}/nextpnr-bba/nextpnr/bba/bba-export.cmake \
      -B build

make -C build DESTDIR=${OUTPUT_DIR} -j${NPROC} install

${STRIP} ${OUTPUT_DIR}${INSTALL_PREFIX}/bin/nextpnr-ice40${EXE}
