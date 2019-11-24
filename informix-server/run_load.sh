MMSS=`date +%M%S`
DBNAME="db${MMSS}"

dbaccess sysadmin -<<END > /dev/null 2>&1
execute function task("modify chunk extendable on",1);
END

while true
do
if [ -f stop ]
then
exit 0
fi
dbaccessdemo $DBNAME <<END > /dev/null 2>&1
n
END
done
