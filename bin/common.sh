error() {
  echo " !     $*" >&2
  exit 1
}

status() {
  echo "-----> $*"
}

protip() {
  echo
  echo "PRO TIP: $*" | indent
  echo "See https://devcenter.heroku.com/articles/nodejs-support" | indent
  echo
}

# sed -l basically makes sed replace and buffer through stdin to stdout
# so you get updates while the command runs and dont wait for the end
# e.g. npm install | indent
indent() {
  c='s/^/       /'
  case $(uname) in
    Darwin) sed -l "$c";; # mac/bsd sed: -l buffers on line boundaries
    *)      sed -u "$c";; # unix/gnu sed: -u unbuffered (arbitrary) chunks of data
  esac
}

cat_npm_debug_log() {
  test -f $build_dir/npm-debug.log && cat $build_dir/npm-debug.log
}


install_db2_odbc() {
		DB2_DIR="$1"
		echo "---------------------------------"
		echo "patmc2go in use - v.001"
		echo $DB2_DIR
		echo "---------------------------------"
		echo "test DB2_DIR/clidriver"
		ls -l $DB2_DIR 
		echo "---------------------------------"
		dir $DB2_DIR
		echo "---------------------------------"
		#ls $DB2_DIR/clidriver
		echo "---------------------------------"
		if [ ! -d "$DB2_DIR/clidriver" ]; then
			echo "---------------------------------"
			echo "In the if/test for /clidriver dir"
		        #mkdir -p "$DB2_DIR"
		        DB2_DSDRIVER_URL="http://rtpgsa.ibm.com/home/p/a/patmc/public/v9.7fp9_linuxx64_odbc_cli.tar.gz"
			#DB2_DSDRIVER_URL="https://sqldbclientwrapper.stage1.mybluemix.net/public/db2client/v9.7fp9_linuxx64_odbc_cli.tar.gz"
			echo "---------------------------------"
			echo "DB2_DSDRIVER_URL:" ${DB2_DSDRIVER_URL}
			#echo "skipping download"
			status "downloading DB2 ODBC driver..."
			curl ${DB2_DSDRIVER_URL} -o ${DB2_DIR}/clidriver.tgz
			echo "---------------------------------"
			echo "about to tar/extract..."
			tar xzf ${DB2_DIR}/clidriver.tgz -C ${DB2_DIR}
			#tar xzf ${DB2_DIR}/clidriver/v9.7fp9_linuxx64_odbc_cli.tar.gz -C ${DB2_DIR}
			echo "---------------------------------"
			echo "...done with tar/extract"
                        #Delete the archive
                        #rm -rf ${DB2_DIR}/clidriver.tgz
		fi
		export IBM_DB_HOME="$DB2_DIR/clidriver/odbc_cli/clidriver"
		echo "---------------------------------"
		echo "IBM_DB_HOME:" $IBM_DB_HOME
}
