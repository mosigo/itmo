#!/bin/sh

APPLICATION=itmo-site

kill -9 `cat $APPLICATION.pid`
echo $APPLICATION was stopped