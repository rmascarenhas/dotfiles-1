# alias
. ~/.bash_aliases

# Meus diretórios e variaveis useful
user=kassio
export home=/Users/$user
export dev=$home/Development
export autoseg_projects=$home/Development/AutoSeg/Projects

# Forçar a colorização do terminal
force_color_prompt=yes
export TERM=screen-256color

# git
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM=auto

# rbenv
export PATH="$home/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

source "$home/.rbenv/completions/rbenv.bash"

# prompt with ruby version
__rbenv_ps1 () {
  rbenv_ruby_version=`rbenv version | sed -e 's/\ .*//'`
  rbenv_ruby_arch=`ruby -e 'puts "#{[""].pack("p").size*8}bits"'`
  printf $rbenv_ruby_version"("$rbenv_ruby_arch")"
}

# Visualisação do Console
BLUE='\[\e[1;34m\]'
RED='\[\e[1;31m\]'
YELLOW='\e[1;33m'
WHITE='\[\e[0m\]'
GREEN='\[\e[1;32m\]'
LIGHT_BLUE='\[\e[1;36m\]'

ruby_ps1=$([[ `which rbenv` ]] && echo "$LIGHT_BLUE[ruby $(__rbenv_ps1)]" || echo "")
git_ps1=$([[ `which git` ]] && echo '$(__git_ps1 "$YELLOW(%s)")' || echo "")
pwd_ps1=$BLUE'\W'
prompt_ps1=$([[ ${EUID} == 0 ]] && echo $RED || echo $GREEN)'\$'

export PS1="$ruby_ps1 $git_ps1 $pwd_ps1 \n$prompt_ps1 $WHITE"

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

## Verifica o tamanho das janelas para adaptar o tamanho das linhas de comando
#shopt -s checkwinsize

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

asp() { cd $autoseg_projects/$1; }

_asp() {
  local cur
  cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $( compgen -S/ -d $autoseg_projects/$cur | cut -b $((${#autoseg_projects}+2))- ) )
}
complete -o nospace -F _asp asp

# Colorify less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;37m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Visualização do Console do Mysql
export MYSQL_PS1='\d\$ '

