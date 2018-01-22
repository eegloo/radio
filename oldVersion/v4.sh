#!bin/bash/
i=1
loc=$(pwd)
#
#Podcast 4v
#reception des podcasts via url player.fm
#Podcast Techno
#
#
#dependences : 
#-lecteur mp3 apt get install mplayer
#
#
#Environement 
#check si les dossiers existent
#creation

if [ ! -d "$loc/ghost" ]
rm -rf $loc/ghost
then
    mkdir $loc/ghost
fi

if [ ! -d "$loc/cast" ]
rm -rf $loc/cast
then
    mkdir $loc/cast
fi

touch ghost/host.i
touch ghost/swap.i
cd ghost

#selection podcast liste


#constitution des listes/code source / epluchage / check les 5 premiers
clear

echo "
" > pod.i

#i = choix podlist
#id liste url
id=$(sed -n "$i p" pod.i) 

curl $id > swap.i
cat swap.i | sed 's/ /\n/g' | grep -m 30 'mp3' | uniq >> ghost.i

	cat ghost.i > swap.i
	sed -i -e 's/^......//' swap.i 
	sed -i 's/..$//' swap.i
	cat swap.i > ghost.i
clear


#download/rename+play+del/save original for next use
i=1
cd ../cast
while ((i!=10))
do
	id2=$i.mp3
	id1=$(sed -n "$i p" ../ghost/ghost.i) 

    wget -nc -O $id2 $id1 
clear
   mplayer $i.mp3
   rm $id2
   ((i+=1))
clear

	done
cd ..

#NETTOYAGE
rm -r cast/
rm -r ghost

exit
