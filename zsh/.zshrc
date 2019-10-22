source /usr/share/mc/bin/mc.sh

# zsh config
autoload -U colors && colors
SEP_LINE='────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────'

LS_COLORS='rs=0:di=01;38;5;111:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'
export LS_COLORS

#RPROMPT="%{$reset_color%}%{$bg[black]%}%{$fg[white]%}---[ %D{%Y/%m/%d %H:%M:%S} ]%{$reset_color%}"
RPROMPT="---[ %D{%Y/%m/%d %H:%M:%S} ]"

# fastest possible way to check if repo is dirty
function prompt_lean_git_dirty() {

    # check if we're in a git repo
    command git rev-parse --is-inside-work-tree &>/dev/null || return
    # check if it's dirty
    local umode="-uno" #|| local umode="-unormal"
    gitout="$(git status --short | wc -l)"

    if [[ "${gitout}" != 0 ]] ; then
    	echo " ${gitout}"
    fi
}

setopt prompt_subst
function compute_prompt () {
    last_exit_code=$?

	if [[ $EUID -ne 0 ]]; then
    	sep="⤑"
		sep_bg=236
		sep_fg=31
	else
    	sep="⩩"
		sep_bg=236
		sep_fg=9
	fi

	user_fg=184
	user_bg=236
	host_fg=184
	host_bg=236
	user_body="%n"
	host_body="%m"
	user_seg=""
    host_seg="%K{${sep_bg}}%F{${sep_fg}}${user_body}%K{${sep_bg}}%F{${sep_fg}}•%K{${host_bg}}%F{${host_fg}}${host_body}"

    git_bg=56
    git_fg=227
    git_edited_bg=202
    git_edited_fg=56
	is_git="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
	if [ "$is_git" ]; then


		s=""

		git_body="[$(git branch | grep \* | cut -d ' ' -f2)]${s}"
		git_open_count="$(prompt_lean_git_dirty)"
	    if [ "${git_open_count}" != "" ]; then
	        git_body="${git_body}%K{${git_edited_bg}}%F{${git_edited_fg}}${git_open_count}"
	    fi
	    git_body="${git_body}"
	    git_seg=" %K{${git_bg}}%F{${git_fg}}${git_body}"
	fi

    loc_bg=236
    loc_fg=10
    loc_path_sep_fg=242
    loc_body="$(echo "${PWD}" | sed "s!%!%%!g" | sed "s!/!%F{${loc_path_sep_fg}}/%F{${loc_fg}}!g")"
    loc_seg=" %K{${loc_bg}}${loc_body}%F{${loc_bg}} "

    if [ "${last_exit_code}" = 0 ] ; then
        last_status_bg=33
        last_status_fg=11
        last_status_body=""
    else
        last_status_bg=196
        last_status_fg=11
        last_status_body=" ${last_exit_code} "
    fi
    last_status_seg="%K{${last_status_bg}}%F{${last_status_fg}}${last_status_body}"

    cmd_bg=236
    cmd_fg=7
    cmd_seg="%K{${sep_bg}}%F{${sep_fg}}${sep}%K{${cmd_bg}}%F{${cmd_fg}} "
    echo "${user_seg}${host_seg}${git_seg}${loc_seg}${last_status_seg}${cmd_seg}"
}

local compute_prompt_var='$(compute_prompt)'

if [[ /proc/$PPID/exe -ef /usr/bin/mc ]]
then
    plugins=()
    RPROMPT=
    PS1="%~> "
else
    plugins=()
    if [ "$TERM" != "linux" ]; then
    fi
    PS1="${compute_prompt_var}%b%u%s%f%k%E"
fi

COMPLETION_WAITING_DOTS="true"

unsetopt correct_all
WORDCHARS=-
DISABLE_AUTO_TITLE=true

bindkey '^i' menu-complete
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word


function my_cls () {
    zle push-line
    BUFFER=" clear"
    zle accept-line
}
zle -N my_cls

bindkey '^l' my_cls


function fav_cmds () {
    zle push-line
    BUFFER='c'
    zle accept-line
}
zle -N fav_cmds

bindkey "^[c" fav_cmds

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select list-colors ${(s.:.)LS_COLORS}
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==36=35}:${(s.:.)LS_COLORS}")';
setopt menu_complete

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_dups share_history inc_append_history extended_history hist_ignore_space

alias gs='git status'
alias t='tmux attach-session -d || tmux'
alias ls='ls --color=auto'
alias l='ls -al'
alias pu='sudo apt update && sudo apt upgrade'
alias pi='sudo apt install'
alias pf='apt-cache search'
alias gm='grep --color=auto -R --include'
#alias gsrc='grep --color=auto -R --include="*.[ch]" --include="*.[ch]pp"'

#---------------------------------------------------------------------------------------------
export TERM=xterm-256color
export JAVA_HOME=$HOME/jdk-8u222
export ANDROID_NDK_ROOT=$HOME/android-sdk/ndk-bundle
export ANDROID_HOME=$HOME/android-sdk
#export PYTHON_INCLUDE_DIRS=/usr/include/python3.6
#export PYTHON_LIBRARIES=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/libpython3.6.so
export PATH=$HOME/jdk-8u222/bin:$HOME/.cargo/bin:/usr/local/bin:$HOME/stm32/texane/usr/local/bin/:$PATH

