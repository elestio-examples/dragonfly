#set env vars
# set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 60s;

target=$(docker-compose port manager 8080)

curl http://${target}/installation

login=$(curl http://${target}/api/v1/users/signin \
  -H 'accept: application/json' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
  -H 'content-type: application/json;charset=UTF-8' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36' \
  --data-raw '{"name":"root","password":"dragonfly"}' \
  --compressed)

access_token=$(echo $login | jq -r '.token' )
  
  curl http://${target}/api/v1/configs \
  -H 'accept: application/json' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
  -H 'content-type: application/json;charset=UTF-8' \
  -H 'cookie: jwt='${access_token}'' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36' \
  --data-raw '{"name":"is_boot","value":"1","user_id":1}' \
  --compressed



curl https://${DOMAIN}/api/v1/users/1/reset_password \
-H 'authority: '${DOMAIN}'' \
  -H 'accept: application/json' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
  -H 'content-type: application/json;charset=UTF-8' \
  -H 'cookie: jwt='${access_token}'' \
  -H 'origin: https://'${DOMAIN}'' \
  -H 'referer: https://'${DOMAIN}'/profile/1' \
  -H 'sec-ch-ua: "Not_A Brand";v="99", "Google Chrome";v="109", "Chromium";v="109"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36' \
  --data-raw '{"old_password":"dragonfly","new_password":"'${ADMIN_PASSWORD}'","confirm_password":"'${ADMIN_PASSWORD}'"}' \
  --compressed