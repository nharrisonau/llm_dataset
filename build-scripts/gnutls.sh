#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
OUTPUT_DIR="$PROJECT_DIR/../../samples/original"

echo "🔧 Building GnuTLS..."

./bootstrap || true
./configure --disable-shared --enable-static --prefix="$PROJECT_DIR/build"
make -j$(nproc)
make install

mkdir -p "$OUTPUT_DIR"
cp build/lib/libgnutls.a "$OUTPUT_DIR/libgnutls.a"

echo "✅ Exported GnuTLS static lib."
