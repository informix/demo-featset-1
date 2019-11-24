echo " "
echo "Note that along with re-initializing your instance from scratch, this"
echo "script will wipe out your existing config and sqlhosts files..."
echo " "
echo "Press return to continue or interrupt to quit..."
read a
echo " "
echo "Shutting down instance..."
echo " "
onmode -ky > /dev/null 2>&1
export INFORMIXDIR=/opt/ibm/informix
export PATH=".:${INFORMIXDIR}/bin:${INFORMIXDIR}/jvm/jre/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export ONCONFIG=onconfig.fs1
export INFORMIXSERVER=fs1

echo " "
echo "Creating $INFORMIXDIR/etc/$ONCONFIG..."
echo " "
cat > $INFORMIXDIR/etc/$ONCONFIG <<END
ROOTPATH     /opt/ibm/localdata/rootchunk
ROOTSIZE     500000
DBSERVERNAME fs1
MSGPATH      /opt/ibm/localdata/online.log
LOGFILES     10
LOGSIZE      10000
END

echo " "
echo "Creating root chunk..."
echo " "
cat /dev/null > /opt/ibm/localdata/rootchunk
chown informix:informix /opt/ibm/localdata/rootchunk
chmod 660 /opt/ibm/localdata/rootchunk

echo " "
echo "Creating sqlhosts file..."
echo " "
cat > $INFORMIXDIR/etc/sqlhosts <<END
fs1  onipcshm  demo_featset_1  foo1
END

echo " "
echo "Initializing instance..."
echo " "
oninit -iwy

echo " "
echo "Making the root chunk extendable just in case it fills up..."
echo " "
dbaccess sysadmin -<<END 
execute function task("modify chunk extendable on",1);
END

cat > env.sh <<END
export INFORMIXDIR=$INFORMIXDIR
export PATH=$PATH
export ONCONFIG=$ONCONFIG
export INFORMIXSERVER=$INFORMIXSERVER
END

echo " "
echo "Now set your environment to see this running instance by executing:"
echo " "
echo ". ./env.sh"
echo " "
