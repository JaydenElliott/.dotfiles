source ~/.env
source ~/.alias

export EDITOR="nvim"
alias n="cd $HOME/.config/nvim"

export ZSH="$HOME/.config/zsh/.oh-my-zsh"
export ZSH_THEME="robbyrussell"


# path
path+=/usr/bin
path+=$HOME/.local/share/bob/nvim-bin
path+=/opt/cuda/bin
export PATH


plugins=(
    git
    zsh-autosuggestions
    zsh-completions
    z 
)
source $ZSH/oh-my-zsh.sh
. "$HOME/.cargo/env"

# fzf
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
source <(fzf --zsh)


# onnxruntime
export ORT_LIB_LOCATION="/opt/onnxruntime"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/tmp/google-cloud-sdk/path.zsh.inc' ]; then . '/tmp/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/tmp/google-cloud-sdk/completion.zsh.inc' ]; then . '/tmp/google-cloud-sdk/completion.zsh.inc'; fi

# pnpm
export PNPM_HOME="/home/jaydenelliott/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


# todo: export useful docker command for finding host ip
alias dockerhost=ip addr show docker0 | grep -Po 'inet \K[\d.]+'
