#!/usr/bin/env bash
# Script location
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
test_run="0"

# Parse arguments
while [[ $# -gt 0 ]]; do
   if [[ $1 == "--test_run" ]]; then
        test_run="1"
   fi
   shift
done

log(){
    if [[ $test_run == "1" ]]; then
        echo "[TEST_RUN]:" "$@"
    else
        echo "$@"
    fi
}

execute(){
    log "execute" "$@"
    if [[ $test_run == "1" ]]; then
        return    
    fi
    "$@"
}

cd "$SCRIPT_DIR"

copy_dir(){
    from="$1"
    to="$2"
    
    pushd "$from" > /dev/null
    dirs=$(find . -mindepth 1 -maxdepth 1 -type d)
    
    for dir in $dirs; do
        execute rm -rf "$to/$dir"
        execute cp -r "$dir" "$to/$dir"
    done
    
    popd > /dev/null
}

copy_file(){
    from="$1"
    to="$2"
    
    name=$(basename "$from")
    execute rm -f "$to/$name"
    execute cp "$from" "$to/$name"
}

# Determine target directory
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# Call the function
copy_dir ".config" "$XDG_CONFIG_HOME"
copy_file ".bashrc" "$HOME"
copy_file ".bash_profile" "$HOME"
copy_file ".bash_aliases" "$HOME"
copy_file ".xinitrc" "$HOME"
