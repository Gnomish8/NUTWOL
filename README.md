PREREQUISITE: Requires wakeonlan package to be installed on the NUT server if not already running (apt install wakeonlan). 

Modify a copy of the wol.sh shell script to match your environment and make it executable (sudo chmod u+x /path/to/script/wol.sh)

Update your Crontab to run the wol script at whatever frequency works for you, I run it every 30 minutes.

NUT Server configurations provided to help with setup. If you've got yours running smoothly already, all you really need is wol.sh

ntfy configured for notifications, feel free to remove if unused, or configure your own notification utility!
