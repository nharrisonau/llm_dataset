#!/bin/bash
set -e
set -x

PROJECT_DIR=$(pwd)
ROOT_DIR=$(realpath "$PROJECT_DIR/../../..")
OUTPUT_DIR="$ROOT_DIR/samples/original"

echo "🔧 Building OpenSSH in $PROJECT_DIR"

autoreconf -fi

CPPFLAGS="-I/usr/include -I/usr/include/x86_64-linux-gnu" \
LDFLAGS="-L/usr/lib/x86_64-linux-gnu" \
./configure --without-openssl-header-check --prefix="$PROJECT_DIR/build" --with-privsep-path="$PROJECT_DIR/build/empty"

make -j"$(nproc)"
make install

mkdir -p "$OUTPUT_DIR"
cp "$PROJECT_DIR/build/sbin/sshd" "$OUTPUT_DIR/sshd"
cp "$PROJECT_DIR/build/bin/ssh" "$OUTPUT_DIR/ssh"

echo "✅ Exported OpenSSH binaries."
