#!bin/bash/
i=1
loc=$(pwd)
#
#Podcast v3bis
#reception des podcasts via le flux rss sur la derniere semaine
#
#
#
#dependences : 
#-lecteur mp3 apt get install mplayer
#
#
#Environement 
#check si les dossiers existent

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

touch ghost/ghost.i
touch ghost/swap.i

#constitution des listes/code source / epluchage / check les 5 premiers
clear
echo "
" > ghost/pod.i

#i = nb liens +1
while ((i!=5))

do
id=$(sed -n "$i p" ghost/pod.i) 

curl $id > ghost/swap.i
cat ghost/swap.i | grep 'guid' | head -n 2 >> ghost/ghost.i

((i+=1))
done
	
	cat ghost/ghost.i > ghost/swap.i
	sed -i -e 's/^.......//' ghost/swap.i 
	sed -i 's/.......$//' ghost/swap.i
	sort -rt '-' -k4 ghost/swap.i > ghost/ghost.i

clear
	cat ghost/ghost.i > ghost/listmins
	sed -i 's/http\:\/\/media\.radiofrance\-podcast\.net\/podcast09\///g' ghost/listmins


#download/rename+play+del/save original for next use
i=1
cd cast
while ((i!=25))
do
	id3=$(sed -n "$i p" ../ghost/listmins)
	id2=$i.mp3
	id1=$(sed -n "$i p" ../ghost/ghost.i) 

    wget -nc $id1
   cp $id3 $id2	
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
