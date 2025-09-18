#!/bin/bash

SOURCE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_DIR="$SOURCE_ROOT/build-scripts"
BUILD_ERRORS=0

load_and_build() {
    local script_path="$1"
    local script_name=$(basename "$script_path" .sh)
    
    echo "Processing: $script_name"
    
    # Create subshell to isolate each script's environment
    (
        source "$script_path" || exit 1
        
        if declare -f build > /dev/null; then
            echo "Running build for $script_name..."
            build || exit 1
        else
            echo "Warning: No build function in $script_name"
            exit 1
        fi
    )
    
    local exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
        echo "Error in $script_name (exit code: $exit_code)"
        ((BUILD_ERRORS++))
    fi
    
    echo "---"
}

main() {
    export INSTALL_PREFIX="${INSTALL_PREFIX:-$(pwd)/deps}"
    mkdir -p "$INSTALL_PREFIX"
    
    if [[ -z "$BUILD_PATH" ]]; then
        export BUILD_PATH=$(mktemp -d -t cxx-dependency-build)
    else
        mkdir -p "$BUILD_PATH"
    fi

    export SOURCE_ROOT="$SOURCE_ROOT"
    
    echo "Starting build process with INSTALL_PREFIX=$INSTALL_PREFIX BUILD_PATH=$BUILD_PATH"
    
    # Check if script directory exists
    if [[ ! -d "$SCRIPT_DIR" ]]; then
        echo "Error: Script directory '$SCRIPT_DIR' not found!"
        exit 1
    fi
    
    # Process all shell scripts
    shopt -s nullglob  # Handle case where no .sh files exist
    for script in "$SCRIPT_DIR"/*.sh; do
        load_and_build "$script"
    done
    
    # Report results
    if [[ $BUILD_ERRORS -eq 0 ]]; then
        echo "✓ All builds completed successfully!"
    else
        echo "✗ Build completed with $BUILD_ERRORS errors"
        exit 1
    fi
}

main "$@"
