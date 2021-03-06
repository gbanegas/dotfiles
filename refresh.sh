#!/bin/bash
#
# written by Katie Wolfe <dnaf.moe>
#
# based on git.io/v5Zn6
#
# TODO: figure out if i can set 256 colors

send() {
	for pts in /dev/pts/[0-9]*; do
		printf ${1} > $pts
	done
}

# getbase [number]
# gets the given base16 color
# example: getbase 0A
getbase() {
	xrdb -query | grep -Po "(?<=base$1:\t)#[[:xdigit:]]{6}"
}

# setspecial [Ps] [Pt]
setspecial() {
	send "\033]$1;$2\007"
}

# setcolor [index] [color]
# returns sequence
setcolor() {
	send "\033]4;$1;$2\007"
}

echo "Merging .Xresources"
xrdb -merge ~/.Xresources

echo "Restarting i3"
i3-msg restart &

echo "Restarting compton"
killall compton
compton > /dev/null &

echo "Restarting dunst"
killall dunst
dunst 2> /dev/null &

echo "Setting terminal colors"
setcolor    0 $(getbase 00)
setcolor    1 $(getbase 08)
setcolor    2 $(getbase 0B)
setcolor    3 $(getbase 0A)
setcolor    4 $(getbase 0D)
setcolor    5 $(getbase 0E)
setcolor    6 $(getbase 0C)
setcolor    7 $(getbase 05)
setcolor    8 $(getbase 03)
setcolor    9 $(getbase 08)
setcolor   10 $(getbase 0B)
setcolor   11 $(getbase 0A)
setcolor   12 $(getbase 0D)
setcolor   13 $(getbase 0E)
setcolor   14 $(getbase 0C)
setcolor   15 $(getbase 07)
setcolor   16 $(getbase 09)
setcolor   17 $(getbase 0F)
setcolor   18 $(getbase 01)
setcolor   19 $(getbase 02)
setcolor   20 $(getbase 04)
setcolor   21 $(getbase 06)

setspecial 10 $(getbase 05) # foreground
setspecial 11 $(getbase 00) # background
setspecial 12 $(getbase 05) # cursor
setspecial 13 $(getbase 05) # mouse
setspecial 708 $(getbase 00) # border
