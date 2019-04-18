#!/bin/bash
set -e

if [ `whoami` == "root" ]; then
    if [ "$RUNTIME" == "python" ] || [ "$RUNTIME" == "python2" ] || [ "$RUNTIME" == "python2.7" ]; then
        echo "Using python v2.7 runtime"
    elif [ "$RUNTIME" == "python3" ] || [ "$RUNTIME" == "python3.7" ]; then
        echo "Using python v3.7 runtime"
    elif [ "$RUNTIME" == "python3.6" ]; then
        echo "Using python v3.6 runtime"
        ln -sf /opt/python-${PYTHON_VERSION_3_6}/bin/python3 /usr/bin/python3
        ln -sf /opt/python-${PYTHON_VERSION_3_6}/bin/pip3 /usr/bin/pip3
    elif [ "$RUNTIME" == "node" ] || [ "$RUNTIME" == "node6" ]; then
        echo "Using node v8 runtime"
    fi

    if [ "$HOST_UID" != "" ]; then
        # If the user is root and a HOST_UID environment variable exists,
        # we change the myrmex user UID and execute the command as the myrmex user
        if [ "$HOST_UID" != `id -u $DEFAULT_USER` ]; then
            echo "Changing $DEFAULT_USER UID to $HOST_UID"
            change-uid $HOST_UID $HOST_GID >/dev/null
        fi
    fi

fi

exec $@
