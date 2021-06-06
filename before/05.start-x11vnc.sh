#/bin/sh
echo "Current DIR is " $PWD
while [ 1 ]; do
 x11vncpid=`ps -a|grep x11vnc|grep -v grep |awk '{print $1}'`
 if [ "$x11vncpid" ]
 then
     echo "x11vnc is running,pid is" $x11vncpid
 else
     echo "x11vnc is down ,now starting ...";  x11vnc -noxdamage&
 fi
 sleep 20
done
