if status is-interactive
    fastfetch --config $HOME/.config/fastfetch/start.jsonc
    set fish_greeting ""
    export PAGER=bat
    export EDITOR=nvim
    export VISUAL=nvim
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    gh auth setup-git
    zoxide init fish | source
    eval "$(atuin init fish)"
    echo ""
end
