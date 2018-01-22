#!bin/bash/
i=1
loc=$(pwd)
#
#Podcast v3bis
#reception des podcasts via le flux rss sur la derniere semaine
#Emissions Scientifique 
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
echo "http://radiofrance-podcast.net/podcast09/rss_14257.xml
http://radiofrance-podcast.net/podcast09/rss_12625.xml
http://radiofrance-podcast.net/podcast09/rss_12737.xml
http://radiofrance-podcast.net/podcast09/rss_16559.xml" > ghost/pod.i
touch ghost/ghost.i
touch ghost/swap.i
while ((i!=4))
do

id=$(sed -n "$i p" ghost/pod.i) 
curl $id > ghost/swap.i
cat ghost/swap.i | grep 'guid' | head -n 6 >> ghost/ghost.i
((i+=1))
done
	
	cat ghost/ghost.i > ghost/swap.i
	sed -i -e 's/^.......//' ghost/swap.i 
	sed -i 's/.......$//' ghost/swap.i
	sort -rt '-' -k4 ghost/swap.i > ghost/ghost.i

#clear
	cat ghost/ghost.i > ghost/listmins
	sed -i 's/http\:\/\/media\.radiofrance\-podcast\.net\/podcast09\///g' ghost/listmins


#download/rename+play+del/save original for next use
i=1
cd cast
while ((i!=20))
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
