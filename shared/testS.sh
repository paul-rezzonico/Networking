#Ce fichier de test permet de tester les iptables et les règles de pare-feu mise en place sur notre serveur.

#Test 1 on vérifie que le ping est impossible entre le serveur et pca :
echo "Test 1 : ping entre serveur et pca"
ping -c 4 -w 5 172.16.64.1
if [ $? -eq 1 ]
then
echo -e "\e[32mTest 1 : OK\e[0m"
else
echo -e "\e[31mTest 1 : Test failed !\e[0m"
return 1
fi

#Test 2 on vérifie que le ping est impossible entre le serveur et pcd :
echo "Test 2 : ping entre serveur et pcd"
ping -c 4 -w 5 172.16.96.2
if [ $? -eq 1 ]
then
echo -e "\e[32mTest 2 : OK\e[0m"
else
echo -e "\e[31mTest 2 : Test failed !\e[0m"
return 1
fi

#Test 3 on vérifie que le ping est possible entre le serveur et internet :
echo "Test 3 : ping entre serveur et internet"
ping -c 4 -w 5 google.com
if [ $? -eq 0 ]
then
echo -e "\e[32mTest 3 : OK\e[0m"
else
echo -e "\e[31mTest 3 : Test failed !\e[0m"
return 1
fi

#Test 4 on vérifie qu'internet est inaccessible depuis le serveur :
echo "Test 4 : internet inaccessible par le serveur"
apt-get update
if [ $? -eq 1 ]
then
echo -e "\e[32mTest 4 : OK\e[0m"
else
echo -e "\e[31mTest 4 : Test failed !\e[0m"
return 1
fi




