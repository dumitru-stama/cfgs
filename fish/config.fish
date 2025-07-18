set fish_greeting

set -x PATH $HOME/jdk-13.0.2/bin $PATH
set -x PATH $HOME/.cargo/bin $PATH
set -x PATH /usr/local/bin $PATH
set -x PATH $HOME/stm32/texane/usr/local/bin/ $PATH
set -x PATH $HOME/tools $PATH
set -x PATH $HOME/tools/bin $PATH
set -x PATH $HOME/.local/bin $PATH
set -x PATH $HOME/go/bin $PATH
set -x PATH $HOME/rubygems/bin $PATH
# set -x PATH $HOME/data/riscv/bin $PATH
# set -x PATH $HOME/data/riscv-new/bin $PATH
# set -x PATH $HOME/data/riscv-toolchain-2024/bin $PATH
set -x PATH $HOME/data/rv64-toolchain/bin $PATH
set -x PATH $HOME/tools/node-v16.14.0-linux-x64/bin $PATH
# set -x PATH /opt/riscv/bin $PATH
set -x PATH $HOME/data/flutter/bin $PATH
set -x PATH $HOME/tools/wasmer/bin $PATH

set -x TERM xterm-256color
set -x JAVA_HOME $HOME/jdk-13.0.2
set -x ANDROID_NDK_ROOT $HOME/data/android-sdk/ndk
set -x ANDROID_HOME $HOME/data/android-sdk
set -x GEM_HOME $HOME/rubygems
set -x PDK_ROOT /home/ds/efabless/
set -x PDKPATH $PDK_ROOT/sky130A
set -x OPENLANE_ROOT $PDK_ROOT/openlane/
set -x OLLAMA_MODELS /home/ds/data/ollama/.ollama/models
set -x EDITOR $HOME/tools/hx
#alias start_openlane="cd $OPENLANE_ROOT; docker run -it -v $OPENLANE_ROOT:/openLANE_flow -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT -u $(id -u $USER):$(id -g $USER) openlane:rc6"

set __fish_git_prompt_show_informative_status 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'

alias mc=mc_chdir
function mc_chdir
        command rm /tmp/mc_last_folder
        command mc -P /tmp/mc_last_folder
        set d (cat /tmp/mc_last_folder)
        cd $d
end

alias nvim=~/tools/nvim.appimage
alias ls=exa

function ll
    command ls -al --color=auto $argv
end

function fish_prompt
        set old_status $status
        set_color 0481AE
        printf '%s•' $USER
        set_color D7D700
        printf (hostname)
        
        set_color F9EC6F
        set_color -b 5F00D7
        printf '%s' (fish_git_prompt)
        set_color normal

        printf ' '
        #set r (string split '/' (pwd))
        set r (string split '/' (pwd | sed "s|^$HOME|~|"))
        for folder in $r
                if test "$folder" != ""
                        set_color 6A6A6A
                        if test "$folder" != "~"
                                printf '/'
                        end
                        set_color 71DC34
                        printf $folder
                end
        end 

        set_color normal
        set_color FF8080
        if test $old_status -ne 0
                printf " [%s]" $old_status
        end

        set_color normal
        set_color 147DAD
        printf ' ⤑ '
end


set -gx WASMTIME_HOME "$HOME/.wasmtime"

string match -r ".wasmtime" "$PATH" > /dev/null; or set -gx PATH "$WASMTIME_HOME/bin" $PATH
# Wasmer
export WASMER_DIR="/home/ds/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"
