# ntfy.sh_Check_mk_Notification_script

This is a simple Notification script for the Push Notification service, https://ntfy.sh.
It works for the offered service and also for the self-hosted version of ntfy.sh.

As it was more convenient for me to make the filtering what to be pushed within the script,
you can define if you want push messages only for HOST alerts, SERVICE Alerts, or both.
(I only want a notification if a Host is Down, but not if a Filesystem is running full, or something is flapping.)


Notification script need to be placed within the omd user
```
omd su yourmonitoringsite
```

Place the script under ~/local/share/check_mk/notifications and give it permissions to be executed.
```
cd ~/local/share/check_mk/notifications
nano ntfy_push.sh   #Insert ntfy.sh script
chmod +x ntfy_push.sh
```

To Finally make the script visible in Check_MK Notification methods, we need to restart the apache webserver of the site.
```
omd restart apache
```

To Start with your First push Notifications you need to Add a New Notification Rule, chose ntfy_push as notification method and call it with the following parameters
Parameter 1: your ntfy topic you want to push to
Parameter 2: HOST, SERVICE or ALL - to describe which notification type you like.