[[ -f $HOME/.config/X11/.Xresources ]] && xrdb -merge $HOME/.config/X11/.Xresources
[[ -f $HOME/.config/X11/.XCompose ]] && xrdb -merge $HOME/.config/X11/.XCompose
[[ -f $HOME/.config/picom/picom.conf ]] && picom --config $HOME/.config/picom/picom.conf -b &
exec i3
