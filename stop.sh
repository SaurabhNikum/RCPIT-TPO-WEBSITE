a=`cat run.pid 2>1`
PID=`ps -ef | grep java | awk '{ print $2 }'`
if(a==PID)
then
	kill $PID 2>1
	rm run.pid 2>1
	echo "Application Stopped"
fi

