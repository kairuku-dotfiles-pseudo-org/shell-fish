#!/usr/bin/bash

# depends on "lnif" function (which depends on explicit $HOME paths); 
# see separate bash repo
source $BASH_CUSTOM_FUNCTIONS_FILE

CURRENT_DIR=$(pwd)

#···············································································
#   SETUP HOME TARGETS
#   (universal variable files should get generated automatically)
#···············································································

HOME_BASE='/z/750/dot/repos/shell-fish/config/workstation/generic'
HOME_NORM="$HOME_BASE/linked_dir_user_normal"
HOME_SUPR="$HOME_BASE/linked_dir_user_super"

lnif "$HOME_NORM"   '/home/rigel/.config/fish'
lnif "$HOME_SUPR"   '/root/.config/fish'

#···············································································
#   SETUP SHARED FUNCTIONS DIRECTORY
#···············································································

FUNC_DIR='/z/750/dot/repos/shell-fish/config/workstation/generic/ln_src_func_shared/functions'

lnif "$FUNC_DIR"   "$HOME_NORM/functions"
lnif "$FUNC_DIR"   "$HOME_SUPR/functions"

#···············································································
#   SETUP SHARED CONFIG FILE
#···············································································

CONF_FILE='/z/750/dot/repos/shell-fish/config/workstation/generic/ln_src_conf_shared/config_shared_sourcing.fish'

lnif "$CONF_FILE"   "$HOME_NORM/config.fish"
lnif "$CONF_FILE"   "$HOME_SUPR/config.fish"

#···············································································
#   SETUP SEPARATE HISTORY FILES
#···············································································

HIST_BASE='/z/750/dot/repos/shell-fish/config/workstation/generic/ln_src_hist'
HIST_NORM="$HIST_BASE/fish_history_user_normal.diff"
HIST_SUPR="$HIST_BASE/fish_history_user_super.diff"

lnif "$HIST_NORM"   "$HOME_NORM/fish_history"
lnif "$HIST_SUPR"   "$HOME_SUPR/fish_history"

#···············································································
cd $CURRENT_DIR
