function fish_greeting -d "override default greeting"

    switch (echo $HOST_OS)
        case arch_linux
            set OS_MSG "Arch Linux detected"
        case ubuntu_linux
            # eventually match Arch paths, e.g., /run/media/rigel
            # possibly also user groups
            set OS_MSG "on Ubuntu, fix paths, etc"
        case unsupported_system
            set OS_MSG "not on Arch or Ubuntu, something's wrong!"
    end # END OS TESTING SWITCH

    set FISHVER (fish -v ^&1)

    # set_color -o 66FF00
    set_color 008723
    echo $FISHVER "■ Type 'finfo' for more info ■" $OS_MSG
    ssh-add -l
    curl_wan_ip
    # http://stackoverflow.com/questions/1738665/showing-only-the-uptime-from-uptime-unix
    # echo 'up '(uptime | sed 's/.*up \([^,]*\), .*/\1/')
    uptime -p
    set_color normal

end  # END FUNCTION DEFINITION
