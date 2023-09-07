source ~/.env
source ~/.alias

export EDITOR="nvim"
alias n="cd $HOME/.config/nvim"

export ZSH="$HOME/.config/zsh/oh-my-zsh"
export ZSH_THEME="robbyrussell"


# path
path+=/usr/local/go/bin
path+=/home/jaydenelliott/miniconda3/bin
path+=/usr/bin
path+=/home/jaydenelliott/.local/share/bob/nvim-bin
path+=usr/bin/depot_tools
export PATH


plugins=(
    git
    zsh-autosuggestions
	zsh-completions
    z 
)
source $ZSH/oh-my-zsh.sh

# fzf
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
source /home/jaydenelliott/.config/zsh/fzf/shell/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
