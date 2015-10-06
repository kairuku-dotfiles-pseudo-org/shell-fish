function fish_right_prompt -d "Write out the right prompt"
  #set_color E05500 -o
          # set -l pty basename(tty)
          # echo 'tty'(tty|cut -c 10-)
          # echo 'tty'$pty
  #echo 'tty'(basename (tty))
  #echo ' '
  #echo (date +"%s")
  #set_color normal

    # http://stackoverflow.com/questions/1738665/showing-only-the-uptime-from-uptime-unix
    # echo -n (set_color normal)(set_color B45900 -o)'up '(uptime | sed 's/.*up \([^,]*\), .*/\1/')
end
