function git_add_commit_push_tracked -d "git add, commit and push if an agent is running"
# this assumes repo is already init'd / cloned

    # also test for internet connectivity and/or a changed WAN IP address?
    ssh-add -l > /dev/null
    set -l SSH_AGENT_STATUS $status
    if test $SSH_AGENT_STATUS -eq 0

        # http://stackoverflow.com/questions/572549/difference-between-git-add-a-and-git-add
        # new git behavior requires indicating the whole tree if not at the root
        __cli_div_80
        git add -A :/

        # http://stackoverflow.com/questions/18604920/git-doesnt-remove-files-from-remote
        # nonetheless, i've still seen a deleted file not get deleted on the remote ....



        # http://stackoverflow.com/questions/3541647/git-add-vs-git-commit-a
        __cli_div_80
        git commit

        # http://mislav.uniqpath.com/2010/07/git-tips/
        # git config --global push.default tracking
        __cli_div_80
        # git push origin master
        git push

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
