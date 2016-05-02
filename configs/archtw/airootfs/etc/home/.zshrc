[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# wget -O .zshrc-grml http://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
[ -r ~/.zshrc-grml ] && source ~/.zshrc-grml # http://grml.org/zsh
pathadd() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$PATH:$1"
  fi
}

export LANG=en_US.UTF-8
export LC_CTYPE=zh_TW.UTF-8
export GOPATH=$HOME/go
pathadd ~/bin
pathadd ~/go/bin

# java run time font https://wiki.archlinux.org/index.php/Java_Runtime_Environment_Fonts
#export _JAVA_OPTIONS='-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel' 
#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
export JAVA_FONTS=/usr/share/fonts/TTF

set -o emacs
export LS_COLORS=$LS_COLORS:'di=0;35:' 
