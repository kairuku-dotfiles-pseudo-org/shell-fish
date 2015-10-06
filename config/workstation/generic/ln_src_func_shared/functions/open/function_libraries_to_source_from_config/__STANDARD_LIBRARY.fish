#       THIS LIBRARY MUST BE ~SOURCED~ FROM THE FISH CONFIG
#···············································································

function __cli_div_80 -d "provides a visual divider onscreen and in file outputs, up the 80th column"
    # SIMPLIFIED INTERPUNCT VARIANT:
    echo "················································································"
    #   DEPRECATED: "....." "✦✦✦✦✦" "◠◡◠◡◠"
    #   http://unicode-table.com/en/
    #   http://www.fileformat.info/info/unicode/block/geometric_shapes/list.htm
    #   http://www.fileformat.info/info/unicode/category/Sm/list.htm
end     # END FUNCTION DEFINTION

#···············································································

function __cli_message -d "extraction of repetitive echo formatting"
    # don't call "sleep" within this function lest if affect "timed" results
    set_color normal
    set_color -b fff 000
    echo $argv
    set_color normal
end     # END FUNCTION DEFINTION

#···············································································

function __cli_message_with_date -d "extraction of repetitive echo formatting"
    set_color normal
    set_color -b fff 000
    echo $argv
    date '+%Y-%m-%d_%A_%R'
    set_color normal
end     # END FUNCTION DEFINTION

#···············································································

function curl_wan_ip -d "check if my current WAN IP has changed"
#   $WAN_IP_ADDR_LAST is stored in a closed variables file
#   this is useful when, e.g., your VPS sshd is configured to only accept
#   connections from certain IP addresses
    set -l WAN_IP_ADDR_NOW_RAW (curl --max-time 5 -s checkip.dyndns.org)
    set -l CURL_STATUS $status
    if test $CURL_STATUS -eq 0
        set WAN_IP_ADDR_NOW (echo $WAN_IP_ADDR_NOW_RAW | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
        if test $WAN_IP_ADDR_NOW = $WAN_IP_ADDR_LAST
            echo $WAN_IP_ADDR_NOW " (WAN IP address has not changed)"
        else
            set_color B41500    # red
            echo "** WARNING: WAN IP address has changed! **"
            set_color normal
        end     # END IP COMPARISON
    else
        echo "curl timed out"
    end     # END CURL STATUS CONDITIONAL
end     # END FUNCTION DEFINTION

#···············································································

function empty_cache -d "empty buffers/cache/swap"
    #   http://unix.stackexchange.com/questions/87908/how-do-you-empty-the-buffers-and-cache-on-a-linux-system
    switch (id -u)
        case 0
            __cli_message "you are root, emptying the cache and swap"
            sync
            sysctl vm.drop_caches=3
            #   echo 3 > /proc/sys/vm/drop_caches
            sleep 15
            swapoff -va
            swapon -va
        case '*'
            __cli_message "you must be root to run this command"
    end     # END SWITCH
end     # END FUNCTION DEFINTIONN

#···············································································

function fsrc -d "reload fish config"
    source $HOME/.config/fish/config.fish
end     # END FUNCTION DEFINTION

#···············································································

function finfo -d "basic listing of some commands, issues, etc"
    cat $FISH_WKR_FDAT_DIR/open/fish_info_file_01.unix.txt
end     # END FUNCTION DEFINTION

#···············································································

function grepir -d "alias for grep -ir"
    grep -ir $argv
end     # END FUNCTION DEFINTION

#···············································································

function paths -d "display command search paths as well as function search paths"
    __cli_message "commands search paths:"
    echo $PATH | tr " " "\n"

    __cli_message "fish custom functions search paths:"
    echo $fish_function_path | tr " " "\n"
end     # END FUNCTION DEFINTION


#···············································································

function __ssh_agent_status_set -d "set conditional variable for functions that use ssh"
    # also test for internet connectivity and/or a changed WAN IP address?
    ssh-add -l > /dev/null
    set SSH_AGENT_RUNNING_STATUS $status
end     # END FUNCTION DEFINTION

#···············································································

function __ssh_agent_no_identities -d "show message when conditionals fail"
    __cli_message "The ssh agent has no identities!"
end     # END FUNCTION DEFINTION

#···············································································

function sur -d "become root and start a new fish"
    su - root -c fish
end     # END FUNCTION DEFINTION

#···············································································

function timed -d "Wrapper for time; hack until fish has a built-in"
    #   https://github.com/fish-shell/fish-shell/issues/117
    #   https://github.com/fish-shell/fish-shell/issues/110
    # if your arg has args, wrap the whole thing in double quotes
    # time -p fish -c $argv
    time -p -f "\t%E real,\t%U user,\t%S sys" fish -c $argv
end     # END FUNCTION DEFINTION

#···············································································

function __timestamper -d "timestamps creation for use by other functions"
    #   this function is not meant to be called directly
    set -gx TIMESTAMP_UNIX (date +"%s")
    set -gx TIMESTAMP_HUMAN_UTC (date -u '+%Y-%m-%d_%A_%R')
    set -gx TIMESTAMP_HUMAN_TZ (date '+%Y-%m-%d_%A_%R')
end     # END FUNCTION DEFINTION
