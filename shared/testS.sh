#Ce fichier de test permet de tester les iptables et les règles de pare-feu mise en place sur notre serveur.

#Vérifier si le script est lancé avec un argument :
if [ $# -ne 1 ]
then
echo "renseigner si vous haitez exécuter le test avec accès internet ou non pour le serveur"
echo "exemple : ./testS.sh online"
echo "exemple : ./testS.sh offline"
exit 1
fi

#Vérifier si l'argument est bien online ou offline :
if [ $1 != "online" ] && [ $1 != "offline" ]
then
echo "renseigner si vous haitez exécuter le test avec accès internet ou non pour le serveur"
echo "exemple : ./testS.sh online"
echo "exemple : ./testS.sh offline"
exit 1
fi

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

#Test 4 on vérifie qu'internet est inaccessible depuis le serveur si l'argument est offline sinon accessible :
if [ $1 == "offline" ]
then
echo "Test 4 : internet inaccessible par serveur"
ping -c 4 -w 5 google.com
if [ $? -eq 1 ]
then
echo -e "\e[32mTest 4 : OK\e[0m"
else
echo -e "\e[31mTest 4 : Test failed !\e[0m"
return 1
fi
else
echo "Test 4 : internet accessible par serveur"
ping -c 4 -w 5 google.com
if [ $? -eq 0 ]
then
echo -e "\e[32mTest 4 : OK\e[0m"
else
echo -e "\e[31mTest 4 : Test failed !\e[0m"
return 1
fi
fi

#Test 5 on vérifie que l'on peut accéder aux ports 25 de pca et de pcd depuis s :
echo "Test 5 : port 53 accessible pca (1/2)"
nmap -p 53 172.16.64.1
if [ $? -eq 0 ]
then
echo -e "\e[32mTest 5 : OK(1/2)\e[0m"
else
echo -e "\e[31mTest Failed !(1/2)\e[0m"
return 1
fi
echo "Test 5 : port 53 accessible pcd (2/2)"
nmap -p 53 172.16.96.2
if [ $? -eq 0 ]
then
echo -e "\e[32mTest 5 : OK(2/2)\e[0m"
else
echo -e "\e[31mTest Failed !(2/2)\e[0m"
return 1
fi

#Test 6 on vérifie que l'on peut accéder aux ports 80 de pca et de pcd depuis s :





