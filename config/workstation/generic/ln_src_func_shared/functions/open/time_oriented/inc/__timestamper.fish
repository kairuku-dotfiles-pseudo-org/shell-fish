function __timestamper -d "timestamps creation for use by other functions"
#   this function is not meant to be called directly

    set -gx TIMESTAMP_UNIX (date +"%s")
    set -gx TIMESTAMP_HUMAN_UTC (date -u '+%Y-%m-%d_%A_%R')
    set -gx TIMESTAMP_HUMAN_TZ (date '+%Y-%m-%d_%A_%R')

end # END FUNCTION DEFINTION

#···············································································
#   FUNCTIONS THAT USE THIS FUNCTION (grepir "__timestamper"):
#···············································································
#   camera_processing
#   __git_init_and_optionally_remote_push
#   rebuild_terminator
