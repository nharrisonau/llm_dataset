#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
ROOT_DIR=$(realpath "$PROJECT_DIR/../../..")
OUTPUT_DIR="$ROOT_DIR/samples/original"

echo "🔧 Building OpenSSL..."

./Configure linux-x86_64 no-shared --prefix="$PROJECT_DIR/build"
make -j$(nproc)
make install_sw

mkdir -p "$OUTPUT_DIR"
cp "$PROJECT_DIR/build/bin/openssl"       "$OUTPUT_DIR/openssl"

echo "✅ Exported OpenSSL binaries."
