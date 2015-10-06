function __pinstall_ubuntu -d "Ubuntu-specific include function called by 'pinstall'"
# this function is not meant to be called directly
# this function takes as an argument a package name

    __cli_message "Continuing with the Ubuntu case ..."
    sudo apt-get update
    sudo apt-get install $argv

end # END OF SUBFUNCTION DEFINTION
