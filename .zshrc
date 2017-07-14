#{{{ Zsh Environments variables
export ZSH="/home/starfleetcadet75/.oh-my-zsh"
DEFAULT_USER="starfleetcadet75"
ZSH_THEME="agnoster"
_Z_DATA="$ZSH/.z"
#}}}

# Starts tmux with the terminal
if [ -e /usr/bin/tmux ]; then
    [ -z "$TMUX" ] && exec tmux -2
fi

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(docker git-extras git-flow pip python extract cp)

source $ZSH/oh-my-zsh.sh

#{{{ History
HISTFILE=~/.oh-my-zsh/.history
SAVEHIST=10000
HISTSIZE=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_VERIFY
setopt EXTENDED_HISTORY
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt NO_BEEP
#}}}

#{{{ Environments variables
export PATH=$HOME/.local/bin:$HOME/Tools:$HOME/Scripts:/usr/local/bin:$HOME/.cargo/bin:$PATH
export VISUAL='nvim'
export EDITOR='nvim'
export JAVA_HOME='/usr/bin'
#}}}

# Source Z
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

#{{{ Aliases
unalias md
unalias rd

# Vim
alias vi='nvim'
alias vim='nvim'
alias svi='sudo vi'
alias givm='gvim'

alias xx='exit'
alias cls='clear'
alias lh='ls -h'

# Perform 'ls' after 'cd' if successful
function cdls() {
  builtin cd "$*"
  RESULT=$?
  if [ "$RESULT" -eq 0 ]; then
    ls
  fi
}
alias cd='cdls'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

# Prevent gdb from spamming the terminal
alias gdb='gdb -q'

# Force Intel syntax on objdump
alias objdump='objdump -M intel'

# Network aliases
alias ping='ping -c 5'
alias fastping='ping -c 100 -s.2'
alias ports='netstat -tulanp'

# Make mount command output readable
alias mount='mount | column -t'

# Time commands
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

# Resume wget downloads by default
alias wget='wget -c'  # Resume wget downloads by default

# Print paths
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

# Fix ropgadget's name
alias ropgadget='ROPgadget'

# Find the package that installed a command
whatinstalled() { which "$@" | xargs -r readlink -f | xargs -r pacman -Ss ;}

# Creates an archive (*.tar.gz) from given directory
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Pretty-print of 'df' output
function getdf() {
    for fs ; do
        if [ ! -d $fs ]
        then
          echo -e $fs" :No such file or directory" ; continue
        fi

        local info=( $(command df -P $fs | awk 'END{ print $2,$3,$5 }') )
        local free=( $(command df -Pkh $fs | awk 'END{ print $4 }') )
        local nbstars=$(( 20 * ${info[1]} / ${info[0]} ))
        local out="["
        for ((j=0;j<20;j++)); do
            if [ ${j} -lt ${nbstars} ]; then
               out=$out"*"
            else
               out=$out"-"
            fi
        done
        out=${info[2]}" "$out"] ("$free" free on "$fs")"
        echo -e $out
    done
}

# Get IP adress on ethernet
function get_ip() {
    MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' | sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}
}

# Get current host related info
function ii() {
    echo -e "\nYou are logged on ${BRed}$HOST"
    echo -e "\n${BRed}Additionnal information:$NC " ; uname -a
    echo -e "\n${BRed}Users logged on:$NC " ; w -hs |
             cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Current date :$NC " ; date
    echo -e "\n${BRed}Machine stats :$NC " ; uptime
    echo -e "\n${BRed}Memory stats :$NC " ; free
    echo -e "\n${BRed}Diskspace :$NC " ; getdf / $HOME
    echo -e "\n${BRed}Local IP Address :$NC" ; get_ip
    echo -e "\n${BRed}Open connections :$NC "; netstat -pan --inet;
    echo
}

function most_useless_use_of_zsh {
   local lines columns colour a b p q i pnew
   ((columns=COLUMNS-1, lines=LINES-1, colour=0))
   for ((b=-1.5; b<=1.5; b+=3.0/lines)) do
       for ((a=-2.0; a<=1; a+=3.0/columns)) do
           for ((p=0.0, q=0.0, i=0; p*p+q*q < 4 && i < 32; i++)) do
               ((pnew=p*p-q*q+a, q=2*p*q+b, p=pnew))
           done
           ((colour=(i/4)%8))
            echo -n "\\e[4${colour}m "
        done
        echo
    done
}
#}}}

