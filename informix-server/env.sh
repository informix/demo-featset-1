#### These settings aren't directly related to Informix
export BASEDIR=/opt/ibm
export SCRIPTS=$BASEDIR/scripts
export INFORMIX_HOME=/home/informix
export HOSTNAME=`hostname`
export INFORMIX_DATA_DIR=$BASEDIR/data
export INFORMIX_CONFIG_DIR=$BASEDIR/config
export INFORMIX_FILES_DIR=$BASEDIR/files
export INFORMIXSQLHOSTS=$INFORMIXDIR/etc/sqlhosts
export INIT_LOG=$INFORMIX_DATA_DIR/init_status.log

#### The following are variables that Informix binaries use
export INFORMIXDIR=$BASEDIR/informix
export PATH=":${INFORMIXDIR}/bin:$INFORMIXDIR/jvm/jre/bin:.:${PATH}"
export INFORMIXSERVER=informix
export ONCONFIG=onconfig.fs1
export LD_LIBRARY_PATH="${INFORMIXDIR}/lib:${INFORMIXDIR}/lib/esql:${LD_LIBRARY_PATH}"
