#!/bin/bash
set -e

PROJECT_DIR=$(pwd)
ROOT_DIR=$(realpath "$PROJECT_DIR/../../..")
OUTPUT_DIR="$ROOT_DIR/samples/original"

echo "🔧 Building OpenSSH in $PROJECT_DIR"

# Regenerate autotools files
autoreconf -fi

# Preserve debug symbols and override default -s stripping
export CFLAGS="-g -O2"
export CPPFLAGS="-I/usr/include -I/usr/include/x86_64-linux-gnu"
export LDFLAGS="-L/usr/lib/x86_64-linux-gnu"

# Configure without automatic strip
./configure \
    --without-openssl-header-check \
    --prefix="$PROJECT_DIR/build" \
    --with-privsep-path="$PROJECT_DIR/build/empty"

# Build
make -j"$(nproc)"

# Install but disable any strip steps
# Clearing STRIP and EXECS_STRIP prevents automake from running 'strip'
make install STRIP="" EXECS_STRIP=""

# Copy the resulting binaries (fall back to .libs if present)
mkdir -p "$OUTPUT_DIR"
if [ -x "$PROJECT_DIR/build/sbin/sshd" ]; then
  cp "$PROJECT_DIR/build/sbin/sshd" "$OUTPUT_DIR/sshd"
elif [ -x "$PROJECT_DIR/build/sbin/.libs/sshd" ]; then
  cp "$PROJECT_DIR/build/sbin/.libs/sshd" "$OUTPUT_DIR/sshd"
fi

if [ -x "$PROJECT_DIR/build/bin/ssh" ]; then
  cp "$PROJECT_DIR/build/bin/ssh" "$OUTPUT_DIR/ssh"
elif [ -x "$PROJECT_DIR/build/bin/.libs/ssh" ]; then
  cp "$PROJECT_DIR/build/bin/.libs/ssh" "$OUTPUT_DIR/ssh"
fi

echo "✅ Exported OpenSSH binaries to $OUTPUT_DIR"
