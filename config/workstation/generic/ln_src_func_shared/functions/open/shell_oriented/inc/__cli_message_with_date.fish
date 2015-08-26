function __cli_message_with_date -d "extraction of repetitive echo formatting"
    # don't call "sleep" within this function lest if affect "timed" results
    set_color normal
    set_color -b fff
    set_color 000

    echo $argv
    date '+%Y-%m-%d_%A_%R'

    set_color normal

end     # END FUNCTION DEFITION

#···············································································
#   FUNCTIONS THAT USE THIS FUNCTION:
#···············································································
#   backup_laptop
