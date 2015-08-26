function gh_batch_api_init_org_repos -d "loop through a local org dir and create repos via API"
# expects directory as first arg and github org name as second arg

    ssh-add -l > /dev/null
    set -l SSH_AGENT_STATUS $status
    if test $SSH_AGENT_STATUS -eq 0
        if count $argv > /dev/null
        # really should also test for args in proper order too
#···············································································

            set -l PWD_CACHE    (pwd)
            set -l ORG_DIR      $argv[1]
            set -l GH_ORG       $argv[2]

            cd $ORG_DIR

            for REPO_DIR in *

                set -l GH_REPO  $REPO_DIR
                cd $REPO_DIR

                # executing all of these commands on existing repos should not hurt anything
                gh_org_repo_api_init $GH_ORG $GH_REPO
                git_init_with_remote git@github.com:$GH_ORG/$GH_REPO.git

                cd $ORG_DIR

            end # END FOR

            cd $PWD_CACHE

#···············································································
        else
            __cli_message "No arguments given, halting fucntion exection"
        end # END ARGUMENTS CHECK

    else
        __cli_message "The ssh agent has no identities, thus not executing any further commands"
    end # END SSH-AGENT CHECK

end # END FUNCTION DEFINITION
