#!/bin/bash

#
# Usage:
#     dev_base
#
dev_base() {
    declare base="$0" cfg

    [ -L "$base" ] && base=$(readlink -f $base)
    base=$(dirname $(realpath $base))

    if [ "$(basename $base)" == "bin" ]; then
        declare -gr glb_base="$(dirname $base)"
    else
        declare -gr glb_base="$base"
    fi
}

dev_base && source "$glb_base/lib/dispatch"
