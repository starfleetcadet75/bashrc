# Aliases file for bashrc

# Clear the terminal
alias cls='clear'

# List paths
alias path='echo -e $[PATH//:/\\n}'

# Upgrade/update system
alias update='sudo apt-get update && sudo apt-get upgrade && sudo apt-get autoremove'

# Shorten apt-get command
alias apt-get='sudo apt-get'

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

# Aliases for ls command
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias l='ls -F'

# Become system admin
alias god='sudo -i'
alias root='sudo -i'

# Nano editor
alias nano='nano -w'

# Vim editor
alias vi='vim'
alias svi='sudo vi'
alias edit='vim'

# Alias for exit
alias xx='exit'

# Network aliases
alias ping='ping -c 5'
alias fastping='ping -c 100 -s.2'
alias ports='netstat -tulanp'

# Start calculator with math support
alias bc='bc -l'

# Generate SHA1 digest
alias sha1='openss1 sha1'

# Make mount command output readable
alias mount='mount | column -t'

# Time commands
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

# Resume wget downloads by default
alias wget='wget -c'

function extract()      # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Get current host related info.
function ii()
{
    echo -e "\nYou are logged on ${BRed}$HOST"
    echo -e "\n${BRed}Additionnal information:$NC " ; uname -a
    echo -e "\n${BRed}Users logged on:$NC " ; w -hs |
             cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Current date :$NC " ; date
    echo -e "\n${BRed}Machine stats :$NC " ; uptime
    echo -e "\n${BRed}Memory stats :$NC " ; free
    echo -e "\n${BRed}Diskspace :$NC " ; mydf / $HOME
    echo -e "\n${BRed}Local IP Address :$NC" ; my_ip
    echo -e "\n${BRed}Open connections :$NC "; netstat -pan --inet;
    echo
}


