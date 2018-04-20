
function fzf_git_graph
    set gitLogLineToHash "echo {} | grep -oahr -m 1 '[A-Za-z0-9]\{7\}' | head -1"
    set viewGitLogLine "$gitLogLineToHash | xargs -I[] git show --color=always | diff-highlight | less -iRS -+X"
    git log \
        --graph \
        --decorate \
        --color=always \
        --format="%C(bold blue)%h%C(reset)%C(auto)%d%C(reset) %C(white)%s%C(reset) %C(yellow)%an%C(reset) %C(dim magenta)(%ar)%C(reset)" \
        | fzf \
            --ansi \
            --reverse \
            --no-sort \
            --header "Enter to view, Space to copy hash" \
            --bind "enter:execute:$viewGitLogLine" \
            --bind "space:execute-silent:$gitLogLineToHash | tr -d \n | pbcopy"
end
