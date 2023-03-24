sudo iptables -F FORWARD

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -A INPUT -i lo -j ACCEPT
iptables -P FORWARD DROP

iptables -A FORWARD -p tcp -m multiport --sport 25,53,80,465,587,2525 -s 172.16.96.0/20 -d 172.16.112.0/20 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -p tcp -m multiport --sport 25,53,80,465,587,2525 -s 172.16.64.0/20 -d 172.16.112.0/20 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -p tcp -m multiport --dport 25,53,80,465,587,2525 -s 172.16.112.0/20 -d 172.16.96.0/20 -m conntrack --ctstate NEW,RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -p tcp -m multiport --dport 25,53,80,465,587,2525 -s 172.16.112.0/20 -d 172.16.64.0/20 -m conntrack --ctstate NEW,RELATED,ESTABLISHED -j ACCEPT

iptables -A FORWARD -p udp --dport 53 -s 172.16.112.0/20 -m conntrack --ctstate NEW,RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -p udp --sport 53 -d 172.16.112.0/20 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -p tcp -m multiport --sport 22,443 -s 172.16.112.0/20 -d 172.16.64.0/20 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -p tcp -m multiport --sport 22,443 -s 172.16.112.0/20 -d 172.16.96.0/20 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -p tcp -m multiport --dport 22,443 -d 172.16.112.0/20 -s 172.16.96.0/20 -m conntrack --ctstate NEW,RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -p tcp -m multiport --dport 22,443 -d 172.16.112.0/20 -s 172.16.64.0/20 -m conntrack --ctstate NEW,RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -p icmp -d 172.16.112.35 -j ACCEPT
iptables -A FORWARD -p icmp -s 172.16.112.35 -j ACCEPT