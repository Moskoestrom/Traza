 #!/bin/bashRate measure
echo "Telintel IP (last 3 digits)"
read TelintelIP
Tel_IP=$(echo "10.170.0.${TelintelIP}")
echo $Tel_IP
echo "Client/Vendor IP"
read C_V_IP
echo "Client/Vendor Port"
read port
Password=$(echo "'TrZ!N0c.SmS'")
Wireshark=$(echo "wireshark-gtk -k -i-")

if [ -n "${TelintelIP}" ]; 
then
	#echo "Telintel IP Valid"
	if [ -n "${C_V_IP}" ]; 
	then
		#echo "With IP"
		if [ -n "${port}" ];
		then
			#echo "With IP, with port"
			filter=$(echo "'(host ${C_V_IP} or port ${port})'")
			#echo ${filter}
			trace=$(echo "sshpass -p ${Password} ssh trazas@${Tel_IP} \"/usr/sbin/tcpdump ${filter} -i any -s 1500 -w -\" | ${Wireshark}")	
			eval ${trace}		
		else
			#echo "with IP, without port"
			filter=$(echo "'(host ${C_V_IP})'")
			#echo "${filter}"
			trace=$(echo "sshpass -p ${Password} ssh trazas@${Tel_IP} \"/usr/sbin/tcpdump ${filter} -i any -s 1500 -w -\" | ${Wireshark}")	
			eval ${trace}		
		fi
	else
                if [ -n "${port}" ];
                then
                        #echo "Without IP, with Port"
                        filter=$(echo "'(port ${port})'")
                        #echo "${filter}"
			trace=$(echo "sshpass -p ${Password} ssh trazas@${Tel_IP} \"/usr/sbin/tcpdump ${filter} -i any -s 1500 -w -\" | ${Wireshark}")
			eval ${trace}			
		else
			#echo "Without Ip, without port"
			trace=$(echo "sshpass -p ${Password} ssh trazas@${Tel_IP} \"/usr/sbin/tcpdump -i any -s 1500 -w -\" | ${Wireshark}")
			eval ${trace}	
		fi
	fi

else
	echo "Telintel IP void"
fi



echo ${TelintelIP}
echo ${C_V_IP}
echo ${port}




