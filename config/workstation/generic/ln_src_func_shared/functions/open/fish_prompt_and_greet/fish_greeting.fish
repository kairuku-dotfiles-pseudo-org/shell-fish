function fish_greeting -d "override default greeting"

    switch (echo $HOST_OS)
        case arch_linux
            set OS_MSG "Arch Linux detected (no modifications necessary)"
        case ubuntu_linux
            # eventually match Arch paths, e.g., /run/media/rigel
            # possibly also user groups
            set OS_MSG "on Ubuntu, fix paths, etc"
        case unsupported_system
            set OS_MSG "not on Arch or Ubuntu, something's wrong!"
    end # END OS TESTING SWITCH

    set FISHVER (fish -v ^&1)

    set_color -o 66FF00
    echo $FISHVER " ■ currently not upgrading fish due to bugs"
    echo "Type 'fish_info' for more info about fish customizations"

    echo $OS_MSG
    ssh-add -l
    curl_wan_ip
    set_color normal

end  # END FUNCTION DEFINITION
