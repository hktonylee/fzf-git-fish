
function fzf_git_status
    set gitFilePath "echo {} | cut -c4-"
    set viewGitFile "show_git_status_line {}"

    git -c color.status=always status -s \
        | fzf \
            --ansi \
            --reverse \
            --no-sort \
            --header "Enter to view, Space to copy path" \
            --bind "enter:execute:$viewGitFile" \
            --bind "space:execute-silent:$gitFilePath | tr -d \n | pbcopy"
end
