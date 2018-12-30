#!/bin/bash
function fail(){
  echo "[*] Nenhuma NS Encontrado para o dominio $DOMAIN, encerrando..."
  exit 1
}
DOMAIN=$1
echo "[+] Iniciando Procedimentos. Alvo -> $DOMAIN"
NS=$(dig -t ns $DOMAIN +short)
[ -n "$NS" ] || fail 
echo "[+] Encontrado $(echo $NS | tr ' ' '\n' | wc -l ) NameServers"
echo "[+] Iniciando tentativa de transferência de zona"
for i in $(echo $NS)
do
  echo -e "\t[-] Testando NameServer $i do dominio $DOMAIN"
  dig @$i -t axfr $DOMAIN +short
done
