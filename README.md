# supermegarega_microservices
supermegarega microservices repository

# homework-13 Технология контейнеризации. Введение в Docker

- Установлен docker.
- Запущен контейнер hello-world.
- Создан image smr/ubuntu-tmp-file из контейнера.
- Вывод docker images сохранен в docker-monolith/docker-1.log (дано объяснение основных отличий docker container от docker image).
- Удалены контейнеры и образы.
- Изучены базовые команды для управления Docker.

# homework-14 Docker-контейнеры. Docker под капотом

- Создан новый проект docker в GCP
- Настроена docker-machine
- Создан docker образ smrdevops/otus-reddit
- Создана учетная запись на https://hub.docker.com/ 
- Образ otus-reddit загружен в hub.docker.com
- Протестирована работа образа otus-reddit в docker-host и локально
- Реализовано:
    поднятие инстансов с помощью Terraform
    плэйбуки ansible с использованием gce.py для установки docker и запуска образа приложения
    шаблон packer для создания образа с установленным docker

# homework-15 Docker-образа. Микросервисы

- Установлен hadolint для проверки Dockerfile
- Добавлены компоненты post-py, comment, ui в каталог src
- Созданы образы (post:1.0, comment:1.0, ui:1.0)
- Создана bridge-сеть reddit и запущены контейнеры
- Протестирована работа приложения
- Запущены контейнеры с новыми сетевыми алиасами с использованием ENV-переменных в командной строке
- Собраны образы на основе alpine linux
- Предложен вариант для уменьшения образов (post:3.0, comment:3.0, ui:4.0)
- Подключен docker volume reddit_db
- Протестирована работа контейнеров с использованием docker volume

# homework-16 Docker: сети, docker-compose

- Запущены контейнеры с разными драйверами (none, host, bridge)
- Прослежены изменения namespace-ов с использованием разных драйверов
- Протестирована работа контейнеров с использованием network-alias
- Протестирована работа контейнеров с несколькими bridge сетями

