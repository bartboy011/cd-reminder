# calls the builtin cd command, and then optionally cat's the .cd-reminder file
# in the directory if it exists
reminder_cd() {
    builtin cd "$@" && { [[ ! -a .cd-reminder ]] || cat .cd-reminder 1>&2; }
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

_insert_git_exclude() {
  echo ".cd-reminder" >> $(git config --global core.excludesfile)
}

git_exclude_cd_reminder() {
  if [[ -a $(git config --global core.excludesfile) ]]; then
    _insert_git_exclude
  else
    touch "$HOME/.gitignore-global"
    git config --global core.excludesfile "$HOME/.gitignore-global"
    _insert_git_exclude
  fi
}
