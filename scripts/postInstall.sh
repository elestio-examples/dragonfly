#set env vars
set -o allexport; source .env; set +o allexport;

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

  curl http://${target}/api/v1/users/1 \
  -H 'accept: */*' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
  -H 'cookie: jwt='${access_token}'' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36' \
  --compressed



curl http://${target}/api/v1/users/1/reset_password \
  -H 'accept: application/json' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
  -H 'content-type: application/json;charset=UTF-8' \
  -H 'cookie: jwt='${access_token}'' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36' \
  --data-raw '{"old_password":"dragonfly","new_password":"'${ADMIN_PASSWORD}'","confirm_password":"'${ADMIN_PASSWORD}'"}' \
  --compressed


  curl https://${DOMAIN}/api/v1/users/1/reset_password \
  -H 'authority: dragonfly-yuyu-u353.vm.elestio.app' \
  -H 'accept: application/json' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
  -H 'content-type: application/json;charset=UTF-8' \
  -H 'cookie: ph_phc_7F92HoXJPeGnTKmYv0eOw62FurPMRW9Aqr0TPrDzvHh_posthog=%7B%22distinct_id%22%3A%22JQn7DMcdtzK5g3ILsZ5Ko%22%2C%22%24device_id%22%3A%22185fe5c0c521826-0d7abf7a8f6f13-26021051-1fa400-185fe5c0c53ad7%22%2C%22%24referrer%22%3A%22https%3A%2F%2Fdash.elest.io%2F%22%2C%22%24referring_domain%22%3A%22dash.elest.io%22%2C%22%24sesid%22%3A%5B1675078656704%2C%221860277e2c05ce-03d41af6316c37-26021051-1fa400-1860277e2c11cea%22%2C1675078656704%5D%2C%22%24user_id%22%3A%22JQn7DMcdtzK5g3ILsZ5Ko%22%2C%22%24active_feature_flags%22%3A%5B%5D%2C%22%24enabled_feature_flags%22%3A%7B%7D%2C%22%24session_recording_enabled_server_side%22%3Afalse%7D; ajs_anonymous_id=93fd7d45-2f30-4972-b019-93f1cdd540a9; _ga=GA1.1.2136135344.1675585239; _ga_R4YJ9JN8L4=GS1.1.1676460410.18.1.1676461759.0.0.0; jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NzY5NzUyNjksImlkIjoxLCJvcmlnX2lhdCI6MTY3NjgwMjQ2OX0.7gf-8xyjE4jduRSxcfPrD99yE87Mr30klkRLJQFzdag' \
  -H 'origin: https://dragonfly-yuyu-u353.vm.elestio.app' \
  -H 'referer: https://dragonfly-yuyu-u353.vm.elestio.app/profile/1' \
  -H 'sec-ch-ua: "Not_A Brand";v="99", "Google Chrome";v="109", "Chromium";v="109"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36' \
  --data-raw '{"old_password":"dragonfly","new_password":"Test1234#","confirm_password":"Test1234#"}' \
  --compressed