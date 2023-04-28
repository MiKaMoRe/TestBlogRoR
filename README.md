# TestBlogRoR

## Установка
Создать `.env` по примеру `.env.example`.
Сбилдить, запустить контейнеры и настроить базу данных командой:
```
docker-compose up -d --build
docker-compose run web db:setup
```

