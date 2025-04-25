#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
OUTPUT_DIR="$PROJECT_DIR/../../samples/original"

echo "🔧 Building OpenSSL..."

./Configure linux-x86_64 no-shared --prefix="$PROJECT_DIR/build"
make -j$(nproc)
make install_sw

mkdir -p "$OUTPUT_DIR"
cp build/bin/openssl "$OUTPUT_DIR/openssl"
cp build/lib/libcrypto.a "$OUTPUT_DIR/libcrypto.a"
cp build/lib/libssl.a "$OUTPUT_DIR/libssl.a"

echo "✅ Exported OpenSSL binaries."
