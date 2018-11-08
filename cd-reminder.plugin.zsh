# calls the builtin cd command, and then optionally cat's the .cd-reminder file
# in the directory if it exists
reminder_cd() {
    builtin cd "$@" && { [[ ! -f .cd-reminder ]] || cat .cd-reminder 1>&2; }
}

# Either creates an empty .cd-reminder file, or if an argument is included
# then creates and appends to that file the first argument
new_reminder() {
    if [[ $# -eq 0 ]]; then
        touch .cd-reminder
    fi

    if [[ $# -gt 0 ]]; then
        echo $@ >> .cd-reminder
    fi
}

alias cd=reminder_cd