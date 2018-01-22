cine ()
{
	curl -s http://www.cinefil.com/sorties-cinema-de-la-semaine | grep 'li id' > cine.i 
	sed -i -e 's/ //g;s/^.......//g;s/..$//g;1d;$d' cine.i
}



affichage ()
{
        clear
	toilet -f mono9 EEGLOO 
	#curl -s roiseux.fr | toilet -f letter
	echo ""
	    echo "$(date '+%D %T' | toilet -f term -F border --gay)"
	    echo 'Au CINEMA cette semaine :'
	    	cat cine.i

			echo "AUDIO :"
}
cine
affichage
