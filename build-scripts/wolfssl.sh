#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
ROOT_DIR=$(realpath "$PROJECT_DIR/../../..")
OUTPUT_DIR="$ROOT_DIR/samples/original"

echo "🔧 Building wolfSSL with available example programs..."

./autogen.sh || true
./configure --enable-static --disable-shared --enable-examples --prefix="$PROJECT_DIR/build"
make -j$(nproc)
make install

mkdir -p "$OUTPUT_DIR"

# Copy working examples

cp examples/client/client "$OUTPUT_DIR/wolfssl_client"
cp examples/server/server "$OUTPUT_DIR/wolfssl_server"


echo "✅ Exported wolfSSL example binaries."
