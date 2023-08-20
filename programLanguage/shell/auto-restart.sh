 #!/bin/bash
 
 RESTART_COUNT=0
 MAX_RESTART_COUNT=30
 
 # 获取属于11.11.11.0/24网段的IP
 LOCAL_IP=$(ip -o -4 addr list | grep 11.11.11 | awk '{print $4}' | cut -d/ -f1)
 echo "LOCAL_IP is $LOCAL_IP"
 
 last=${LOCAL_IP##*.}
 echo "last is $last" 
 
 while true; do
   for i in {1..30}; do
     if [ "$i" -eq "$last" ]; then
       echo "jump local ip: $LOCAL_IP"
     else
       if ping -c 1 11.11.11.$i &>/dev/null; then
         echo "Connected to 11.11.11.$i"
         RESTART_COUNT=0
         echo "wait for next 15 minute" 
         break
       else
         echo "can not connect to 11.11.11.$i"
       fi
     fi
     
     if [ $i -eq 30 ]; then
       echo "Unable to connect to 11.11.11.1-11.11.11.15 for $RESTART_COUNT minuted"
       ((RESTART_COUNT++)) 
     fi
   done
 
   if [ $RESTART_COUNT -eq $MAX_RESTART_COUNT ]; then
     echo "Restarting the system..."
     reboot
   fi
 
   sleep 60
 done
