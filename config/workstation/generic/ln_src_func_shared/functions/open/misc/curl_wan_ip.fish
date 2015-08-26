function curl_wan_ip -d "check if my current WAN IP has changed"
#   $WAN_IP_ADDR_LAST is stored in a closed variables file

#   this is useful when, e.g., your VPS sshd is configured to only accept
#   connections from certain IP addresses

    set -l WAN_IP_ADDR_NOW_RAW (curl --max-time 5 -s checkip.dyndns.org)
    set -l CURL_STATUS $status

    if test $CURL_STATUS -eq 0

        set WAN_IP_ADDR_NOW (echo $WAN_IP_ADDR_NOW_RAW | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')

        if test $WAN_IP_ADDR_NOW = $WAN_IP_ADDR_LAST
            echo $WAN_IP_ADDR_NOW " (WAN IP address has not changed)"
        else
            echo "** WARNING: WAN IP address has changed! **"
        end     # END IP COMPARISON

    else
        echo "curl timed out"
    end     # END CURL STATUS CONDITIONAL

end     # END FUNCTION DEFINITION
