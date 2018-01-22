#!/bin/bash
#
#
#Radio 
#A base de podcast | replique | musique
#dependances 
#$mplayer | $toilet | $finglet | $fortune | base de donee pub/zik
#


clear
mplayer sound/bruitage/teleport.mp3  > /dev/null 2>&1

#VARIABLE$
###############################################################




HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=5
BACKTITLE="##################################################RX"
TITLE="MENU RADIO PODCAST"
MENU="Selection"

OPTIONS=(1 "RadioPoDCast"
#Horloge | info minutes | 7h43 | sante | Meurice 
 2 "TeKniK"
#info multimedia internet tech ..
 3 "Detente"
#chroniqueur humoriste france inter
 4 "Musique")

CHOICE=$(dialog --clear \
     --backtitle "$BACKTITLE" \
     --title "$TITLE" \
     --menu "$MENU" \
     $HEIGHT $WIDTH $CHOICE_HEIGHT \
     "${OPTIONS[@]}" \
     2>&1 >/dev/tty)
#-42


#dossier actuel
loc=$(pwd)

#FONCTIONS
##############################################################

#affichage durant la lecture du podcast 
#lecture en cour | date heure encadre | citation $fortune afficher dans une bulle $cowsay avec perso aleatoire $shuf en ascii art 
aff()
{
    clear
 echo 'diffusion sonore :'
toilet -f term --filter border $diff 
 echo ''
    echo ""
    echo "$(date '+%D %T' | toilet -f term -F border --gay)"
    fortune | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n 1)
    
}

#horloge parlante ! $pico2wave passe le txt en .wav $mplayer diffuse le son
horloge ()
{

    H=$(date +%H)
    M=$(date +%M)

    pico2wave -l fr-FR -w Heure.wav "$H heures $M !";
    clear
    mplayer Heure.wav > /dev/null 2>&1
    rm Heure.wav
}

							
# lecture du mp3 $mplayer a l adresse inscrite ligne i $sed du fichier ghost.i
podplay ()
{
       url=$(sed -n "$i p" ghost.i) 
       mplayer $url > /dev/null 2>&1
}
						    
cutcut ()
{
        i=1
#trouver un moyen d initialiser $k en fonction du nb de ligne du pod.i => wc -l ...

while ((i!=k))
do
	id=$(sed -n "$i p" pod.i) 
#copier le code source $curl du site ligne i $sed de pod.i dans ghost.i

	curl -s $id > ghost.i

#decoupe du code pour garder les adresses mp3				        
      cat ghost.i | sed 's/ /\n/g' | grep 'mp3' | grep 'proxy' >> swap.i
    ((i+=1))

done
#tri chronos $sort
#decoupe des 5 premier caracteres et du dernier $sed
    sort -rt '-' -k4 swap.i > ghost.i
    sed -i -e 's/^.....//;s/.$//' ghost.i 
    echo '' > swap.i
}&>/dev/null
#fonction silencieuse


#chop le podcast du bulletin d information de 6h00 , decoupe la premiere minute (uniquement le sommaire , les titres)
info ()
{
     
    echo 'http://radiofrance-podcast.net/podcast09/rss_12559.xml' > pod.i
	            k=2
		   cutcut
#choisit un fichier au hasard dans le dossier $shuf et le met dans la variable $pub
#aff
#pub
                    horloge
			
diff='ACTUALITE MINUTE'
aff
	            url=$(sed -n "1 p" ghost.i) 
	            mplayer -endpos 00:01:15 $url > /dev/null 2>&1
					            
           echo '' > swap.i
clear
}									
					    


#Fonction menu
###########################################################

rx()
{

info

echo 'http://radiofrance-podcast.net/podcast09/rss_16650.xml
http://radiofrance-podcast.net/podcast09/rss_12337.xml' > pod.i

k=3
cutcut
i=1

while ((i!=k))
do      
	if ((i==1))
	then

diff='7h43'
 aff
	else
diff='CONSEIL SANTE'
 aff
	fi

        podplay
	((i+=1))
diff='musique'
 aff

 zik
diff='PUBLICITE' 
 aff
	pub
done
echo '' > ghost.i

#meurice
curl -s http://radiofrance-podcast.net/podcast09/rss_14257.xml  | sed 's/ /\n/g' | grep 'mp3' | grep 'proxy' > swap.i
k=1
cutcut
k=5
i=1
while ((i!=k))
do      

diff='CHRONIQUE GUILLAUME MEURICE FRANCE INTER'
 aff

 	podplay
	((i+=1))

diff='PUBLICITE' 
 aff
 pub

done

rm *.i

}

tchil()
{
#add naheulbeuk et 2mindupeuple

    echo 'http://radiofrance-podcast.net/podcast09/rss_16559.xml
http://radiofrance-podcast.net/podcast09/rss_11665.xml
http://radiofrance-podcast.net/podcast09/rss_12802.xml
http://radiofrance-podcast.net/podcast09/rss_16392.xml
http://radiofrance-podcast.net/podcast09/rss_13129.xml
http://radiofrance-podcast.net/podcast09/rss_13158.xml
http://radiofrance-podcast.net/podcast09/rss_15796.xml
http://radiofrance-podcast.net/podcast09/rss_18556.xml
http://radiofrance-podcast.net/podcast09/rss_16598.xml
http://radiofrance-podcast.net/podcast09/rss_14523.xml
http://radiofrance-podcast.net/podcast09/rss_16600.xml
http://radiofrance-podcast.net/podcast09/rss_14215.xml
http://radiofrance-podcast.net/podcast09/rss_16609.xml
http://radiofrance-podcast.net/podcast09/rss_18348.xml
http://radiofrance-podcast.net/podcast09/rss_16539.xml' > pod.i

k=16
cutcut
i=1

while ((i!=k))
do      

 diff='CHRONIQUE HUMOUR'
 aff
        
podplay
((i+=1))

 diff='MUSIQUE'
 aff

zik

 diff='PUBLICITE' 
 aff

pub

done

rm *.i

}

tek()
{
#net+ultra | c mon epok | savanturier | c deja demain | futur proche

    echo 'http://radiofrance-podcast.net/podcast09/rss_12737.xml
http://radiofrance-podcast.net/podcast09/rss_14473.xml
http://radiofrance-podcast.net/podcast09/rss_12097.xml
http://radiofrance-podcast.net/podcast09/rss_18098.xml
http://radiofrance-podcast.net/podcast09/rss_16253.xml' > pod.i

k=6
cutcut
i=1

while ((i!=k))
do      

 diff='net+ultra | c mon epok | savanturier | c deja demain | futur proche'
 aff
        
podplay
((i+=1))

 diff='MUSIQUE'
 aff

zik

 diff='PUBLICITE' 
 aff

pub

done

rm *.i





}

musique()
{
    i=1

    while ((i!=10))
    do

	    sound=`(shuf -n1 < <(find $loc/sound/zik -maxdepth 1 -type f -exec realpath {} \;))`
diff='M'
aff
	    mplayer $sound > /dev/null 2>&1
	    ((i+=1))
    done
}

pub ()
{
      adv=`(shuf -n1 < <(find $loc/sound/pub -maxdepth 1 -type f -exec realpath {} \;))`
      mplayer $adv > /dev/null 2>&1
}

zik ()
{
      sound=`(shuf -n1 < <(find $loc/sound/zik -maxdepth 1 -type f -exec realpath {} \;))`
      mplayer -endpos 00:01:52 $sound > /dev/null 2>&1
}

#reset le programme et nettoie les fichier temporaires (*.i)
goback()
{
rm *.i
    clear
    echo 'reset mode'
bash $loc/radio.sh
}
#AFFICHAGE
###################################################################




case $CHOICE in
1)
    #-enpos permet de stoper la lecture a 00:00:XX sec
mplayer -endpos 00:00:22 sound/bruitage/bulles.mp3  > /dev/null 2>&1
rx
horloge
goback

;;
2)
mplayer -endpos 00:00:07 sound/bruitage/clavier.mp3  > /dev/null 2>&1
tek
horloge
goback

;;
3)
mplayer sound/bruitage/cannette.mp3 sound/bruitage/verresoda.mp3  > /dev/null 2>&1
tchil
horloge
goback

;;
4)
musique
horloge
goback

;;
esac



clear
rm *.i


