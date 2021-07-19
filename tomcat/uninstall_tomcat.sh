#!/bin/bash

TOMCAT=apache-tomcat-8.55.66
TOMCAT_SHUTDOWN=$TOMCAT/bin/shutdown.sh

$TOMCAT_SHUTDOWN
rm -fr $TOMCAT