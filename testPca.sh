#Ce fichier de test permet de tester les iptables et les règles de pare-feu mise en place sur le routeur
#R0

#Test 1 on vérifie que le ping est possible entre les deux machines pca et pcb :
ping -c 4 172.16.64.2
if [ $? -eq 0 ]
then
echo "Test 1 : OK"
else
return 1
fi

#Test 2 on vérifie que le ping est impossible entre les deux machines pca et pcc :
ping -c 4 172.16.96.1
if [ $? -eq 1 ]
then
echo "Test 2 : OK"
else
return 1
fi

#Test 3 on vérifie que le ping est impossible entre pca et internet :
ping -c 4 google.com
if [ $? -eq 1 ]
then
echo "Test 3 : OK"
else
return 1
fi

#Test 4 on vérifie qu'internet est accessible depuis pca :
sudo apt-get update
if [ $? -eq 0 ]
then
echo "Test 4 : OK"
else
return 1
fi
