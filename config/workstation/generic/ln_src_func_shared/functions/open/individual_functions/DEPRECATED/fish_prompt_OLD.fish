# do not "set -l" inside include files

function fish_prompt -d "left prompt config"
#-------------------------------------------------------------------------------
    # Cache exit status
    set -l last_status $status

    source $FISH_WKR_PROMPT_INC_DIR/01_colors.fish
    source $FISH_WKR_PROMPT_INC_DIR/02_host_and_prompt_char.fish
    source $FISH_WKR_PROMPT_INC_DIR/03_git.fish

    # Line 1
    # echo -n $red'┌'$cyan$USER$white'@'$cyan$__fish_prompt_hostname $gray(prompt_pwd)$normal
    echo -n $pcolor'┌' $purple$USER$magenta'@'$purple$__fish_prompt_hostname \
    $cyan(prompt_pwd)$normal
    if set -q VIRTUAL_ENV
      echo -n -s ' '(set_color -b green white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal)
    end
    __fish_git_prompt
    # Check for gwip; does last commit log contain --wip--?
    if begin; git log -n 1 ^/dev/null | grep -qc "\-\-wip\-\-"; end
      echo -n $brwhite' WIP!'$normal
    end
    echo

    # Line 2
    echo -n $pcolor'└' $pcolor2'('$last_status')'$__fish_prompt_char $normal

#-------------------------------------------------------------------------------
end # end function

#-------------------------------------------------------------------------------
# NOTES:
#-------------------------------------------------------------------------------

# some inspiration taken from the Yimmy theme:
# https://github.com/bpinto/oh-my-fish/blob/master/themes/yimmy/fish_prompt.fish
