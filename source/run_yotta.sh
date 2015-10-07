#!/bin/bash
#/Applications/Utilities/Terminal.app/Contents/MacOS/Terminal
CWD=$PWD
YOTTA_PATH="$CWD/prerequisites;$CWD/prerequisites/gcc-arm-none-eabi-4_9-2015q3/bin:$CWD/prerequisites/CMake.app/Contents/bin:"
echo "yt path = $YOTTA_PATH"
PATH="$YOTTA_PATH:$PATH"
echo "path = $PATH"
export PATH=$PATH
#virtualenv workspace
#/bin/bash "$CWD/source/test.sh" $CWD
#open --fresh -a Terminal.app $CWD/source/test.sh
#/Applications/Utilities/Terminal.app/Contents/MacOS/Terminal "$CWD"/source/test.sh "$CWD"
#exec "$CWD"/source/test.sh $CWD
#exec bash $CWD/workspace/bin/activate
#source "$CWD"/source/test.sh $CWD
echo "starting up"
echo "export YOTTA_PATH='$YOTTA_PATH'
export YOTTA_CWD=\"$CWD\"
source \"$CWD\"/workspace/bin/activate
clear
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export PS1='(yotta workspace) \W \\$'
PS1='\[\033[36m\](yotta workspace)\[\033[m\] \[\033[32m\]\w\[\033[m\] \\$ '
/bin/sh
">"$CWD"/source/activateVE.sh
chmod 777 "$CWD"/source/activateVE.sh
echo "about to run terminal"
open --fresh -a Terminal.app "$CWD"/source/activateVE.sh
#rm '$CWD/source/activateVE.sh'
echo "virtualenv should be running now..."
#pip install -U yotta
