#       THIS LIBRARY MUST BE ~SOURCED~ FROM THE FISH CONFIG
#···············································································
#
#   CONFIGURATION DEPRECATED (MOSTLY USING SSH INSTEAD OF HTTP):
#       git config --global credential.helper store
#       git config --global credential.helper cache
#       git config --global credential.helper 'cache --timeout=300000'
#
#   IMPORTED FUNCTIONS AND VARIABLES:
#       __ssh_agent_status_set
#       __ssh_agent_no_identities
#       $SSH_AGENT_RUNNING_STATUS
#       $GH_API_TOKEN
#
#   TODO:
# some functions below need to start taking mutiple or arbitrary remotes into consideration
#
#···············································································
#
#       NOTES FOR GIT ADD:
# http://stackoverflow.com/questions/572549/difference-between-git-add-a-and-git-add
# http://stackoverflow.com/questions/3541647/git-add-vs-git-commit-a
# new git behavior requires indicating the whole tree if not at the root
#
#       NOTES FOR GIT COMMIT:
# http://stackoverflow.com/questions/18604920/git-doesnt-remove-files-from-remote
#   nonetheless, i've still seen a deleted file not get deleted on the remote ....
# http://stackoverflow.com/questions/3541647/git-add-vs-git-commit-a
# http://stackoverflow.com/questions/1139762/ignore-files-that-have-already-been-committed-to-a-git-repository
#
#       NOTES FOR GIT PUSH:
# http://stackoverflow.com/questions/5561295/what-does-git-push-u-mean
#   http://git-scm.com/book/en/v2/Git-Basics-Tagging
# http://mislav.uniqpath.com/2010/07/git-tips/
#   git config --global push.default tracking
#
#       NOTES FOR GIT RESET:
# never use --hard, it really nukes file changes!!
#   Ex: git reset --hard HEAD~1
#
#       NOTES FOR FORKS:
# https://help.github.com/articles/syncing-a-fork/
# https://help.github.com/articles/using-pull-requests/
# https://help.github.com/articles/fork-a-repo/
# https://gun.io/blog/how-to-github-fork-branch-and-pull-request/
#
#···············································································

function gac -d "alias for git add and commit"
    git add -A :/
    git commit
end     # END FUNCTION DEFINTION

#···············································································

function gfs -d "sync a fork with upstream"
    git fetch upstream
    git checkout master
    git merge upstream/master
    __cli_message "Checkout the branch you were on if desirable."
end     # END FUNCTION DEFINTION

#···············································································

function gir -d "init a local repo and push to non-fork remote (if an agent is running)"
    # paste the remote as an argument to this function (create a .gitignore first)
    __ssh_agent_status_set
    if test $SSH_AGENT_RUNNING_STATUS -eq 0
        git init
        git add -A :/
        git commit -m "initial commit"
        git remote add origin $argv
        git push --set-upstream origin master
        git push origin --tags
        gst
    else
        __ssh_agent_no_identities
    end     # END SSH-AGENT TEST
end     # END FUNCTION DEFINTION

#···············································································

function gpr -d "git add, commit and push (if an agent is running)"
    # this assumes repo is already init'd / cloned
    __ssh_agent_status_set
    if test $SSH_AGENT_RUNNING_STATUS -eq 0
        gac
        # DON'T SPECIFIY A REMOTE?
            # git push origin master
            # git push origin --tags
        git push
        git push --tags
        gst
        __cli_message "If the remote doesn't recognize deletions or new ignores, call 'gprf'"
        __cli_message "If the last commit was a mistake, call 'guc'"
    else
        __ssh_agent_no_identities
    end     # END SSH-AGENT TEST
end     # END FUNCTION DEFINTION

#···············································································

function gprf -d "force remote to delete newly ignored items"
    git rm -r --cached .
    # re-run add/commit/push function
    gpr
    __cli_message "Ensure you've committed changes BEFORE calling this function."
end     # END FUNCTION DEFINTION

#···············································································

function gst -d "alias for git status"
    # git --version
    # optional: git status -sb
    git status
    __cli_message "Invoke 'git diff', 'git log' or 'git reflog' if needed"
    __cli_message "If you wanted to loop thru dirs, call 'gstl' instead"
    __cli_message "Call 'gpr' when ready"
end     # END FUNCTION DEFINTION

#···············································································

function gstl -d "loop through a local org dir to check git status"
    set -l ORG_DIR (pwd)
    cd $ORG_DIR
    for REPO_DIR in *
        cd $REPO_DIR
        echo $REPO_DIR
        echo
        gst
        cd $ORG_DIR
    end     # END FOR
end     # END FUNCTION DEFINTION

#···············································································

function guc -d "undo last commit"
    # for now this assumes <remote><branch> is origin master
    git reset --soft HEAD
    git push -f origin master
end     # END FUNCTION DEFINTION

#···············································································
#   GITHUB-SPECIFIC FUNCTIONS:
#···············································································

function gh_batch_api_init_org_repos -d "loop through a local org dir and create repos via API"
    # expects directory as first arg and github org name as second arg
    __ssh_agent_status_set
    if test $SSH_AGENT_RUNNING_STATUS -eq 0
        if count $argv > /dev/null
        # really should also test for args in proper order too
            set -l PWD_CACHE    (pwd)
            set -l ORG_DIR      $argv[1]
            set -l GH_ORG       $argv[2]
            cd $ORG_DIR
            for REPO_DIR in *
                # do not use underscores in directory names, they're not allowed on github
                set -l GH_REPO  $REPO_DIR
                cd $REPO_DIR
                # executing all of these commands on existing repos should not hurt anything
                gh_org_repo_api_init $GH_ORG $GH_REPO
                git_init_with_remote git@github.com:$GH_ORG/$GH_REPO.git

                cd $ORG_DIR
            end # END FOR
            cd $PWD_CACHE
        else
            __cli_message "No arguments given, halting function exection"
        end     # END ARGUMENTS CHECK
    else
        __ssh_agent_no_identities
    end     # END SSH-AGENT CHECK
end     # END FUNCTION DEFINTION

#···············································································

function gh_org_repo_api_init -d "create a single Github organization repo using API"
    # expects the org name as first argument & repo name as second argument
    # $GH_API_TOKEN is exported in a private fish config file

    # have to escape inner double quotes in the JSON for variable expansion
    curl \
        -XPOST \
        -H "Authorization: token $GH_API_TOKEN" \
        https://api.github.com/orgs/$argv[1]/repos \
        -d "{
                 \"name\":\"$argv[2]\"
                ,\"description\":\"created via API v3\"
                ,\"has_issues\": false
                ,\"has_wiki\": false
                ,\"has_downloads\": false
            }" \
        >> $FISH_FUNC_OUT_DIR/curl

    echo >> $FISH_FUNC_OUT_DIR/curl
    __cli_div_80 >> $OUTPUT_DIR/curl
    echo >> $FISH_FUNC_OUT_DIR/curl

# curl –output output_filename
# > $ARTISAN_OUT_FILE 2>&1

end     # END FUNCTION DEFINTION

#···············································································

function gh_user_repo_api_init -d "create a single Github user repo using API"
    # expects the repo name as an argument
    # $GH_API_TOKEN is exported in a private fish config file

    curl \
        -XPOST \
        -H "Authorization: token $GH_API_TOKEN" \
        https://api.github.com/user/repos \
        -d '{
                 "name":"$argv"
                ,"description":"created via API v3"
                ,"has_issues": false
                ,"has_wiki": false
                ,"has_downloads": false
            }'
end     # END FUNCTION DEFINTION
