#!bin/bash/
i=0
loc=$(pwd)
#
#MEURICAST v1.0
#reception des podcasts 'moment meurice' de france inter sur la derniere semaine
#
#dependences : 
#-lecteur mp3 apt get install mplayer
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


#code source / epluchage / check les 5 premiers
curl https://www.franceinter.fr/emissions/le-moment-meurice | grep '[...]2017' | head -n 6 > ghost/ghost.i
clear


sed -i 's/\(data-url=\| \|"\)//g' ghost/ghost.i 
cp ghost/ghost.i ghost/list
sed -i 's/https\:\/\/media\.radiofrance\-podcast\.net\/podcast09\///g' ghost/list


#download/rename+play+del/save original for next use

cd cast
while ((i!=7))
do
	id2=$i.mp3
	id1=$(sed -n "$i p" ../ghost/ghost.i) 
	id3=$(sed -n "$i p" ../ghost/list)

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
#rm -r cast/
rm -r ghost

exit
