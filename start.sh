a=`cat run.pid 2>/dev/null`
PID=`ps -ef | grep java | awk '{ print $2 }'`
if(test -z $a && test -z $PID)
then 
	nohup target/bin/webapp > /dev/null 2>&1 & echo $! >> run.pid
	echo "Application Started"
	exit
fi
if(a==PID)
then
	echo "Application Already Started"
else
	nohup target/bin/webapp > /dev/null 2>&1 & echo $! >> run.pid
	echo "Application Started"
fi

