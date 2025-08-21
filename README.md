# Trainer docs

## Запуск
Перейти в директорию `hugo` и прочитать там, или `docker-compose up`

## Hugo
Перейти в директорию hugo и запустить командой `hugo server --disableFastRender`, на `http://localhost:1313/` будет сайт, пути по которым рендерит находятся в директории `hugo/content/`. Тема с документацией - https://imfing.github.io/hextra/docs/guide/markdown/. Для запуска нужно установить hugo [installation](https://gohugo.io/installation/)

## CI / Permissions

Сборка разделена на 2 флоу, одна собирает новый хелм чарт, другая собирает обновлённый образ со всей документацией. Обновление чарта требуется при изменении прав для групп баунсера и находится по пути `.helm/hugo/templates/configmap.yaml`. Добавление репозиториев в документацию происходит из `.github/workflows/ci.yaml` в секции `### Checkout repositories with docs and put into hugo`

## Образы
https://docker.hugomods.com/