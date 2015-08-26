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
