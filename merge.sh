#!/bin/sh
if [ $# != 2 ]; then
    echo "You need to specify exaclty two args: 1) Path of Hub, 2) Path of Lab"
    exit 1
fi

hub=$1
lab=$2

if [ ! -d $hub ] || [ ! -d $lab ]; then
    echo "One or two arguments are wrong"
    exit 1
fi

cd $hub && git pull && cd ..

cp -fR "${hub}/front" "${lab}/front"
cp -fR "${hub}/back" "${lab}/back"

cd $lab

git add front back
git commit -m "auto merge for $(date +'%d/%m/%Y %H:%M')"
git push

