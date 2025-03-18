if status is-interactive
    set fish_greeting ""
    export PAGER=bat
    export EDITOR=nvim
    export VISUAL=nvim
    gh auth setup-git
    eval (ssh-agent -c)
    ssh-add ~/.ssh/github
    zoxide init fish | source
    atuin init fish | source
    clear
    fastfetch --config $HOME/.config/fastfetch/start.jsonc
end
