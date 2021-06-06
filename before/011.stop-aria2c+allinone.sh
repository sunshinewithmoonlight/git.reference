ps -x|grep aria2c|grep -v grep|awk '{print $1}'|xargs kill

