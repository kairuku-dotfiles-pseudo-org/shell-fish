function gits -d "git status alias"

    # optional: git status -sb
    git status
    __cli_message "Invoke 'git diff' or 'git log' if needed"
    __cli_message "If the last commit was a mistake, call 'git_undo_last_commit'"

end
