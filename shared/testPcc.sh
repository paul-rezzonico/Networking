#Ce fichier de test permet de tester les iptables et les règles de pare-feu mise en place sur la zone
#administration.

#Test 1 on vérifie que le ping est possible entre les deux machines pcc et pcd :
echo "Test 1 : ping entre pcc et pcd"
ping -c 4 -w 5 172.16.96.2
if [ $? -eq 0 ]
then
echo -e "\e[32mTest 1 : OK\e[0m"
else
echo -e "\e[31mTest 1 : Test failed !\e[0m"
return 1
fi

#Test 2 on vérifie que le ping est impossible entre les deux machines pcc et pca :
echo "Test 2 : ping entre pcc et pca"
ping -c 4 -w 5 172.16.64.1
if [ $? -eq 1 ]
then
echo -e "\e[32mTest 2 : OK\e[0m"
else
echo -e "\e[31mTest 2 : Test failed !\e[0m"
return 1
fi

#Test 3 on vérifie que le ping est impossible entre pcc et internet :
echo "Test 3 : ping entre pcc et internet"
ping -c 4 -w 5 google.com
if [ $? -eq 1 ]
then
echo -e "\e[32mTest 3 : OK\e[0m"
else
echo -e "\e[31mTest 3 : Test failed !\e[0m"
return 1
fi

#Test 4 on vérifie qu'internet est accessible depuis pcc :
echo "Test 4 : internet accessible par pcc"
apt-get update
if [ $? -eq 0 ]
then
echo -e "\e[32mTest 4 : OK\e[0m"
else
echo -e "\e[31mTest 4 : Test failed !\e[0m"
return 1
fi

#Test 5 on vérifie que l'on ne peut pas accéder aux ports 25 depuis pca :
echo "Test 5 : port 25 filtré serveur s (non accessibles)"
nmap -p 25  172.16.112.35 | grep closed >> logs.txt
if [ $? -eq 1 ]
then
echo -e "\e[32mTest 5 : OK(1/2)\e[0m"
else
echo -e "\e[31mTest Failed !(1/2)\e[0m"
return 1
fi
nping --tcp -p 25 172.16.112.35 | grep closed >> logs.txt
if [ $? -eq 1 ]
then
echo -e "\e[32mTest 5 : OK(2/2)\e[0m"
else
echo -e "\e[31mTest Failed !(2/2)\e[0m"
return 1
fi

#Test 6 on vérifie que l'on ne peut pas accéder au port 53 depuis pca :
echo "Test 6 : port 53 filtré serveur s (non accessibles)"
nmap -p 53 172.16.112.35 | grep closed >> logs.txt
if [ $? -eq 1 ]
then
echo -e "\e[32mTest 6 : OK(1/2)\e[0m"
else
echo -e "\e[31mTest Failed !(1/2)\e[0m"
return 1
fi
nping --tcp -p 53 172.16.112.35 | grep closed >> logs.txt
if [ $? -eq 1 ]
then
echo -e "\e[32mTest 6 : OK(2/2)\e[0m"
else
echo -e "\e[31mTest Failed !(2/2)\e[0m"
return 1
fi

#Test 7 on vérifie que l'on ne peut pas accéder au port 80 depuis pca :
echo "Test 7 : port 80 filtré serveur s (non accessibles)"
nmap -p 80 172.16.112.35 | grep closed >> logs.txt
if [ $? -eq 1 ]
then
echo -e "\e[32mTest 7 : OK(1/2)\e[0m"
else
echo -e "\e[31mTest Failed !(1/2)\e[0m"
return 1
fi
nping --tcp -p 80 172.16.112.35 | grep closed >> logs.txt
if [ $? -eq 1 ]
then
echo -e "\e[32mTest 7 : OK(2/2)\e[0m"
else
echo -e "\e[31mTest Failed !(2/2)\e[0m"
return 1
fi

#Test 8 on vérifie que l'on ne peut pas accéder au port 465 depuis pca :
echo "Test 8 : port 465 filtré serveur s (non accessibles)"
nmap -p 465 172.16.112.35 | grep closed >> logs.txt
if [ $? -eq 1 ]
then
echo -e "\e[32mTest 8 : OK(1/2)\e[0m"
else
echo -e "\e[31mTest Failed !(1/2)\e[0m"
return 1
fi
nping --tcp -p 465 172.16.112.35 | grep closed >> logs.txt
if [ $? -eq 1 ]
then
echo -e "\e[32mTest 8 : OK(2/2)\e[0m"
else
echo -e "\e[31mTest Failed !(2/2)\e[0m"
return 1
fi

#Test 9 on vérifie que l'on ne peut pas accéder au port 587 depuis pca :
echo "Test 9 : port 587 filtré serveur s (non accessibles)"
nmap -p 587 172.16.112.35 | grep closed >> logs.txt
if [ $? -eq 1 ]
then
echo -e "\e[32mTest 9 : OK (1/2)\e[0m"
else
echo -e "\e[31mTest Failed !(1/2)\e[0m"
return 1
fi
nping --tcp -p 587 172.16.112.35 | grep closed >> logs.txt
if [ $? -eq 1 ]
then
echo -e "\e[32mTest 9 : OK (2/2)\e[0m"
else
echo -e "\e[31mTest Failed !(2/2)\e[0m"
return 1
fi


#Test 10 on vérifie que l'on ne peut pas accéder au port 2525 depuis pca :
echo "Test 10 : port 2525 filtré serveur s (non accessibles)"
nmap -p 2525 172.16.112.35 | grep closed >> logs.txt
if [ $? -eq 1 ]
then
echo -e "\e[32mTest 10 : OK(1/2)\e[0m"
else
echo -e "\e[31mTest Failed !(1/2)\e[0m"
return 1
fi
nping --tcp -p 2525 172.16.112.35 | grep closed >> logs.txt
if [ $? -eq 1 ]
then
echo -e "\e[32mTest 10 : OK(2/2)\e[0m"
else
echo -e "\e[31mTest Failed !(2/2)\e[0m"
return 1
fi

#Test 11 on vérifie que l'on peut accéder au port 443 depuis pca :
echo "Test 11 : port 443 accessible serveur s (application dpart)"
nmap -p 443 172.16.112.35 | grep filtered
if [ $? -eq 1 ]
then
echo -e "\e[32mTest 11 : OK(1/2)\e[0m"
else
echo -e "\e[31mTest Failed !(1/2)\e[0m"
return 1
fi
nping --tcp -p 443 172.16.112.35 | grep filtered >>logs.txt
if [ $? -eq 1 ]
then
echo -e "\e[32mTest 11 : OK(2/2)\e[0m"
else
echo -e "\e[31mTest Failed !(2/2)\e[0m"
return 1
fi
