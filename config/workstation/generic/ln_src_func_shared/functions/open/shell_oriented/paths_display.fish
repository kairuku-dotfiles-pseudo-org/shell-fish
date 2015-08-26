function paths_display -d "display command search paths as well as function search paths"

    __cli_message "commands search paths:"
    echo $PATH | tr " " "\n"

    __cli_message "fish custom functions search paths:"
    echo $fish_function_path | tr " " "\n"

end
