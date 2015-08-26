#···············································································
#   CACHE OS VAR FOR RE-USE IN FUNCS/INCS WITH OS-SPECIFIC DIFFERENCES
#···············································································

#   USE SWITCHES, NOT IF/ELSE BLOCKS FOR OS TESTING,
#   BOTH HERE AND IN FUNCTIONS USING THIS VARIABLE

switch (lsb_release -i)
    case '*Arch*'
        set -x -g HOST_OS arch_linux
    case '*Ubuntu*'
        set -x -g HOST_OS ubuntu_linux
    case '*'
        set -x -g HOST_OS unsupported_system
end

#···············································································
#   NOW ELSEWHERE IN FISH FUNCTIONS, USE THE VARIABLE THUSLY
#···············································································

# switch (echo $HOST_OS)
#    case arch_linux
#        __cli_message  "Continuing with the Arch case ..."
        # [arch actions]

#     case ubuntu_linux
#        __cli_message "Continuing with the Ubuntu case ..."
        # [ubuntu actions]

#    case unsupported_system
#        __cli_message "We're not on Arch or Ubuntu, aborting!"



#···············································································
#   CONFIG MODULES THAT RELY ON THIS VARIABLE
#···············································································

#   paths_commands


#···············································································
#   FUNCTIONS THAT RELY ON THIS VARIABLE
#···············································································

#   fish_greeting
#   backup_system_files_only
#   uppackages
#   pinstall
#   pupgrade

#···············································································
#   FUNCTIONS THAT NEED TO BE REFACTORED TO USE THIS VARIABLE
#···············································································

#   backup_laptop
