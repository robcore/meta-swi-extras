#!/bin/sh
# Copyright 2012 Sierra Wireless
#
# Starts the swiapp in the background
export SWI_MNT_USERRW="/mnt/userrw"


# detect the power key path - on PMIC
export SIERRA_PWR_KEY="/dev/input/`basename /sys/bus/platform/devices/pm8xxx-pwrkey/input/inp*/even*`"

if [ -f /etc/legato/.STOPSWI -o -f /etc/legato/STOPSWI ] 
then
    echo "SWI app launch stopped by presence of STOPSWI file"
    exit 0
fi

case "$1" in
    start)
        /usr/bin/swiapp > /dev/null 2>&1 &
        /usr/sbin/restart_swi_apps &
        /usr/sbin/restartNMEA > /dev/null 2>&1 &
        ;;
    stop)
        killall -q -HUP restart_swi_apps
        killall -q -HUP swiapp
        killall -q -HUP restartNMEA
        ;;
    *)
        exit 1
        ;;
esac

exit 0
