# TestBlogRoR

## О проекте
Это тестовый проект. Сайт-блог, где зарегистрированные пользователи могут писать посты и оставлять комментарии.
- На главной странице должен быть список постов с пагинацией.
- Необходим фильтр постов по принципу все/мои.
- В посте обязательны быть: название поста, описание поста, возможность прикрепить картинку. После публикации пост можно редактировать и удалить.
- Также необходимо сделать админку. В админке: все пользователи (емейл, имена, пароли) и список всех постов.
- Необходимо покрыть функционал тестами rspec.

## Установка
Создать `.env` по примеру `.env.example`.
Сбилдить, запустить контейнеры и настроить базу данных командой:
```sh
docker-compose up -d --build
docker-compose run web db:setup
```
