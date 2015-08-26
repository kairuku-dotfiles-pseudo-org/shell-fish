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
end
