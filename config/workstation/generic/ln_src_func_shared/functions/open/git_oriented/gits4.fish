function gits4 -d "loop through a local org dir to check git status"

            set -l ORG_DIR (pwd)
            cd $ORG_DIR

            for REPO_DIR in *
                cd $REPO_DIR

                echo $REPO_DIR
                echo
                
                gits

                cd $ORG_DIR

            end # END FOR

end # END FUNCTION DEFINITION
