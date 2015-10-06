function pupgrade -d "OS abstraction layer for upgrading packages"
# in the case of rolling release distros, this is also effectively a distro upgrade

    switch (id -u)
        case 0
            __cli_message "Do not invoke this function as root, use sudo"
        case '*'
            __cli_message "You are not root, the upgrades may proceed"
            __cli_message "Consider running 'backup_system_files_only' before running this upgrade function)"

            switch (echo $HOST_OS)
                case arch_linux
                    __pupgrade_arch
                case ubuntu_linux
                    __pupgrade_ubuntu
                case unsupported_system
                    __cli_message "We're not on Arch or Ubuntu, aborting!"
            end # END OF OS TESTING SWITCH

        # call custom function and wrap up
        stats_basic

    end # END ROOT TESTING SWITCH

end # END FUNCTION DEFINITION
