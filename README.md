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


