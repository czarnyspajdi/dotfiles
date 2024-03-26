if status is-interactive
  fastfetch --config /home/ksymena/.config/fastfetch/start.jsonc
  set fish_greeting ""
  export PAGER=bat
  export EDITOR=nvim
  export VISUAL=nvim
  gh auth setup-git 
  echo ""
end
