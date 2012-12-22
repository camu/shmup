#!/bin/ash

DATA="";

play() {
	for f in $DATA; do
		echo "Now playing $f";
		if [ "`echo $f|sed -e 's/.*\.mp3/mp3/'`" = "mp3" ]; then
			mpg123 $f;
		else
			ogg123 $f;
		fi
	done
}

SHUF="false";
REP="false";
DIR="~/";

while true; do
	if [ $1 ]; then
		if [ "$1" = "-s" ]; then
			SHUF="true";
		elif [ "$1" = "-r" ]; then
			REP="true";
		elif [ "$1" = "-d" ]; then
			DIR=$2;
			shift;
		fi;
		shift;
	else
		break;
	fi
done

echo "About to play dir \`$DIR' w/ following options";
if [ "$SHUF" = "false" ]; then
	echo -e "\tshuffle off";
	DATA="`find $DIR|awk '/(flac|ogg|mp3)$/'`";
else
	echo -e "\tshuffle on";
	DATA="`find $DIR|awk '/(flac|ogg|mp3)$/'|shuf`";
fi
if [ "$REP" = "false" ]; then
	echo -e "\trepeat off";
else
	echo -e "\trepeat on";
fi

play;
while [ "$REP" = "true" ]; do
	play;
done
