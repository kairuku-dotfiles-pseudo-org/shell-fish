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

end

# curl –output output_filename
# > $ARTISAN_OUT_FILE 2>&1
