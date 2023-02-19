apt install jq -y

mkdir -p ./config

ip="172.17.0.1"

    sed "s,__IP__,$ip," template/dfget.template.yaml > config/dfget.yaml
    sed "s,__IP__,$ip," template/seed-peer.template.yaml > config/seed-peer.yaml
    sed "s,__IP__,$ip," template/scheduler.template.yaml > config/scheduler.yaml
    sed "s,__IP__,$ip," template/manager.template.yaml > config/manager.yaml
