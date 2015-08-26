function empty_cache -d "empty buffers/cache/swap"
    switch (id -u)
        case 0
            __cli_message "you are root, emptying the cache and swap"

            free -h
            swapoff -a

            sync
            sysctl vm.drop_caches=3
            #   echo 3 > /proc/sys/vm/drop_caches
            sleep 2

            swapon -a
            free -h
        case '*'
            __cli_message "you must be root to run this command"
    end     # END SWITCH
end     # END FUNCTION DEFINITION


#   http://unix.stackexchange.com/questions/87908/how-do-you-empty-the-buffers-and-cache-on-a-linux-system
