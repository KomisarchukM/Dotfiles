# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]]; then
  # Shell is non-interactive.  Be done now!
  return
fi
export VISUAL="nvim"
export EDITOR="nvim"
#export BAT_STYLE="plain"
#export BAT_THEME="gruvbox-dark"
export PS1='\[\e[38;5;208m\]\w\[\e[0m\] \[\e[38;5;208m\]\\$\[\e[0m\] '
alias ff="fastfetch"
alias ..="cd .."
alias smci="rm -f config.h && sudo make clean install"
alias r="ranger"

# Put your fun stuff here.
