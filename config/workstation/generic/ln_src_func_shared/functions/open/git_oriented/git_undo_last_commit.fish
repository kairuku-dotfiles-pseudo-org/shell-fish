function git_undo_last_commit -d "undo last commit"
    # for now this assumes <remote><branch> is origin master

    # never use --hard, it really nukes file changes!!
    # git reset --hard HEAD~1
    git reset --soft HEAD

    git push -f origin master

end
