# supermegarega_infra
supermegarega Infra repository

# Конфигурация
Создал два экземпляра VM  bastion и someinternalhost.
Настроил ssh Forwarding для подключения.
Настроил OpenVPN сервер для подключения.
```
bastion_IP = 35.195.174.202
someinternalhost_IP = 10.132.0.3
```

Запуск ssh агента
`ssh-agent`

Добавление приватного ключа
`ssh-add ~/.ssh/appuser`

ssh Forwarding
`~/.ssh/config`
```
Host bastion
  Hostname 35.195.174.202
  User appuser

Host someinternalhost
  Hostname 10.132.0.3
  User appuser
  ProxyCommand ssh -v bastion -W %h:%p
```
Подключение в одну команду  
`ssh -i ~/.ssh/appuser -A appuser@someinternalhost`

Подключение по алиасу
`~/.bash_profile`
```
...
...
alias someinternalhost='ssh -i ~/.ssh/appuser -A appuser@someinternalhost'
```
`ssh someinternalhost`

# Конфигурация cloud-testapp.
reddit-app_IP = 35.205.66.67
testapp_IP = 35.205.66.67
testapp_PORT = 9292
install_ruby.sh - скрипт установки Ruby
install_mongodb.sh - скрипт установки Mongodb
deploy.sh - скрипт установки Puma
startup_script.sh - скрипт автоматической установки и деплоя Puma.

# Создание VM с помощью gcloud CLI.

gcloud compute instances create reddit-app \
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=/home/smr/supermegarega_infra/startup_script.sh

gcloud compute --project=infra-198011 firewall-rules create default-puma-server \
  --direction=INGRESS \
  --priority=1000 \
  --network=default \
  --action=ALLOW \
  --rules=tcp:9292 \
  --source-ranges=0.0.0.0/0 \
  --target-tags=puma-server

#Зависимости
google-cloud-sdk
ruby-full
ruby-bundler
build-essential
mongodb-org

