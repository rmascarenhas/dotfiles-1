# alias
. ~/.bash_aliases

# Meus diretórios e variaveis useful
user=kassio
export home=/Users/$user
export dev=$home/Development

# Forçar a colorização do terminal
force_color_prompt=yes
export TERM=screen-256color

# Visualisação do Console
if [[ ${EUID} == 0 ]] ; then
  export PS1='$(__git_ps1 "(\[\e[1;33m\]%s\[\e[0m\])")\[\033[01;34m\]\W\[\033[01;31m\]\$\[\e[0m\] '
else
  export PS1='$(__git_ps1 "(\[\e[1;33m\]%s\[\e[0m\])")\[\033[01;34m\]\W\[\033[00m\]\[\e[032m\]\$\[\e[0m\] '
fi

# git
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM=auto

# Visualização do Console do Mysql
export MYSQL_PS1='\d\$ '

# Editor padrao para algumas aplicações
export EDITOR='vim'

# Permissão de Novos arquivos
umask 027

# Auto-correção ao executar cd
shopt -s cdspell

# Navegar em diretórios utilizando variaveis de ambiente
shopt -s cdable_vars

# Melhorias no histórico
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
HISTCONTROL=ignoreboth

# Tamanho do historico
HISTFILESIZE=10000000000
HISTSIZE=1000000

# Apenda historicos do usuario
shopt -s histappend

# Melhoria na busca no histórico
# desativando o stop = ctrl ^S
stty -ixon

# Verifica o tamanho das janelas para adaptar o tamanho das linhas de comando
shopt -s checkwinsize

# Autocomplete 
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# Melhorias no autocomplete
set show-all-if-ambiguous on
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

dp() { cd $dev/$1; }

_dp() {
  local cur
  cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $( compgen -S/ -d $dev/$cur | cut -b $((${#dev}+2))- ) )
}
complete -o nospace -F _dp dp

# Colorify less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;37m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# rbenv
export PATH="$home/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
