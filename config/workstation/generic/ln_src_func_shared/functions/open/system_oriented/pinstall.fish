function pinstall -d "OS abstraction layer for installing packages"
    switch (id -u)
        case 0
            __cli_message "Do not invoke this function as root, use sudo"
        case '*'
            __cli_message "You are not root, the install may proceed"

            switch (echo $HOST_OS)
                case arch_linux
                    __pinstall_arch $argv
                case ubuntu_linux
                    __pinstall_ubuntu $argv
                case unsupported_system
                    __cli_message "We're not on Arch or Ubuntu, aborting!"

            end # END OF OS TESTING SWITCH

    end # END ROOT TESTING SWITCH

end # END FUNCTION DEFINITION
