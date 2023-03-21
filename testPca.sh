#Ce fichier de test permet de tester les iptables et les règles de pare-feu mise en place sur le routeur
#R0

#Test 1 on vérifie que le ping est possible entre les deux machines pca et pcb :
ping -c 4 172.16.64.2
if [ $? -eq 0 ]
then
echo -e "\e[32mTest 1 : OK\e[0m"
else
echo -e "\e[31mTest Failed !\e[0m"
return 1
fi

#Test 2 on vérifie que le ping est impossible entre les deux machines pca et pcc :
ping -c 4 172.16.96.1
if [ $? -eq 1 ]
then
echo "\e[32mTest 2 : OK\e[0m"
else
echo -e "\e[31mTest Failed !\e[0m"
return 1
fi

#Test 3 on vérifie que le ping est impossible entre pca et internet :
ping -c 4 google.com
if [ $? -eq 1 ]
then
echo"\e[32mTest 3 : OK\e[0m"
else
echo -e "\e[31mTest Failed !\e[0m"
return 1
fi

#Test 4 on vérifie qu'internet est accessible depuis pca :
apt-get update
if [ $? -eq 0 ]
then
echo "\e[32mTest 4 : OK\e[0m"
else
echo -e "\e[31mTest Failed !\e[0m"
return 1
fi
