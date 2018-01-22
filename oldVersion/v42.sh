#!bin/bash/
#
#Podcast 4v
#reception des podcasts via url player.fm
#Podcast Reveil 
#
#
#dependences : 
#-lecteur mp3 apt get install mplayer
#
#Amelioration :
#attribution valeurs au diff source de podcast ?
#axe => frequence de diffusion
#
#guarder une trace pour eviter de rediff un playlistpod deja ecoute
#
#afficher le descriptif du podcast en cour de lecture

#########################################
##check si le dossier exist / creation ##
#########################################

i=1
loc=$(pwd)

if [ ! -d "$loc/ghost" ]
		rm -rf $loc/ghost
	then
		mkdir $loc/ghost
fi 

touch ghost/ghost.i
touch ghost/swap.i
cd ghost
clear

###############################################################################
##constitution des listes/code source / epluchage / check les $i premiers mp3##
###############################################################################
#i = choix podlist
#id liste url

echo "https://player.fm/series/le-journal-horaire-la-1ere
https://player.fm/series/le-conseil-sant
https://player.fm/series/cinma-paris-france-bleu-paris
https://player.fm/series/cinma-week-end" > pod.i

while ((i!=5))
	do
id=$(sed -n "$i p" pod.i) 
		curl $id > swap.i
		cat swap.i | sed 's/ /\n/g' | uniq | grep -m 1  'mp3'  >> ghost.i
		((i+=1))	
	done

	cat ghost.i > swap.i
	sed -i -e 's/^......//' swap.i 
	sed -i 's/..$//' swap.i
	cat swap.i > ghost.i
clear

#######################################################
##download/rename+play+del/save original for next use##
#######################################################

i=1

while ((i!=5))
	do
id2=$i.mp3
id1=$(sed -n "$i p" ghost.i) 
		wget -nc -O $id2 $id1 
	clear
		mplayer $i.mp3
   	rm $id2
   	((i+=1))
	
	clear
	done

#############
##NETTOYAGE##
#############

cd ..
rm -r ghost

exit
