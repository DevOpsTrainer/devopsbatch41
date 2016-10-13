#! /bin/bash
Chagnes completed
# Initializing environment variables
GR='\e[1;32m'
NC='\e[0m'
RD='\e[1;31m'
YL='\e[1;33m'
BL='\e[0;36m'
CYN='\e[0;34m'
server=`hostname`
export JRE_HOME=/usr/java/latest
export JAVA_HOME=/usr/java/latest
export APP_ENCRYPTION_PASSWORD=MYPAS_WORD
tbin=/home/INCV/apache-tomcat-7.0.54/bin/
tlogs=/home/INCV/apache-tomcat-7.0.54/logs/
hostName=`hostname | awk -F. '{ print $1 }'`
memSettings_1="-Xmx2048m -XX:MaxPermSize=1024m"
memSettings_2="-Xmx10240m -XX:MaxPermSize=1024m"
memSettings_3="-server -d64 -Xms15360m -Xmx20480m -XX:MaxPermSize=1024m"
sortSetting="-Djava.util.Arrays.useLegacyMergeSort=true"
opnet=" -Xbootclasspath/a:/opt/Panorama/hedzup/mn/lib/awcore/JIDAcore.jar -Dpanorama.jida.instance=Incentives -agentpath:/opt/Panorama/hedzup/mn/lib/libAwProfile64.so=logni "
gc_opts=" -XX:+PrintGCDetails -XX:+PrintTenuringDistribution -XX:+PrintGCCause -XX:+PrintGCApplicationStoppedTime -XX:+PrintGCDateStamps -XX:+DisableExplicitGC -XX:+UseG1GC -XX:MaxGCPauseMillis=500 -Xloggc:gc.log "

case ${hostName} in
	nyc-itginctrt1)
		export JAVA_OPTS="${memSettings_1} ${sortSetting}";
		;;
	nyc-itginctrt2)
		export JAVA_OPTS="${memSettings_1} ${sortSetting}";
		;;
	nyc-itg2inctrt1)
		export JAVA_OPTS="${memSettings_1} ${sortSetting}";
		;;
	nyc-itg2inctrt2)
		export JAVA_OPTS="${memSettings_1} ${sortSetting}";
		;;
	nyc-preinctrt01)
		export JAVA_OPTS="${memSettings_2} ${sortSetting} ${opnet} ${gc_opts}";
		;;
	nyc-preinctrt02)
		export JAVA_OPTS="${memSettings_2} ${sortSetting} ${opnet} ${gc_opts}";
		;;
	nyc-qa2inctrt1)
		export JAVA_OPTS="${memSettings_1} ${sortSetting}";
		;;
	nyc-qa2inctrt2)
		export JAVA_OPTS="${memSettings_1} ${sortSetting}";
		;;
	nyc-crtinctrt01)
		export JAVA_OPTS="${memSettings_2} ${sortSetting} ${opnet} ${gc_opts}";
		;;
	nyc-crtinctrt02)
		export JAVA_OPTS="${memSettings_2} ${sortSetting} ${opnet} ${gc_opts}";
		;;
        nyc-crtinctrt03)
                export JAVA_OPTS="${memSettings_2} ${sortSetting} ${opnet} ${gc_opts}";
                ;;
	clt-prdinctrt01)
		export JAVA_OPTS="${memSettings_3} ${sortSetting} ${opnet} ${gc_opts}";
		;;
	clt-prdinctrt02)
		export JAVA_OPTS="${memSettings_3} ${sortSetting} ${opnet} ${gc_opts}";
		;;
       clt-prdinctrt03)
                export JAVA_OPTS="${memSettings_3} ${sortSetting} ${opnet} ${gc_opts}";
                ;;
       clt-prdinctrt04)
                export JAVA_OPTS="${memSettings_3} ${sortSetting} ${opnet} ${gc_opts}";
                ;;
	nycuvdemoincv01)
		export JAVA_OPTS="${memSettings_2} ${sortSetting} ${opnet} ${gc_opts}";
		;;
	nyc-a34ncvapp01)
		export JAVA_OPTS="${memSettings_1} ${sortSetting}";
		;;
esac

cd ${tbin} || exit 1
CSTART=$(date +%s) 
echo ""
# Starting Tomcat Server
./catalina.sh start
echo "JAVA_OPTS": $JAVA_OPTS
cd ${tlogs} || exit 1
# Verifing logs to confirm startup
echo ""
echo -e "${GR}Monitoring server logs on $server server${NC}"
echo ""
echo -e "${GR}Please wait to load the server completely${NC}"
echo ""
tail -n0 -F ./catalina.out | while read LINE

do
	 if [ `echo $LINE | egrep -wc "Server startup in"` -gt 0 ];
	then
		pkill -9 -P $$ tail
		CEND=$(date +%s)
		CDIFF=$(( $CEND - $CSTART ))
		echo -e "${GR}Tomcat  has sucessfully started in ${CYN}$CDIFF${NC} seconds. ${NC}"
		echo ""
		exit
	fi
done

