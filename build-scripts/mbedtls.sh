#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
ROOT_DIR=$(realpath "$PROJECT_DIR/../../..")
OUTPUT_DIR="$ROOT_DIR/samples/original"

echo "🔧 Building mbedTLS in $PROJECT_DIR"

# Update all submodules (recursive)
git submodule update --init --recursive

# Create build directory
mkdir -p build
cmake -S . -B build \
  -DCMAKE_INSTALL_PREFIX="$PROJECT_DIR/install" \
  -DENABLE_PROGRAMS=ON \
  -DENABLE_TESTING=OFF \
  -DUSE_SHARED_MBEDTLS_LIBRARY=OFF

# Build and install
cmake --build build -j"$(nproc)"
cmake --install build

# Export built static libraries
mkdir -p "$OUTPUT_DIR"
# Export what exists
cp "$PROJECT_DIR/install/lib/libmbedtls.a"   "$OUTPUT_DIR/libmbedtls.a"
cp "$PROJECT_DIR/install/lib/libmbedx509.a"  "$OUTPUT_DIR/libmbedx509.a"
cp "$PROJECT_DIR/install/lib/libtfpsacrypto.a" "$OUTPUT_DIR/libtfpsacrypto.a"
cp "$PROJECT_DIR/install/lib/libp256m.a"       "$OUTPUT_DIR/libp256m.a"

echo "✅ Exported mbedTLS binaries."
