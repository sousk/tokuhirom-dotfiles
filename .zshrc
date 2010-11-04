# =========================================================================
# tokuhirom's .zshrc
#
# =========================================================================

# -------------------------------------------------------------------------
# terminal
#
# -------------------------------------------------------------------------
# Ctrl+S ¤Ç¤Î stop ¤ò¤ä¤á¤ë
stty stop undef

if [ "$TERM" = "linux" ] ; then
    export LANG=C
else
    export LANG=ja_JP.UTF-8
fi
export LV='-Ou8 -c'
export LC_DATE=C
# export LC_ALL=C

# -------------------------------------------------------------------------
# zsh basic settings
#
# -------------------------------------------------------------------------
# emacs like keybindings
bindkey -e
#ÍúÎò¤¿¤Ã¤×¤ê¤Ç¡£
HISTFILE=$HOME/.zsh-history           # ÍúÎò¤ò¥Õ¥¡¥¤¥ë¤ËÊÝÂ¸¤¹¤ë
HISTSIZE=1000                         # ¥á¥â¥êÆâ¤ÎÍúÎò¤Î¿ô
SAVEHIST=1000                         # ÊÝÂ¸¤µ¤ì¤ëÍúÎò¤Î¿ô
setopt extended_history               # ÍúÎò¥Õ¥¡¥¤¥ë¤Ë»þ¹ï¤òµ­Ï¿
setopt share_history                  # ÍúÎò¤òÁ´Ã¼Ëö¤Ç¶¦Í­
export HARNESS_COLOR=1 # Test::Harness.

autoload -U compinit
compinit

export PATH="/usr/local/bin/:$PATH"
export PATH="$HOME/bin:$HOME/local/bin/:$PATH"
if [ -e "/opt/local/" ];
then
    export PATH="/opt/local/bin/:/opt/local/sbin/:$PATH"
fi
if [ -e "$HOME/share/dotfiles/local/bin/" ]
then
	export PATH="$PATH:$HOME/share/dotfiles/local/bin/"
fi
if [ -e "$HOME/private-bin/" ]
then
	export PATH="$PATH:$HOME/private-bin/"
fi
if [ -e "/usr/local/mysql/bin/" ]
then
	export PATH="/usr/local/mysql/bin/:$PATH"
fi
if [ -e "/usr/local/app/perl/bin/" ]
then
	export PATH="/usr/local/app/perl/bin/:$PATH"
fi
if [ -e "/usr/local/app/perl-5.12.0/bin/" ]
then
	export PATH="/usr/local/app/perl-5.12.0/bin/:$PATH"
fi
if [ -e "/usr/local/app/perl-5.12.1/bin/" ]
then
	export PATH="/usr/local/app/perl-5.12.1/bin/:$PATH"
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

# URL ¤Î¼«Æ°¥¯¥©¡¼¥È
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# -------------------------------------------------------------------------
# ls ´Ø·¸
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
alias ¤Þ¤±='make'

# -------------------------------------------------------------------------
# ¥×¥í¥ó¥×¥È¤ÎÀßÄê
#
# -------------------------------------------------------------------------
setopt prompt_subst

# ¿§ÀßÄê¤ò´ÊÃ±¤Ë¤¹¤ë¤¿¤á¤Î½Ñ
autoload colors
colors

set_prompt() {
    # ¥À¥à
    if [ "$TERM" = "dumb" ] ; then
        export PROMPT='%h %n@%m[%d] %# '
        export RPROMPT='%D %T'
    else
        # see http://zsh.sunsite.dk/Doc/Release/zsh_12.html
        # see http://www.jmuk.org/diary/2007/10/21/0

        local host_colors md5cmd host_color user_color

        if [ $HOST = 'gp.ath.cx' ];
        then
            host_color="%{$fg[blue]%}"
        else
            host_color="%{$fg[green]%}"
        fi

        if [ `whoami` = root ]; then
            user_color="%{$fg_bold[red]%}"
        else
            user_color="%{$fg[yellow]%}"
        fi

        export PROMPT="$user_color%n%{$reset_color%}%{$fg[green]%}@%{$host_color%}%m%{$reset_color%}%% "
      	export RPROMPT='%{[33m%}[%(5~,%-2~/.../%2~,%~)] %w %T%{$reset_color%}'
    fi
}
set_prompt


# -------------------------------------------------------------------------
# ¥¨¥Ç¥£¥¿¤È¤«¥Ú¡¼¥¸¥ã¤È¤«
#
# -------------------------------------------------------------------------
export	EDITOR=vim
alias	vi=vim

function unisync () {
    # unison -batch -times ~/share/dotfiles ssh://gp.ath.cx//home/tokuhirom/share/dotfiles/
    unison -batch -times ~/share/howm ssh://gp.ath.cx//home/tokuhirom/share/howm/
}

function unisync_local () {
    # unison -batch -times ~/share/dotfiles ssh://192.168.1.3//home/tokuhirom/share/dotfiles/
    unison -batch -times ~/share/howm ssh://192.168.1.3//home/tokuhirom/share/howm/
}

function random () {
    perl -le 'use Time::HiRes qw/gettimeofday/;use Digest::MD5 qw/md5_hex/; print md5_hex(rand().gettimeofday())';
}

export GISTY_DIR=$HOME/dev/gists/

if [ -x /usr/bin/keychain ]; then
    keychain --quiet id_rsa
    . $HOME/.keychain/$HOST-sh
fi

# =========================================================================
# followings are settings for some sucky operating systems
#
# =========================================================================

# for FreeBSD.
if [ -e '/usr/local/bin/gls' ]; then
	alias ls='\gls --color'
fi

# -------------------------------------------------------------------------
# for osx

export PERL_BADLANG=0

if [ -e "/usr/local/screen_sessions/" ];
then
    export SCREENDIR=/usr/local/screen_sessions/
fi

if [ -e "/usr/X11/bin/" ];
then
    export PATH="/usr/X11/bin/:$PATH"
fi

function isight () {
    TMPL=$HOME/share/isight/%Y/%m/%d
    BASE=`/usr/local/bin/date +$TMPL`
    FILE=`/usr/local/bin/date +$BASE/%H.%M.%S.jpg`
    mkdir -p $BASE
    /usr/local/bin/isightcapture $FILE 
    open $FILE
}

function minicpan_get () {
    perl `which minicpan` -r http://ftp.funet.fi/pub/languages/perl/CPAN/ -l ~/share/minicpan
}

if [ `pwd` = '/' ];
then
    cd $HOME
fi

if [ -e "/opt/local/share/man" ];
then
    export MANPATH=/opt/local/share/man:$MANPATH
fi

# if [ -d "$HOME/share/cpan/" ]
# then
    # source =(perl -I "$HOME/share/cpan/lib/perl5/" -Mlocal::lib=~/share/cpan/)
# fi

function clone_coderepos {
    git svn clone -s http://svn.coderepos.org/share/$1
}

if [ -f ~/.zshrc-secret ];
then
    source ~/.zshrc-secret
fi

function ppport {
    perl -MDevel::PPPort -e 'Devel::PPPort::WriteFile();'
}
function bindpp {
    perl -MDevel::BindPP -e 'Devel::BindPP::WriteFile();'
}

function today() {
    local WORK DATE TODAY
    WORK=$HOME/tmp
    DATE=`date +%Y%m%d`
    TODAY=$WORK/$DATE

    mkdir -p $TODAY
    cd $TODAY
}
function nytprofgp() {
    nytprofhtml
    rm -rf rm -rf /usr/local/webapp/tmp/tmp/nytprof
    mv nytprof /usr/local/webapp/tmp/tmp/
    echo "http://64p.org/tmp/nytprof/index.html"
}


if [ -d ~/public_html/ ]
then
    function nytsetup {
        nytprofhtml; rm -rf ~/public_html/tmp/nytprof; mv nytprof/ ~/public_html/tmp/
    }
fi

function hok_foo () {
    gdb --args $*
}
function hok () {
    echo "run\nbt" | hok_foo $*
}

function perlconf() {
    perl -e 'use Config; use Data::Dumper; print Dumper(\%Config)'|lv 
}
function rfc() {
    lv "$HOME/share/docs/my-rfc-mirror/rfc$1.txt"
}
function git-ignore-elf() {
    perl -E 'use Path::Class;dir(".")->recurse(callback => sub { return if -f !$_[0] || $_[0] =~ /\.o$/;$f=file($_[0])->openr() or return;$f->read(my $buf, 4); say "$_[0]" if substr($buf,1,3) eq "ELF"; })' >> .gitignore
}
function gpath() {
    ssh gp.ath.cx
}

export PERL_AUTOINSTALL="--defaultdeps"

function google() {
    w3m http://google.com
}

function httpstatus() {perl -MHTTP::Status -e '$x=shift;print "$x ".status_message($x),$/' $*}
function daemonstat() {
    sudo perl -e '$prefix = -d "/command/" ? "/command/" : "";for (</service/*>) { $_=`${prefix}svstat $_`;s!/service/(.+?): (.+?\) )(\d+) seconds!sprintf "%-10s %-15s %3ddays %02d:%02d:%02d $3", $1, $2, $3/60/60/24,($3/60/60)%24, ($3/60)%60, $3%60!e;print }'
}
# ~/dev/ °Ê²¼¤òºÇ¿·¤Ë¤¹¤ë
function devfetch() {
    perl -e 'for (<~/dev/*>) { next unless -d "$_/.git/"; chdir $_; system q/git fetch/ }'
}
function devcheck() {
    perl -MFile::Basename=basename -e 'for (<~/dev/*>) { next unless -d "$_/.git/"; chdir $_; $x =  `git status 2> /dev/null`; $b=basename($_);print "$b: Changed\n" if $x=~/Changed/; print  "$b: $1\n" if $x=~/(Your branch is ahead of .+\.)/; }'
}
alias e="emacsclient -t"
alias v="vim"
alias u="cd ../"
alias uu="cd ../../"
alias uuu="cd ../../../"
alias uuuu="cd ../../../../"

function totalprocsize() {
    sudo perl -le 'for (@ARGV){open F,"</proc/$_/smaps" or die $!;map{/^Pss:\s*(\d+)/i and $s+=$1}<F>}printf "%.1f[MB]\n", ($s/1024.0)' `pgrep -f $1`
}
function alc() {
    if [ $# != 0 ]; then
        w3m "http://eow.alc.co.jp/$*/UTF-8/?ref=sa" | less +38
    else
        echo 'usage: alc word'
    fi
}
alias pd=perldoc
alias cpanmf="cpanm --mirror http://cpan.cpantesters.org/"

if [ -f $HOME/perl5/perlbrew/etc/bashrc ]; then
    # source $HOME/perl5/perlbrew/etc/bashrc
fi

if [ -d $HOME/perl5/perlbrew/bin/ ]; then
    export PATH=$HOME/perl5/perlbrew/bin/:$PATH
    # source $HOME/perl5/perlbrew/etc/bashrc
fi

