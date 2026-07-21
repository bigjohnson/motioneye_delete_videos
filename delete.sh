#!/bin/bash
MOTIONCAMERADIRS=/var/lib/motioneye/Camera*
MOTIONCAMERADEVICE=/dev/sdb1
MINIMUMFREESIZEMB=200
FAI=true
while [ ${FAI} = "true" ]
do
DISPONIBILE=$(df -BM ${MOTIONCAMERADEVICE} --output=avail | tail -1)
DISPONIBILE=${DISPONIBILE/M/}
echo available mb size ${DISPONIBILE}
echo minimum mb size ${MINIMUMFREESIZEMB}
if [ ${DISPONIBILE} -lt ${MINIMUMFREESIZEMB} ]
then
        echo insufficebt available size, deleting
        for CAMERA in ${MOTIONCAMERADIRS}
        do
                echo ${CAMERA}
                DATE=$(ls ${CAMERA} | head -n 1)
                DATENUM=${DATE//-/}
                echo ${DATE}
                echo ${DATENUM}
                if [ ! -z ${PREVDATE} ]
                then
                        echo ${PREVDATE}
                        echo ${PREVDATENUM}
                        if [ ${DATENUM} -lt ${PREVDATENUM} ]
                        then
                                PREVDATE=${DATE}
                                PREVDATENUM=${DATENUM}
                        fi
                else
                        PREVDATE=${DATE}
                        PREVDATENUM=${DATENUM}
                fi
        done
        echo ${PREVDATE}
        for CAMERA in ${MOTIONCAMERADIRS}
        do
                echo "${CAMERA}/${PREVDATE}"
                if [ -d "${CAMERA}/${PREVDATE}" ]
                then
                        echo "${CAMERA}/${PREVDATE}"
                        rm -rf "${CAMERA}/${PREVDATE}"
                fi
        done
else
        echo "available size is sufficent, don't delete"
        FAI=false
fi
done
