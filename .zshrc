# =========================================================================
# tokuhirom's .zshrc
#
# =========================================================================

# -------------------------------------------------------------------------
# terminal
#
# -------------------------------------------------------------------------
# Ctrl+S での stop をやめる
stty stop undef

if [ "$TERM" = "linux" ] ; then
    export LANG=C
else
    export LANG=ja_JP.UTF-8
fi
export LV='-Ou8'
export LC_DATE=C

# -------------------------------------------------------------------------
# zsh basic settings
#
# -------------------------------------------------------------------------
# emacs like keybindings
bindkey -e
#履歴たっぷりで。
HISTFILE=$HOME/.zsh-history           # 履歴をファイルに保存する
HISTSIZE=1000                         # メモリ内の履歴の数
SAVEHIST=1000                         # 保存される履歴の数
setopt extended_history               # 履歴ファイルに時刻を記録
setopt share_history                  # 履歴を全端末で共有

autoload -U compinit
compinit

export PATH="/home/tokuhiro/bin:/usr/local/bin/:$PATH"
if [ -e "$HOME/private-bin/" ]
then
	export PATH="$PATH:$HOME/private-bin/"
fi

setopt autopushd print_eight_bit
setopt auto_menu auto_cd correct auto_name_dirs auto_remove_slash
setopt extended_history hist_ignore_dups hist_ignore_space prompt_subst
setopt pushd_ignore_dups rm_star_silent sun_keyboard_hack
setopt extended_glob list_types no_beep always_last_prompt
setopt cdable_vars sh_word_split auto_param_keys
unsetopt promptcr
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# -------------------------------------------------------------------------
# ls
#
# -------------------------------------------------------------------------
if [ "$HOST" = 'skinny.local' ]; then
    alias ls='/usr/local/bin/ls --color -ltr'
else
    alias ls='\ls --color -ltr'
fi
alias s='ls'
alias l='ls'
alias sl='ls'
alias la='ls -a'
alias ll='ls -l'
alias llh='ls -lh'
# for FreeBSD.
if [ -e '/usr/local/bin/gls' ]; then
	alias ls='\gls --color'
fi
# function chpwd() { ls } # ディレクトリ移動時に ls

# -------------------------------------------------------------------------
# プロンプトの設定
#
# -------------------------------------------------------------------------
setopt prompt_subst
# ダム
if [ "$TERM" = "dumb" ] ; then
	PROMPT='%h %n@%m[%d] %# '
	RPROMPT='%D %T'
else
	PROMPT='%{[$[32+$RANDOM % 5]m%}%U$HOST'"{`whoami`}%b%%%{[m%}%u "
	RPROMPT='%{[33m%}[%d] %D %T%{[m%}'
fi

# -------------------------------------------------------------------------
# エディタとかページャとか
#
# -------------------------------------------------------------------------
export	EDITOR=vim
export	PAGER=lv
alias	vi=vim

export PERL_BADLANG=0

if [ -e "/opt/local/" ];
then
    export PATH="$PATH:/opt/local/bin/:/opt/local/sbin/"
fi

if [ -e "/var/lib/gems/1.8/bin" ];
then
    export PATH="$PATH:/var/lib/gems/1.8/bin"
fi

if [ -e "/usr/local/flex2sdk/bin" ];
then
    export PATH="$PATH:/usr/local/flex2sdk/bin"
fi

if [ -e "/usr/local/fcsh/bin" ];
then
    export PATH="$PATH:/usr/local/fcsh/bin"
fi

export TZ='Asia/Tokyo'
