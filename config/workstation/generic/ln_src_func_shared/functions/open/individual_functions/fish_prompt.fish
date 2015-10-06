function fish_prompt -d "left prompt config"
#-------------------------------------------------------------------------------
    # Cache exit status
    set -l last_status $status

#···············································································
#   01. SET COLORS (EXCLUDING GIT PROMPT)
#···············································································
    set normal      (set_color normal)

    set red         (set_color red)
    set brred       (set_color -o red)

    set cyan        (set_color 00A7B3)
    set brcyan      (set_color -o 00A7B3)

    set white       (set_color white)
    set brwhite     (set_color -o white)

    set green       (set_color -o 66FF00)
    set magenta     (set_color -o F143E9)
    set purple      (set_color -o AB32C9)

    # set -l orange (set_color E05500)
    set orange      (set_color FF7E00)
    set brorange    (set_color -o FF7E00)
    # (set_color E05500 -o)     # AN ORANGE VARIATION

    set yellow (set_color FFFF00)
    set bryellow (set_color -o FFFF00)


    # COLOR PROMPT CHARACTER RED FOR NON-ZERO EXIT STATUS
    set EXIT_COLOR_ZERO     (set_color B45900 -o)
    set EXIT_COLOR_NONZERO  (set_color B41500 -o)

    if test $last_status -ne 0
        set EXIT_COLOR $EXIT_COLOR_NONZERO
    else
        set EXIT_COLOR $EXIT_COLOR_ZERO
    end # end if


#···············································································
#   02. SET PROMPT HOSTNAME ANF CHARACTER
#···············································································

# Just calculate these once, to save a few cycles
# when displaying the prompt

    if not set -q __fish_prompt_hostname
        set __fish_prompt_hostname (hostname|cut -d . -f 1)
    end # end if

    if not set -q __fish_prompt_char
        switch (id -u)
            case 0
                set __fish_prompt_char '#'
            case '*'
            set __fish_prompt_char '>'
        end # end switch
    end # end if


#···············································································
#   03. SET GIT PROMPT STUFF
#···············································································

    # colors don't show up without "set -g"
    #-----------------------------------------------------------
    # FROM YIMMY THEME:
    #-----------------------------------------------------------
    # Configure __fish_git_prompt
    # set -g __fish_git_prompt_showdirtystate true
    # set -g __fish_git_prompt_showuntrackedfiles true
    # set -g __fish_git_prompt_showstashstate true
    # set -g __fish_git_prompt_color green
    # set -g __fish_git_prompt_color_flags red
    #-----------------------------------------------------------

    # https://github.com/fish-shell/fish-shell/blob/master/share/functions/__fish_git_prompt.fish

    # fish git prompt components
    # set -g __fish_git_prompt_show_informative_status true
    set -g __fish_git_prompt_showdirtystate true
    set -g __fish_git_prompt_showuntrackedfiles true
    set -g __fish_git_prompt_showstashstate true
    set -g __fish_git_prompt_showupstream verbose name

    # set -g __fish_git_prompt_describe_style contains

    # fish git prompt colors
    # set -g __fish_git_prompt_color green
    set -g __fish_git_prompt_color 66FF00
    set -g __fish_git_prompt_color_flags red
    set -g __fish_git_prompt_color_branch E5FF00

    # git status characters
    # set -g __fish_git_prompt_char_upstream_prefix '| '
    # set -g __fish_git_prompt_char_stateseparator ' |'

    set -g __fish_git_prompt_char_dirtystate '⚡'
    set -g __fish_git_prompt_char_stagedstate '→'
    set -g __fish_git_prompt_char_stashstate '↩'
    set -g __fish_git_prompt_char_upstream_ahead '↑'
    set -g __fish_git_prompt_char_upstream_behind '↓'

#···············································································

    # source $FISH_WKR_PROMPT_INC_DIR/03_git.fish

#···············································································

    # Line 1
    
    echo -n\
    (set_color normal)(set_color B45900 -o)(date +"%s")\
    (set_color normal)(set_color B47D00 -o)'tty'(basename (tty))\
    (set_color normal)(set_color 004454 -o)'@'$__fish_prompt_hostname\
    (set_color normal)(set_color B47D00 -o)(prompt_pwd)
    if set -q VIRTUAL_ENV
      echo -n -s ' '(set_color -b 00651B FFFFFF) \
      "(" (basename "$VIRTUAL_ENV") ")" (set_color normal)
    end
    __fish_git_prompt
    # Check for gwip; does last commit log contain --wip--?
    if begin; git log -n 1 ^/dev/null | grep -qc "\-\-wip\-\-"; end
      echo -n $brwhite' WIP!'$normal
    end
    echo

    # Line 2
    echo -n \
    $EXIT_COLOR$last_status\
    (set_color normal)(set_color B47D00 -o)$USER$EXIT_COLOR' '$__fish_prompt_char" "(set_color normal)

#-------------------------------------------------------------------------------
end # end function

#-------------------------------------------------------------------------------
# NOTES:
#-------------------------------------------------------------------------------

# http://paletton.com/#uid=53n0u0k++aX+cmA+Yg+++3a++00

# some inspiration taken from the Yimmy theme:
# https://github.com/bpinto/oh-my-fish/blob/master/themes/yimmy/fish_prompt.fish
