#!/bin/bash
#/Applications/Utilities/Terminal.app/Contents/MacOS/Terminal
CWD=$PWD
YOTTA_PATH="$CWD/prerequisites;$CWD/prerequisites/gcc-arm-none-eabi-4_9-2015q3/bin:$CWD/prerequisites/CMake.app/Contents/bin:"
PATH="$YOTTA_PATH:$PATH"
export PATH=$PATH
#virtualenv workspace
#/bin/bash "$CWD/source/test.sh" $CWD
#open --fresh -a Terminal.app $CWD/source/test.sh
#/Applications/Utilities/Terminal.app/Contents/MacOS/Terminal "$CWD"/source/test.sh "$CWD"
#exec "$CWD"/source/test.sh $CWD
#exec bash $CWD/workspace/bin/activate
#source "$CWD"/source/test.sh $CWD
echo "export YOTTA_PATH='$YOTTA_PATH';export YOTTA_CWD='$CWD';source $CWD/workspace/bin/activate;bash">$CWD/source/activateVE.sh
chmod 777 $CWD/source/activateVE.sh
open --fresh -a Terminal.app $CWD/source/activateVE.sh 
#rm $CWD/source/activateVE.sh
echo "virtualenv should be running now..."
#pip install -U yotta
