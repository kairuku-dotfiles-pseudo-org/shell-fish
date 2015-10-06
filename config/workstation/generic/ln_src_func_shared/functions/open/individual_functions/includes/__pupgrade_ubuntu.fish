function __pupgrade_ubuntu -d "Ubuntu-specific include function called by 'pupgrade'"
#···············································································
# this function is not meant to be called directly

    __cli_message "Continuing with the Ubuntu case ..."

    __cli_message "Runing apt-get update:"
    sudo apt-get update

    __cli_message "Running apt-get upgrade:"
    sudo apt-get upgrade

#···············································································
end # END OF SUBFUNCTION DEFINTION


#···············································································
#    NOTES/REFERENCES:
#···············································································
