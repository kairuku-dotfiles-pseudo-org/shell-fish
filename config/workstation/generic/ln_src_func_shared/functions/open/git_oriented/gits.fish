function gits -d "git status alias"

    # optional: git status -sb
    git status

    __cli_message "Invoke 'git diff' or 'git log' if needed"
    __cli_message "Call 'git_add_commit_push_tracked' when ready"

end
