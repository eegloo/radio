#!bin/bash/
i=0
loc=$(pwd)
#
#Podcast v2.0
#reception des podcasts via le flux rss sur la derniere semaine
#Emission La Minute Scientifique 
#
#dependences : 
#-lecteur mp3 apt get install mplayer
#
#
#Environement 
#check si les dossiers exsitent

if [ ! -d "$loc/ghost" ]
then
    mkdir $loc/ghost
fi

if [ ! -d "$loc/cast" ]
then
    mkdir $loc/cast
fi


#constitution des listes/code source / epluchage / check les 5 premiers
#clear
	curl http://radiofrance-podcast.net/podcast09/rss_18098.xml | grep 'guid' | head -n 6 > ghost/ghost3.i
	curl http://radiofrance-podcast.net/podcast09/rss_16589.xml | grep 'guid' | head -n 6 > ghost/ghost2.i
	curl http://radiofrance-podcast.net/podcast09/rss_14312.xml | grep 'guid' | head -n 6 > ghost/ghost1.i
#clear
while ((i!=3))
do
	((i+=1))
	sed -i -e 's/^.......//' ghost/ghost$i.i 
	sed -i 's/.......$//' ghost/ghost$i.i
done
i=0
	paste -d '\n' 'ghost/ghost2.i' 'ghost/ghost1.i' 'ghost/ghost3.i' > ghost/ghost.i
	cat ghost/ghost.i > ghost/listmins
	sed -i 's/http\:\/\/media\.radiofrance\-podcast\.net\/podcast09\///g' ghost/listmins


#download/rename+play+del/save original for next use

cd cast
while ((i!=14))
do
	id3=$(sed -n "$i p" ../ghost/listmins)
	id2=$i.mp3
	id1=$(sed -n "$i p" ../ghost/ghost.i) 

    wget -nc $id1
   cp $id3 $id2	
#clear
   mplayer $i.mp3
   rm $id2
   ((i+=1))
#clear

	done
cd ..

#NETTOYAGE
#rm -r cast/
#rm -r ghost

exit
