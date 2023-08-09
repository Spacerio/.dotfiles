# zmodload zsh/zprof
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Download Znap, if it's not there yet.
[[ -f ~/Git/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Git/zsh-snap

source ~/Git/zsh-snap/znap.zsh  # Start Znap

# `znap prompt` makes your prompt visible in just 15-40ms!
znap source romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# `znap source` automatically downloads and starts your plugins.
znap source marlonrichert/zsh-autocomplete
# znap source zsh-users/zsh-autosuggestions
znap source zdharma-continuum/fast-syntax-highlighting

# `znap eval` caches and runs any kind of command output for you.

# `znap function` lets you lazy-load features you don't always need.
znap function _pyenv pyenv 'eval "$( pyenv init - --no-rehash )"'
compctl -K    _pyenv pyenv

# Load bash profile
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

# Enable history 
HISTFILE=~/.zsh-history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

bindkey -e

# Bind <M-j> and <M-k> to <Up> and <Down>
bindkey -s 'j' 'OB'
bindkey -s 'k' 'OA'

# Open Neovim with <M-n>
bindkey -s '^[o' 'nvim $(sk)^M'
bindkey -s '^[n' 'nvim'


# Backwards i-search 
bindkey -s '' history-incremental-pattern-search-backward


# Better history navigation
bindkey '' up-history
bindkey '' down-history

fpath+=~/.zfunc

compinit

if [ -e /home/user/.nix-profile/etc/profile.d/nix.sh ]; then . /home/user/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer



# znap eval zoxide "zoxide init zsh"
eval "$(zoxide init zsh)"

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux attach
fi

# zprof
