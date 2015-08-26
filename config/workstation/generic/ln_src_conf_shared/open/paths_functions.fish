#   PREPEND custom function paths; default is:
#       ~/.config/fish/functions
#       /etc/fish/functions
#       /usr/share/fish/functions
#···············································································

#   universal persists beyond reboots, but is this really necessary?
#   set --universal ( -x ?)

#   COMMENT THIS OUT TO SEE WHAT "FUNCTIONS" LISTS BY DEFAULT
set -gx fish_function_path \
    $FISH_ANY_FUNC_DIR/open/* \
    $FISH_ANY_FUNC_DIR/open/*/* \
    $FISH_WKR_FUNC_DIR/closed/main/* \
    $FISH_WKR_FUNC_DIR/closed/main/*/* \
    $FISH_WKR_FUNC_DIR/open/* \
    $FISH_WKR_FUNC_DIR/open/*/* \
    /etc/fish/functions \
    /usr/share/fish/functions

#   note that "$FISH_WKR_FUNC_DIR/closed/" introduces an additional level of
#   nesting, in order to facilitate a temporary "hide" directory to make fish
#   ignore "hidden" functions
