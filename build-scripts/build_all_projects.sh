#!/bin/bash
set -e
set -x  # Debugging

ROOT_DIR=$(pwd)
PROJECTS_DIR="$ROOT_DIR/projects"
ORIG_DIR="$ROOT_DIR/samples/original"
STRIP_DIR="$ROOT_DIR/samples/stripped"

# Ensure output directories exist
mkdir -p "$ORIG_DIR"
mkdir -p "$STRIP_DIR"

echo "🔧 [1/3] Building all submodules and exporting binaries..."

echo "📚 Initializing git submodules..."
git submodule update --init --recursive

for project in "$PROJECTS_DIR"/*/*; do
  if [ -d "$project" ]; then
    NAME=$(basename "$project")
    BUILD_SCRIPT="$ROOT_DIR/build-scripts/${NAME}.sh"

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

if compgen -G "$ORIG_DIR/*" > /dev/null; then
  cp "$ORIG_DIR"/* "$STRIP_DIR"/
else
  echo "⚠️  No binaries found in $ORIG_DIR — skipping copy step"
fi

echo -e "\n✂️ [3/3] Stripping binaries..."

for bin in "$STRIP_DIR"/*; do
  if file "$bin" | grep -q 'executable\|ELF'; then
    strip --strip-unneeded "$bin" || echo "⚠️  Could not strip: $(basename "$bin")"
  else
    echo "ℹ️  Skipped non-binary: $(basename "$bin")"
  fi
done

echo -e "\n✅ All builds complete. Stripped binaries are in: $STRIP_DIR"
