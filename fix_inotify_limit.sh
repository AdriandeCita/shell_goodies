# Fixing inotify watch limit

# to run this script by cron add string to crontab
# 00 00 * * * /usr/bin/fix_inotify_limit.sh
# and copy script to /usr/bin/

# config file: /etc/sysctl.conf
file="/etc/sysctl.conf"
TEST_STRING="fs\.inotify\.max_user_watches"
STRING="fs.inotify.max_user_watches = 524288"

if [ -f "$file" ]

then
    # try to find our string in sysctl.conf
    if grep -q "$TEST_STRING" $file

    then
        # refresh max_user_watches param only
        sysctl -p --system
        # for non-root accounts use this line instead. Here and next
        # sudo sysctl -p --system
    else
        # append string to config
        echo $STRING >> $file
        sysctl -p --system
    fi
else
    # create new file
    echo $STRING > $file
    sysctl -p --system
    # sudo sysctl -p --system
fi
