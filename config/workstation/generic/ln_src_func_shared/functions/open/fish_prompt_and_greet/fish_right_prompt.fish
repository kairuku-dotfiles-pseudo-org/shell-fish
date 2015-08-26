function fish_right_prompt -d "Write out the right prompt"
  set_color E05500 -o
  # set -l pty basename(tty)
  # echo 'tty'(tty|cut -c 10-)
  # echo 'tty'$pty
  echo 'tty'(basename (tty))
  echo ' '
  echo (date +"%s")
  set_color normal
end
