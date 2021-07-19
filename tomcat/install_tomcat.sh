#!/bin/bash

# configurar las variables
TOMCAT=apache-tomcat-8.5.65
TOMCAT_WEBAPPS=$TOMCAT/webapps
TOMCAT_CONFIG=$TOMCAT/conf/server.xml
TOMCAT_START=$TOMCAT/bin/startup.sh
TOMCAT_ARCHIVE=$TOMCAT.tar.gz
TOMCAT_URL=http://apache.mirrorcatalogs.com/tomcat/tomcat-8/v7.0.23/bin/$TOMCAT_ARCHIVE
WAR_FILE=whatever.war

if [ ! -e $TOMCAT ]; then
    if [ ! -r $TOMCAT_ARCHIVE ]; then
	if [ -n "$(which curl)" ]; then
	    curl -O $TOMCAT_URL
	elif [ -n "$(which wget)" ]; then
	    wget $TOMCAT_URL
	fi
    fi

    if [ ! -r $TOMCAT_ARCHIVE ]; then
	echo "No se puede descargar el Tomcat." 1>&2
	echo "Verificar que curl o wget estan instalados." 1>&2
	echo "Si estan instalado, comprobar la conexion a internet y probar de nuevo." 1>&2
	echo "Se puedes descargar $TOMCAT_ARCHIVE y ponerlo en esta carpeta." 1>&2
	exit 1
    fi

    tar -zxf $TOMCAT_ARCHIVE
    rm $TOMCAT_ARCHIVE
fi

if [ ! -w $TOMCAT -o ! -w $TOMCAT_WEBAPPS ]; then
    echo "$TOMCAT y $TOMCAT_WEBAPPS deben tener permisos de lectura." 1>&2
    exit 1
fi

if [ ! -r $WAR_FILE ]; then
    echo "$WAR_FILE no esta disponible. Descárgalo y ejecutalo de nuevo para implementarlo." 1>&2
else
    cp $WAR_FILE $TOMCAT_WEBAPPS
fi

# customizacion del tomcat
#sed -i s/8080/9090/g $TOMCAT_CONFIG

$TOMCAT_START