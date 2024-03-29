#!/bin/env fish

set paths (string collect (cat ~/.dotfiles/utils/tmux_dirs))

set single_dirs /home/user/.config /home/user/projects /home/user/.dotfiles
set paths (fd -d 1 -t d . (string split " " (echo $paths | sd "~" "/home/user"))) $single_dirs

if test -z argv
	set selected $argv[1]
else
	set selected (string collect $paths | fzf)
end

if ! set -q selected
	exit 0
end

set dir $selected
set name (path basename $dir | tr . _)
echo dir $dir
echo name $name

if test -z $TMUX && test -z $tmux_running
    tmux new-session -s $name -c $dir
    exit 0
end
if not tmux has-session -t=$name 2> /dev/null
    tmux new-session -ds $name -c $dir
end
tmux switch-client -t $name
