if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

export hostip="127.0.0.1"
export https_proxy="http://$hostip:7890"
export http_proxy="http://$hostip:7890"

set fishrc $HOME/.config/fish/config.fish

fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path "/mnt/c/Users/24162/AppData/Local/Programs/Microsoft VS Code/bin"

zoxide init fish | source
alias cd=z

alias ls="exa --group-directories-first"
alias ll="exa -lb --no-user --group-directories-first"
alias la="exa -alb --no-user --group-directories-first" 

alias gst="git status"
alias gcm="git commit -m"

set Downloads "/mnt/c/Users/24162/Downloads"
