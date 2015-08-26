set -gx FISH_BASE_DIR               /z/750/dot/repos/shell-fish/config

set -gx FISH_FUNC_OUT_DIR           /home/rigel/Desktop/D2/00_output_global

set -gx FISH_ANY_CONF_DIR           $FISH_BASE_DIR/any/configs/open
set -gx FISH_ANY_FUNC_DIR           $FISH_BASE_DIR/any/functions/open

set -gx FISH_WRK_CONF_DIR           $FISH_BASE_DIR/workstation/generic/ln_src_conf_shared
set -gx FISH_WKR_FUNC_DIR           $FISH_BASE_DIR/workstation/generic/ln_src_func_shared/functions
set -gx FISH_WKR_FDAT_DIR           $FISH_BASE_DIR/workstation/generic/ln_src_func_shared/function_data
set -gx FISH_WKR_HIST_DIR           $FISH_BASE_DIR/workstation/generic/ln_src_hist
set -gx FISH_WKR_PROMPT_INC_DIR     $FISH_WKR_FUNC_DIR/open/fish_prompt_and_greet/inc

#···············································································
#   CONFIG MODULES TO INCLUDE
#       potentially concatenated into one file for a server
#···············································································

    #   ANY QUASI-SUB-REPO
source $FISH_ANY_CONF_DIR/colors.fish

    #   WOKRSTATION QUASI-SUB-REPO (OPEN)
source $FISH_WRK_CONF_DIR/open/os_test_and_cache.fish
source $FISH_WRK_CONF_DIR/open/paths_functions.fish
source $FISH_WRK_CONF_DIR/open/ssh_handling.fish

    #   WOKRSTATION QUASI-SUB-REPO (CLOSED)
source $FISH_WRK_CONF_DIR/closed/paths_commands.fish
source $FISH_WRK_CONF_DIR/closed/vars_and_aliases_closed.fish

#···············································································
#   MISC VARIABLES
#···············································································

set -gx EDITOR                  nano
set -gx SUBLIME_PROJECTS_DIR    /home/rigel/.config/sublime_projects

# on Ubuntu, create symlinks to make paths conform to below:
set -gx EXTERNAL_DRIVES_BASE    /run/media/rigel
set -gx EXTERNAL_MULTIMEDIA     $EXTERNAL_DRIVES_BASE/wmst/nol/mm
