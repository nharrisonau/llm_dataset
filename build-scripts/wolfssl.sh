#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
OUTPUT_DIR="$PROJECT_DIR/../../samples/original"

echo "🔧 Building wolfSSL..."

./autogen.sh || true  # Some versions require autogen
./configure --enable-static --disable-shared --prefix="$PROJECT_DIR/build"
make -j$(nproc)
make install

mkdir -p "$OUTPUT_DIR"
cp build/lib/libwolfssl.a "$OUTPUT_DIR/libwolfssl.a"

echo "✅ Exported wolfSSL binaries."
