#!/usr/bin/env sh
# NOTE: Script is not optomized - This is just a scratch logic, with lots of redundant and un needed code.


#Version of installed nzbget.
installed=$(cbsd jexec jname=nzbhydra2 ls /usr/local/share/nzbhydra2/lib/ | cut -d'-' -f 2 | xargs)
echo "Version of Installed nzbhydra2: $installed"

#Version tag on github.
num=$(curl --silent -L "https://github.com/theotherp/nzbhydra2/releases/latest" | grep -m 1 "tag_name=" | cut -d = -f 3 | cut -d'&' -f 1 |xargs)
num2=$(echo $num | cut -c2- | xargs)
echo "Version of Github nzbhydra2: $num2"

# Split version numbers into major, minor, revision.
git_major=$(echo $num2 | cut -d'.' -f 1)
git_minor=$(echo $num2 | cut -d'.' -f 2)
git_rev=$(echo $num2 | cut -d'.' -f 3)

inst_major=$(echo $installed | cut -d'.' -f 1)
inst_minor=$(echo $installed | cut -d'.' -f 2)
inst_rev=$(echo $installed | cut -d'.' -f 3)


# Major Version Logic
if [ $git_major -gt $inst_major ]; then
    echo "Major Version Number: $git_major | $inst_major "
    cbsd jexec jname=nzbhydra2 fetch -m https://github.com/theotherp/nzbhydra2/releases/download/$num/nzbhydra2-$num2-linux.zip -o /usr/local/nzbhydra2/update
    cbsd jexec jname=nzbhydra2 chown nzbhydra2:nzbhydra2 /usr/local/nzbhydra2/update/nzbhydra2-$num2-linux.zip
    cbsd jexec jname=nzbhydra2 service nzbhydra2 stop
    cbsd jexec jname=nzbhydra2 rm -rf /usr/local/share/nzbhydra2/*
    cbsd jexec jname=nzbhydra2 unzip /usr/local/nzbhydra2/update/nzbhydra2-$num2-linux.zip -d /usr/local/share/nzbhydra2/
    cbsd jexec jname=nzbhydra2 service nzbhydra2 start

#Pushover Trigger.
    new_version=$(cbsd jexec jname=nzbhydra2 ls /usr/local/share/nzbhydra2/lib/ | cut -d'-' -f 2 | xargs)
curl -s -F "token=$POTOKEN01" \
-F "user=$POUSER" \
-F "title=NZBHydra2 Update" \
-F "message=Installed Version: [v$installed][Old]
Installed Version: [v$new_version][New]
Git Version: $num" \
https://api.pushover.net/1/messages.json

    exit 0
fi

# Minor Version Logic
if [ $git_minor -gt $inst_minor ]; then
    echo "Minor Version Number: $git_minor | $inst_minor"
    cbsd jexec jname=nzbhydra2 fetch -m https://github.com/theotherp/nzbhydra2/releases/download/$num/nzbhydra2-$num2-linux.zip -o /usr/local/nzbhydra2/update
    cbsd jexec jname=nzbhydra2 chown nzbhydra2:nzbhydra2 /usr/local/nzbhydra2/update/nzbhydra2-$num2-linux.zip
    cbsd jexec jname=nzbhydra2 service nzbhydra2 stop
    cbsd jexec jname=nzbhydra2 rm -rf /usr/local/share/nzbhydra2/*
    cbsd jexec jname=nzbhydra2 unzip /usr/local/nzbhydra2/update/nzbhydra2-$num2-linux.zip -d /usr/local/share/nzbhydra2/
    cbsd jexec jname=nzbhydra2 service nzbhydra2 start

#Pushover Trigger.
    new_version=$(cbsd jexec jname=nzbhydra2 ls /usr/local/share/nzbhydra2/lib/ | cut -d'-' -f 2 | xargs)
curl -s -F "token=$POTOKEN01" \
-F "user=$POUSER" \
-F "title=NZBHydra2 Update" \
-F "message=Installed Version: [v$installed][Old]
Installed Version: [v$new_version][New]
Git Version: $num" \
https://api.pushover.net/1/messages.json

    exit 0
fi

# Revision Version Logic
if [ $git_rev -gt $inst_rev ]; then
    echo "Minor Version Number: $git_rev | $inst_rev"
    cbsd jexec jname=nzbhydra2 fetch -m https://github.com/theotherp/nzbhydra2/releases/download/$num/nzbhydra2-$num2-linux.zip -o /usr/local/nzbhydra2/update
    cbsd jexec jname=nzbhydra2 chown nzbhydra2:nzbhydra2 /usr/local/nzbhydra2/update/nzbhydra2-$num2-linux.zip
    cbsd jexec jname=nzbhydra2 service nzbhydra2 stop
    cbsd jexec jname=nzbhydra2 rm -rf /usr/local/share/nzbhydra2/*
    cbsd jexec jname=nzbhydra2 unzip /usr/local/nzbhydra2/update/nzbhydra2-$num2-linux.zip -d /usr/local/share/nzbhydra2/
    cbsd jexec jname=nzbhydra2 service nzbhydra2 start

#Pushover Trigger.
    new_version=$(cbsd jexec jname=nzbhydra2 ls /usr/local/share/nzbhydra2/lib/ | cut -d'-' -f 2 | xargs)
curl -s -F "token=$POTOKEN01" \
-F "user=$POUSER" \
-F "title=NZBHydra2 Update" \
-F "message=Installed Version: [v$installed][Old]
Installed Version: [v$new_version][New]
Git Version: $num" \
https://api.pushover.net/1/messages.json

    exit 0
fi
