#!/usr/bin/env bash

chosen=$(printf "Shutdown\nReboot\nSuspend\nHibernate" | fuzzel --dmenu)

case "$chosen" in
    Shutdown)
        systemctl poweroff
        ;;
    Reboot)
        systemctl reboot
        ;;
    Suspend)
        systemctl suspend
        ;;
    Hibernate)
        systemctl hibernate
        ;;
esac