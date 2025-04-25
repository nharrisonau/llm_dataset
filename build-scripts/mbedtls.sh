#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
OUTPUT_DIR="$PROJECT_DIR/../../samples/original"

echo "🔧 Building mbedTLS..."

mkdir -p build
cmake -S . -B build -DCMAKE_INSTALL_PREFIX="$PROJECT_DIR/install" -DENABLE_TESTING=OFF -DUSE_SHARED_MBEDTLS_LIBRARY=OFF
cmake --build build -j$(nproc)
cmake --install build

mkdir -p "$OUTPUT_DIR"
cp install/lib/libmbedcrypto.a "$OUTPUT_DIR/libmbedcrypto.a"
cp install/lib/libmbedtls.a "$OUTPUT_DIR/libmbedtls.a"
cp install/lib/libmbedx509.a "$OUTPUT_DIR/libmbedx509.a"

echo "✅ Exported mbedTLS binaries."
