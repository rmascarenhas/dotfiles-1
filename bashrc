export DOTFILES=$HOME/.dotfiles
source $DOTFILES/my_env
source $DOTFILES/aliases

build_ps1() {
  local blue='\[\e[0;34m\]'
  local red='\[\e[0;31m\]'
  local yellow='\[\e[01;33m\]'
  local reset='\[\e[00m\]'
  local green='\[\e[0;32m\]'

  local git_ps1=$yellow'$(__git_ps1 "(%s)")'
  local pwd_ps1="$blue\w"
  local prompt_ps1="$([[ ${EUID} == 0 ]] && echo $red'#' || echo $green'$')"
  local user_ps1=$([ -e "$home/.user_ps1" ] && echo "`cat $home/.user_ps1` ")

  export PS1="$user_ps1$pwd_ps1$git_ps1\n$prompt_ps1$reset "
}; build_ps1

# Autocomplete
load_bash_completion() {
  local brew_prefix="`which brew --prefix`"
  local prefix=${brew_prefix:-/usr/local}

  if [[ -e $prefix/etc/bash_completion ]]
  then
    source $prefix/etc/bash_completion
    source $prefix/Library/Contributions/brew_bash_completion.sh
  elif [[ -e /etc/bash_completion ]]
  then
    source /etc/bash_completion
  fi
}; load_bash_completion

# Make ** works beautiful, works to any nested directory.
shopt -s globstar

# Append user history
shopt -s histappend

complete -A hostname   rsh rcp telnet rlogin r ftp ping disk
complete -A export     printenv
complete -A variable   export local readonly unset
complete -A enabled    builtin
complete -A alias      alias unalias
complete -A function   function
complete -A user       su mail finger
complete -o default -o nospace -F _rakecomplete rake
complete -o default -o nospace -F _capcomplete cap
complete -o default -o nospace -F _thorcomplete thor

pro() { cd $projects/$1; }
_pro() {
  local cur
  cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $( compgen -S/ -d $projects/$cur | cut -b $((${#projects}+2))- ) )
}
complete -o nospace -F _pro pro

asp() { cd $asp/$1; }
_asp() {
  local cur
  cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $( compgen -S/ -d $asp/$cur | cut -b $((${#asp}+2))- ) )
}
complete -o nospace -F _asp asp

if [[ -e "$home/.env" ]]
then
  source $home/.env
fi

# vim:ft=sh:
