function git_init_with_remote -d "initialize a local repo and push to remote if an agent is running"
# paste the remote as an argument to this function (create a .gitignore first)

    # also test for internet connectivity and/or a changed WAN IP address?
    ssh-add -l > /dev/null
    set -l SSH_AGENT_STATUS $status
    if test $SSH_AGENT_STATUS -eq 0

        __cli_div_80
        git init

        # http://stackoverflow.com/questions/572549/difference-between-git-add-a-and-git-add
        # new git behavior requires indicating the whole tree if not at the root
        __cli_div_80
        git add -A :/

        # http://stackoverflow.com/questions/3541647/git-add-vs-git-commit-a
        __cli_div_80
        git commit -m "initial commit"

        __cli_div_80
        git remote add origin $argv

        # http://stackoverflow.com/questions/5561295/what-does-git-push-u-mean
        __cli_div_80
        git push --set-upstream origin master
        
        # http://git-scm.com/book/en/v2/Git-Basics-Tagging
        __cli_div_80
        git push origin --tags
        
        __cli_div_80
        gits

    else
        __cli_message "The ssh agent has no identities, thus not executing any git commands"
    end # END SSH-AGENT TEST

end # END FUNCTION DEFINITION

#···············································································

# DEPRECATED:
#   git config --global credential.helper store
#   git config --global credential.helper cache
#   git config --global credential.helper 'cache --timeout=300000'
