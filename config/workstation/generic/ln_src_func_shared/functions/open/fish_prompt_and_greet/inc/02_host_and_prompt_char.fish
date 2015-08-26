
set pcolor $bryellow

# Color prompt character red for non-zero exit status
set pcolor2 $yellow

if test $last_status -ne 0
  set pcolor2 $red
end # end if


# Just calculate these once, to save a few cycles
# when displaying the prompt

if not set -q __fish_prompt_hostname
  set __fish_prompt_hostname (hostname|cut -d . -f 1)
end # end if

if not set -q __fish_prompt_char
  switch (id -u)
    case 0
      set __fish_prompt_char '#'
    case '*'
      set __fish_prompt_char '>'
  end # end switch
end # end if
