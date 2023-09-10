if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="/usr/share/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"


## Host zshrc config
#
# Personal binaries
export PATH=${PATH}:~/bin:~/.local/bin:~/etc/scripts:~/tools/bin
#export PATH=${PATH}:/usr/local/go/bin
#export GOPATH=~
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH=$PATH:/home/kay_2/tools/bin/
export PATH=$PATH:/home/kay_2/.cargo/bin
export PATH=$PATH:/home/kay_2/.pdtm/go/bin
export PATH=$HOME/.huber/bin:$PATH

# Open all modified files in vim tabs
#function vimod {
#    vim -p $(git status -suall | awk '{print $2}')
#}

function clean_journctl(){
    sudo journalctl --rotate
    sudo journalctl --vacuum-time=1s
}

#########
#ALIAS
alias neofetch='neofetch --source ~/.config/neofetch/d.txt'
alias grep='grep --color=auto'
alias gg='git grep -ni'
alias gitc='git gc --aggressive'
alias phpunit='phpunit --colors'
alias vimpress="VIMENV=talk vim"
alias c="composer"
alias v="vagrant"
alias d="sudo docker"
alias biggest="du -h --max-depth=1 | sort -h"
alias :q="exit"
alias norg="gron --ungron"
alias ungron="gron --ungron"
alias j="jobs"
alias follow="tail -f -n +1"
alias v="tycat"
# Alias's for multiple directory listing commands
alias la='lsd -Alh' # show hidden files
alias ls='lsd'
#alias ls='ls --color=always' # add colors and file type extensions
alias lx='lsd -lXBh' # sort by extension
alias lk='lsd -lSrh' # sort by size
alias lc='lsd -lcrh' # sort by change time
alias lu='lsd -lurh' # sort by access time
alias lr='lsd -lRh' # recursive ls
alias lt='lsd -ltrh' # sort by date
alias lm='lsd -alh |more' # pipe through 'more'
alias lw='lsd -xAh' # wide listing format
alias ll='lsd -Fls' # long listing format
alias labc='lsd -lap' #alphabetical sort
alias lf="lsd -l | egrep -v '^d'" # files only
alias ldir="lsd -l | egrep '^d'" # directories only
# alias to show the date
alias da='date "+%Y-%m-%d %A %T %Z"'
export LS_COLORS=$LS_COLORS:'ow=1;34:'

# Alias's to modified commands
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -iv'
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'
alias cls='clear'c
alias multitail='multitail --no-repeat -c'
alias freshclam='sudo freshclam'
alias vi='vim'
alias svi='sudo vi'
alias vis='vim "+set si"'

# Search running processes
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Count all files (recursively) in the current folder
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"

#Util alias
alias zshconfig="vim ~/.zshrc"
alias szsh="source ~/.zshrc"

# Show current network connections to the server
alias ipview="netstat -anpl | grep :80 | awk {'print \$5'} | cut -d\":\" -f1 | sort | uniq -c | sort -n | sed -e 's/^ *//' -e 's/ *\$//'"

# Show open ports
alias openports='netstat -nape --inet'

# Alias's for safe and forced reboots
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

# Alias's to show disk space and space used in a folder
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'

# Show all logs in /var/log
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

# SHA1
alias sha1='openssl sha1'

alias open='xdg-open'

alias cat='bat --paging=never -p --color=always'
alias cd="z"
alias ..="z ../"
alias ...="z ../../"
alias ....="z ../../../"
alias pkginstall="sudo dnf install"
alias pkgsearch="dnf search"
alias pkgupdate="sudo dnf update"
alias pkgclean="sudo dnf clean all"
alias gocleancache="go clean -modcache"

## Custom funciton

alias buffer_clean="free -h && sudo sh -c 'echo 1 >  /proc/sys/vm/drop_caches' && free -h"
alias ova2vmware="ovftool --lax "

#veloren(){
#	WINIT_UNIX_BACKEND=x11 WGPU_BACKEND=vulkan /usr/bin/airshipper
#}

precmd() {
  $funcstack[1]() {
    echo
  }
}

#LS_COLORS+=':tw=01;34:ow=01;34:st=01;34'
#LS_COLORS+=':ow=01;33'


## FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'
# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'
# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

git config --global oh-my-zsh.hide-status 1

eval "$(zoxide init zsh)"
export PATH=$PATH:/home/kay_2/.spicetify


export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
if [ -z "$WAYLAND_DISPLAY" ]; then
  rm -f "$XDG_RUNTIME_DIR/wayland-0" "$XDG_RUNTIME_DIR/wayland-0.lock"
fi


noise_suppression(){
    systemctl --user daemon-reload
    systemctl --user restart pipewire-input-filter-chain.service

}

rex(){
    cd /mnt/rex/
}

alias qemu-compressed-convert="qemu-img convert -p -O qcow2 -c $1 $2"


### functions
#
cpp-run() {
    echo "Compiling file..."
    g++ -o "$1" "$1.cpp"
    echo "Compiled! Enter input :D"
    ./"$1"
}
# cpp-run filename

c-run() {
    echo "Compiling file..."
    gcc -o "$1" "$1.c"
    echo "Compiled! Enter input :D"
    ./"$1"
}

# Create new venv using python3
# If no name is passed will default to .venv
function mkvenv {
    if [ -z "$1" ]
    then
        print "Creating virtualenv: .venv"
        python3 -m venv .venv
        avenv
    else
        print "Creating virtualenv: $1"
        python3 -m venv "$1"
        avenv "$1"
    fi

    print "Upgrading pip"
    pip install pip --upgrade

    print "Installing wheel package"
    pip install wheel
    print "Activated virtualenv"
}

alias 'mkenv'='mkvenv'



# Remove a virtual env.
# If no name is passed will default to .venv
function rmvenv {
    if [ -z "$1" ]
    then
        print "Removing virtualenv: .venv"
        python3 -m venv .venv
        rm -rf .venv
    else
        print "Removing virtualenv: $1"
        rm -rf "$1"
    fi
}

alias 'rmenv'='rmvenv'


# Activate virtual env
# If no name is passed will default to .venv
function avenv {
    # If no paramerter is passed try to activate .venv first. If .venv doesnt exist try with the next closest one. If both .venv37 and .venv38 exist. It will pick .venv37
    # If parameter is passed, try to activate that one
    if [ -z "$1" ]
    then

        if [ -d ".venv" ]
        then
            source .venv/bin/activate
            print "Activated virtualenv: .venv"

        else
            # Piping the output of find command to fzf to select a virtual env.
            virtual_env=$(find -maxdepth 2  -type d -name ".venv*"  | fzf)
            print "Activated virtualenv: $virtual_env"
            source "$virtual_env"/bin/activate
        fi

    else
         source "$1"/bin/activate; print "Activated virtualenv: $1" || print "Failed to activate virtualenv: $1"

    fi
}

alias 'aenv'='avenv'


# Deactivate virtual env

function dvenv {

    if [ -z "$1" ]
    then
        deactivate || print "Failed to deactivate virtualenv: .venv"
        print "Deactivated virtualenv"
    else
        deactivate "$1" || print "Failed to deactivate virtualenv: $1"
        print "Deactivated virtualenv"
    fi
}
alias 'denv'='dvenv'

alias 'shared_folder'='sudo mount -t virtiofs exclude /home/infinitty/exclude '

alias unlockaccount='faillock --user infinitty --reset'
