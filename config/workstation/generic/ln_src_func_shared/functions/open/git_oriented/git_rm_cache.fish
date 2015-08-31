function git_rm_cache -d "force remote to delete newly ignored items"
    git rm -r --cached .

    # re-run add/commit/push
    git_add_commit_push_tracked

    __cli_message "Ensure you've committed changes BEFORE calling this function."
end

# http://stackoverflow.com/questions/1139762/ignore-files-that-have-already-been-committed-to-a-git-repository
