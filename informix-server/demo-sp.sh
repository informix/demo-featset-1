SPACE_DIR=/opt/ibm/localdata
echo " "
echo "This script demonstrates some basic storage provisioning commands,"
echo "creating all the different space types we support. It will first shut"
echo "down and then re-initialize your current instance from scratch. Press"
echo "return to continue or interrupt to quit..."
read a
echo " "
echo "Shutting down instance..."
echo " "
onmode -ky
echo " "
echo "Zeroing out root chunk..."
echo " "
ROOTCHUNK=`oninit -t | grep ROOTPATH | awk '{print $3}'`
cat /dev/null > $ROOTCHUNK

echo " "
echo "Re-initializing instance..."
echo " "
oninit -iwy
if [ $? -ne 0 ]
then
    echo "Re-init failed. Check message log for errors."
    exit
fi

echo " "
echo "Adding $SPACE_DIR to storage pool and creating spaces..."
echo " "
dbaccess sysadmin -<<END
execute function task("modify chunk extendable on",1);
execute function task("storagepool add","$SPACE_DIR",0,0,10000,2);
execute function task("create dbspace from storagepool","userdbs1",10000);
execute function task("create tempdbspace from storagepool","tempdbs1",10000);
execute function task("create blobspace from storagepool","blobspace1",10000);
execute function task("create sbspace from storagepool","sbspace1",10000);
execute function task("create tempsbspace from storagepool","tempsbspace1",10000);
execute function task("create plogspace from storagepool","plogspace",10000);
END
