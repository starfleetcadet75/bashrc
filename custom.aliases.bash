unalias c
unalias k
unalias q
unalias md
unalias rd
unalias ..
unalias ...
unalias ....
unalias -- -

alias xx='exit'
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

# Alias for cding up dirs
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

# Become system admin
alias god='sudo -i'
alias root='sudo -i'

# Upgrade/update system
alias update='sudo apt-get update && sudo apt-get upgrade && sudo apt-get autoremove'

# Shutdown commands
alias shutdown='sudo shutdown -h now'

# Shorten apt-get command
alias apt-get='sudo apt-get'

# Vim editor
alias vi='vim'
alias svi='sudo vi'
alias gv='gvim'
alias givm='gvim'

# Prevent gdb from spamming the terminal
alias gdb='gdb -q'

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
whatinstalled() { which "$@" | xargs -r readlink -f | xargs -r dpkg -S ;}

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
