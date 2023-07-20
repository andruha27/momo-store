# Momo Store aka Пельменная №2

<img width="900" alt="image" src="https://user-images.githubusercontent.com/9394918/167876466-2c530828-d658-4efe-9064-825626cc6db5.png">

## Frontend

```bash
npm install
NODE_ENV=production VUE_APP_API_URL=http://localhost:8081 npm run serve
```

## Backend

```bash
go run ./cmd/api
go test -v ./... 
```

## Описание

### Создание инфраструктуры

> Данный этап предполагает, что у вас есть аккаунт в яндекс облаке с достаточным количеством средств на балансе.

`terraform apply -var="token=<Token>" -var="folder_id=<Folder id>" -var="zone=<Zone id>"`

Полученный публичный IP необходимо внести в CI/CD Variables в GitLab, для того, чтобы на созданную виртуальную 
машину происходил деплой.

### CI/CD Variables
`DEV_HOST` - IP виртуальной машины
`DEV_USER` - Имя пользователя, от имени которого происходит деплой (пользователь создается в терраформе)
`DOCKER_SECRET` - Секрет для авторизации в Gitlab Container Registry, именно само значение секрета
`SSH_PRIVATE_KEY` - Приватный ключ, для авторизации на VDS, публичный записывает в терраформе

### Деплой приложения

Деплой приложения полностью автоматизированный. Автоматически запускается пайплайн полного цикла при наличии 
изменений в исходном коде. Backend и frontend разделены и могут деплоится по отдельности.
При первом разворачивании приложения необходимо заполнить необходимые переменные в GitLab и запустить пайплайн