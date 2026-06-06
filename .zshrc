# --- FASTFETCH ---
fastfetch

# --- ALIASES ---
alias ls='eza --icons --group-directories-first --color=always'
alias ll='eza -lh --icons --group-directories-first'
alias lt='eza --tree --level=2 --icons'
alias la='eza -a --icons'
alias lla='eza -lha --icons --group-directories-first'
alias cd='z'

# --- SETTINGS HISTORY ---
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
setopt sharehistory
#setopt CORRECT

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh/
typeset -U PATH path

# --- CUSTOM FUNCTIONS ---
# Load Wallpaper Selector
if [ -f ~/.config/zsh/wallpaper.zsh ]; then
    source ~/.config/zsh/wallpaper.zsh
fi

# --- TOOLS & EXPORTS ---
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export EDITOR="nvim"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(fzf --zsh)"

# --- PLUGINS ---
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- CUSTOM PLUGIN STYLES ---
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#585b70'

ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
ZSH_HIGHLIGHT_STYLES[path_approx]='none'
ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='none'
ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='none'

ZSH_HIGHLIGHT_STYLES[number]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[option]='fg=#fab387'
ZSH_HIGHLIGHT_STYLES[bracket]='fg=#f9e2af'
