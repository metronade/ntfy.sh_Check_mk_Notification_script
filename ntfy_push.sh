#!/bin/bash
# ntfy notification script
# You can replace "https://ntfy.sh" with your own ntfy.sh instance

USER="user" #ntfy user with wrtiepermission to your topic
PASSWORD="password" #ntfy user password
TOPIC="$NOTIFY_PARAMETER_1" #ntfy topic you want to push to - will be gathered from check_mk notification parameters if configured correct.
CHECKTYP="$NOTIFY_PARAMETER_2" #Descripe if you want Notifications for HOST, SERVICE or ALL - will be gathered from check_mk notification parameters if configured correct.

#Notfication for HOST Problems only
if [[ "$CHECKTYP" == "HOST" ]]
then
    if [[ "$NOTIFY_WHAT" == "$CHECKTYP" ]]
    then
        curl -u $USER:$PASSWORD -d "$NOTIFY_HOSTNAME ist $NOTIFY_HOSTSTATE Meldung: $NOTIFY_HOSTOUTPUT" -H "Title: $NOTIFY_HOSTNAME ist $NOTIFY_HOSTSTATE" -H "Priority: max" https://ntfy.sh/$TOPIC
    fi
fi

#Notification for SERVICE Problems only
if [[ "$CHECKTYP" == "SERVICE" ]]
then
    if [[ "$NOTIFY_WHAT" == "$CHECKTYP" ]]
    then
        curl -u $USER:$PASSWORD -d "$NOTIFY_HOSTNAME $NOTIFY_SERVICEDESC is $NOTIFY_SERVICESTATE - $NOTIFY_SERVICEOUTPUT" -H "Title: $NOTIFY_HOSTNAME $NOTIFY_SERVICEDESC is $NOTIFY_SERVICESTATE" -H "Priority: max" https://ntfy.sh/$TOPIC
    fi
fi

#Notification for HOST & SERVICE Problems
if [[ "$CHECKTYP" == "ALL" ]]
then
    if [[ "$NOTIFY_WHAT" == "HOST" ]]
       then
        curl -u $USER:$PASSWORD -d "$NOTIFY_HOSTNAME ist $NOTIFY_HOSTSTATE Meldung: $NOTIFY_HOSTOUTPUT" -H "Title: $NOTIFY_HOSTNAME ist $NOTIFY_HOSTSTATE" -H "Priority: max" https://ntfy.sh/$TOPIC
    fi

    if [[ "$NOTIFY_WHAT" == "SERVICE" ]]
    then
        curl -u $USER:$PASSWORD -d "$NOTIFY_HOSTNAME - $NOTIFY_SERVICESTATE - $NOTIFY_SERVICEDESC - $NOTIFY_SERVICEOUTPUT" -H "Title: $NOTIFY_HOSTNAME - $NOTIFY_SERVICESTATE - $NOTIFY_SERVICEDESC" -H "Priority: max" https://ntfy.sh/$TOPIC
    fi
fi
