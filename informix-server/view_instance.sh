echo " "
echo "Be sure your environment is set properly before running this script. Here are your current settings:"
echo " "
echo "INFORMIXDIR:    $INFORMIXDIR"
echo "ONCONFIG:       $ONCONFIG"
echo "INFORMIXSERVER: $INFORMIXSERVER"
echo "PATH:           $PATH"
echo " "
echo "Assuming all looks good there, widen your terminal window to ~150 characters (the width of this line) and press return to verify that your instance is"
echo "up and running..."
read a
onstat -
if [ $? -eq 255 ]
then
    echo " "
    echo "Your instance does not appear to be running. Exiting."
    echo " "
    exit 1
else
    echo "Your instance is running!"
    sleep 1
fi

while true
do
    echo " "
    echo "Now enter the number of the resource you would like to display. The output will be piped to 'less', so type 'q' to return to this menu:"
    echo " "
    echo "1)   Disk configuration and usage"
    echo "2)   Virtual Processor info"
    echo "3)   Thread list"
    echo "4)   User list"
    echo "5a)  SQL Statements (basic)"
    echo "5b)  SQL Statements (full)"
    echo "6)   Shared memory segments"
    echo "7)   Memory pools"
    echo "8)   Buffer cache"
    echo "9)   Checkpoint history"
    echo "10a) Configuration parameter settings (basic)"
    echo "10b) Configuration parameter settings (full)"
    echo "11)  Tail of message log"
    echo "12)  Locks"
    echo "13)  Physical and logical log info"
    echo "14)  Active tablespaces"
    echo "ld)  Start a load on the server."
    echo "ex)  Exit"
    read a
    if [ "$a" = "1" ]
    then
        onstat -d | less
    elif [ "$a" = "2" ]
    then
        onstat -g glo | less
    elif [ "$a" = "3" ]
    then
        onstat -g ath | less
    elif [ "$a" = "4" ]
    then
        onstat -u | less
    elif [ "$a" = "5a" ]
    then
        onstat -g sql | less
    elif [ "$a" = "5b" ]
    then
        onstat -g sql 0 | less
    elif [ "$a" = "6" ]
    then
        onstat -g seg | less
    elif [ "$a" = "7" ]
    then
        onstat -g mem | less
    elif [ "$a" = "8" ]
    then
        onstat -b | less
    elif [ "$a" = "9" ]
    then
        onstat -g ckp | less
    elif [ "$a" = "10a" ]
    then
        onstat -g cfg | less
    elif [ "$a" = "10b" ]
    then
        onstat -g cfg full | less
    elif [ "$a" = "11" ]
    then
        onstat -m | less
    elif [ "$a" = "12" ]
    then
        onstat -k | less
    elif [ "$a" = "13" ]
    then
        onstat -l | less
    elif [ "$a" = "14" ]
    then
        onstat -t | less
    elif [ "$a" = "ld" ]
    then
        echo "Setting transaction high water marks to 100%..."
        onmode -wm LTXEHWM=100 > /dev/null 2>&1
        onmode -wm LTXHWM=100 > /dev/null 2>&1
        echo "Running load in background..."
        sh run_load.sh &
    elif [ "$a" = "ex" ]
    then
        CNT=`ps -ef | grep run_load.sh | grep -v grep | wc -l`
	if [ $CNT -eq 0 ]
	then
	    exit 0
	fi
        echo "Killing any loaders. It make take them some time for the backend thread (sqlexec) to exit and disappear from the server..."
        while true
        do
            CNT=`ps -ef | grep run_load.sh | grep -v grep | wc -l`
            if [ $CNT -eq 0 ]
            then
                break
            fi
            PID=`ps -ef | grep run_load.sh | grep -v grep | head -1 | awk '{print $2}'`
            if [ "${PID}x" != "x" ]
            then
                kill $PID
                sleep 1
            fi
        done
        exit 0
    else
        echo "$a is not a choice, fool."
    fi
done
