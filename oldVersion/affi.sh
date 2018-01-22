#!/bin/bash


loc=$(pwd)

meteo ()
{
    curl -s http://www.my-meteo.com/meteo-france/paris/ | grep -e "Risque de pluie" > meteo.i
    sed -i -e 's/^.*<p>//g;s/<\/p.*$//g;s/<br \/>//g' meteo.i
	sed -i -e "1i\--Matin-----------------------" meteo.i
	sed -i -e "3i\--Apres-midi------------------" meteo.i
	sed -i -e "5i\--Soiree----------------------" meteo.i

}
 
cine ()
{
           curl -s http://www.cinefil.com/sorties-cinema-de-la-semaine | grep 'li id' > cine.i 
           sed -i -e 's/ //g;s/^.......//g;s/..$//g;1d;$d' cine.i
}


cine=$(cat "$loc/cine.i")

#whiptail --title "CINEMA CETTE SEMAINE" --msgbox "$cine" 25 42 

meteo
cat meteo.i
