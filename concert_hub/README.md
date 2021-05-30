# Concert Hub

Concert Hub - is an event management system, which consists of the following services: tickets, booking, purchase, turnstile and log.

## Состав
- [Log Service](https://gitlab.w55.ru/awesome_team/concert_hub/-/blob/master/log_service/README.md)
- [Turnstile Service](https://gitlab.w55.ru/awesome_team/concert_hub/-/blob/master/turnstile_service/README.md)
- [Reserve Service](https://gitlab.w55.ru/awesome_team/concert_hub/-/blob/master/reserve_service/README.md)
- [Tickets Service](https://gitlab.w55.ru/awesome_team/concert_hub/-/blob/master/tickets_service/README.md)

## Сборка и запуск
```
docker-compose build
docker-compose up -d
```

Log Service будет доступен по адресу http://localhost:8180/.  
Turnstile Service будет доступен по адресу http://localhost:8190/.  
Tickets Service будет доступен по адресу http://localhost:8170/.  
Reserve Service будет доступен по адресу http://localhost:8160/.  
