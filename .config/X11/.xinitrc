[[ -f $HOME/.config/X11/.Xresources ]] && xrdb -merge $HOME/.config/X11/.Xresources
[[ -f $HOME/.config/X11/monitor.sh ]] && sh $HOME/.config/X11/monitor.sh
[[ -f $HOME/.config/picom/picom.conf ]] && picom --config $HOME/.config/picom/picom.conf -b &
setxkbmap -model ,pc105 -layout us,pt -variant intl, &
exec i3
