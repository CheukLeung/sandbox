# chown(1) completion                                      -*- shell-script -*-

_sandbox()
{
    local cur prev words cword 
    _init_completion || return

    for (( i=2; i <= COMP_CWORD; i++ )); do
        if [[ ${COMP_WORDS[i-1]} == -r ]] || [[ ${COMP_WORDS[i-1]} == --run ]]; then
            _command_offset $i
            return
        fi
    done

    case $prev in
        new|remove)
        		images=`sandbox list | grep ":" | cut -d ":" -f 1 | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"`
        		COMPREPLY=( $( compgen -W "$images" -- "$cur" ) )
        		return
        		;;
        run|save|stop)
         		containers=`sandbox list | grep " "`
        		COMPREPLY=( $( compgen -W "$containers" -- "$cur" ) )
        		return
        		;;
        build|list|help)
            # argument required but no completions available
            return
            ;;
    esac
		commands=`sandbox | grep usage | cut -d '{' -f2 | cut -d '}' -f1 | cut -d ',' --output-delimiter=' ' -f1-`
    COMPREPLY=( $( compgen -W "$commands" -- "$cur" ) )

} &&
complete -F _sandbox sandbox
