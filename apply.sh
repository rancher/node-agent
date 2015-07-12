#!/bin/bash

. ${CATTLE_HOME:-/var/lib/cattle}/common/scripts.sh

if [ -e /etc/monit/conf.d/cattle-node ]; then
    monit unmonitor cattle-node || true
    rm -vf /etc/monit/conf.d/cattle-node
    reload_monit
fi

if [ -e /etc/init.d/cattle-node ]; then
    if /etc/init.d/cattle-node status; then
        /etc/init.d/cattle-node stop
    fi
    rm -vf /etc/init.d/cattle-node
fi

if [ -e ${CATTLE_HOME}/node-services ]; then
    rm -rvf ${CATTLE_HOME}/node-services
fi
