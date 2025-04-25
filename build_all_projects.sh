#!/bin/bash
# build_all_projects.sh
set -e

ROOT_DIR=$(pwd)
ORIG_DIR="$ROOT_DIR/samples/original"
STRIP_DIR="$ROOT_DIR/samples/stripped"

# Ensure output directories exist
mkdir -p "$ORIG_DIR"
mkdir -p "$STRIP_DIR"

echo "🔧 [1/3] Building all submodules and exporting binaries..."

for project in projects/*/*; do
  if [ -d "$project" ]; then
    NAME=$(basename "$project")
    BUILD_SCRIPT="$ROOT_DIR/build-scripts/$NAME.sh"

    if [ -f "$BUILD_SCRIPT" ]; then
      echo -e "\n🛠️ Building $NAME"
      pushd "$project" > /dev/null
      bash "$BUILD_SCRIPT"
      popd > /dev/null
    else
      echo "⚠️  No build script for $NAME — skipping"
    fi
  fi
done

echo -e "\n📦 [2/3] Copying original binaries to stripped directory..."

mkdir -p "$STRIP_DIR"
cp "$ORIG_DIR"/* "$STRIP_DIR"/

echo -e "\n✂️ [3/3] Stripping binaries..."

for bin in "$STRIP_DIR"/*; do
  if file "$bin" | grep -q 'executable\|ELF'; then
    strip --strip-unneeded "$bin" || echo "⚠️  Could not strip: $(basename "$bin")"
  else
    echo "ℹ️  Skipped non-binary: $(basename "$bin")"
  fi
done

echo -e "\n✅ All builds complete. Stripped binaries are in: $STRIP_DIR"
