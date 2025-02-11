if status is-interactive
    fastfetch --config $HOME/.config/fastfetch/start.jsonc
    set fish_greeting ""
    export PAGER=bat
    export EDITOR=nvim
    export VISUAL=nvim
    gh auth setup-git
    zoxide init fish | source
    atuin init fish | source
    echo ""
end
