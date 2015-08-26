function timed -d "Wrapper for time; hack until fish has a built-in"
#-------------------------------------------------------------------------------
    # if your arg has args, wrap the whole thing in double quotes
    # time -p fish -c $argv

    time -p -f "\t%E real,\t%U user,\t%S sys" fish -c $argv
#-------------------------------------------------------------------------------
end

# https://github.com/fish-shell/fish-shell/issues/117

# redirecting stderr of "timed" to "| tee file" fails
# https://github.com/fish-shell/fish-shell/issues/110
