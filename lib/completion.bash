# Copyright 2016 The dev Authors. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.


# COMPREPLY: array holds the completion results that gets displayed after
#             pressing [TAB][TAB]
#
# COMP_WORDS: array of words that is typed on the command line
#
# COMP_CWORD: index for the COMP_WORDS array and using this different position
#             words on command line can be accessed.
#
# compgen : -W holds the possible completions and the respective argument get
#           chosen based on the $current_arg.
#
# By convention, the function name starts with an underscore.
# .bash_completion
# source ./lib/completion.bash


#
# dev completion
#
_dev_init_completion() {
    # Pointer to current completion word.
    # By convention, it's named "cur" but this isn't strictly necessary.
    local arr cur prev opts

    COMPREPLY=() # Array variable storing the possible completions.
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}

    if [ "${cur:0:1}" == "-" ]; then
        opts=$(dev ":options" 2>/dev/null) #
    else
        arr=(${COMP_WORDS[@]})
        unset arr[COMP_CWORD]
        [ "${arr[0]}" == "dev" ] && unset arr[0]
        # echo "cur:$cur" >&2
        # echo "arr:${arr[@]:1}" >&2
        opts=$(dev ":completion" ":$cur" "${arr[@]}" 2>/dev/null) #
    fi

    COMPREPLY=( $(compgen -W "$opts" -- "$cur" ) );
}

complete -F _dev_init_completion dev
