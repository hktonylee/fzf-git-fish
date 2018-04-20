
function my_less
    less -iRS -+X
end


function my_syntax_less
    pygmentize $argv[1] | my_less
end


function git_diff
    git diff --color $argv[2..-1] -- $argv[1] | diff-highlight | my_less
end


function show_git_status_line
    # Reference: https://git-scm.com/docs/git-status#_short_format

    set -l line $argv[1]
    set -l statusCode (echo -n $line | cut -c1,2)
    set -l statusCodeX (echo -n $statusCode | cut -c1)
    set -l statusCodeY (echo -n $statusCode | cut -c2)
    set -l filePath (echo -n $line | cut -c4-)

    if [ "$statusCode" = '??' ]
        my_syntax_less $filePath
    else if [ "$statusCode" = 'A ' ]
        my_syntax_less $filePath
    else if [ "$statusCode" = 'AM' ]
        my_syntax_less $filePath
    else if [ "$statusCode" = 'MM' ]
        git_diff $filePath HEAD
    else if [ "$statusCode" = ' M' ]
        git_diff $filePath --color
    else if [ "$statusCode" = 'M ' ]
        git_diff $filePath --cached
    else
        echo "Unsupported status" | my_less
    end
end

