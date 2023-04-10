#!/bin/bash

sudoUser=$(who am i | awk '{print $1}')
echo "sudoUser=$sudoUser"