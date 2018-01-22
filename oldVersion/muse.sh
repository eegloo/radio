#!bin/bash/
i=2
loc=$(pwd)


while ((i=1))
do

    sound=`(shuf -n1 < <(find $loc/sound/zik -maxdepth 1 -type f -exec realpath {} \;))`

mplayer $sound
echo $i
((i+=1))
done




