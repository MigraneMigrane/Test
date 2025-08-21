---
title: "Rustdesk"
cascade:
  type: docs
---

Приложение для удалённого рабочего стола с открытым исходным кодом, разработанное для self-hosting в качестве альтернативы VNC/TeamViewer/AnyDesk, поддерживающее релеи и LDAP/OIDC аутентификацию. Документация разбита на пользовательскую и техническую части. [Официальная документация](https://rustdesk.com/docs/en/)

## Быстрый старт
> [!NOTE]
> Пользователь создаётся во время успешного логина в rustdesk
{{% steps %}}

### Step 1
{{< tabs items="Оператор, Разработчик/Тестировщик" >}}

  {{< tab >}}
  Попросить старшего оператора добавить в группу `rustdesk-users` (Bouncer), залогиниться на странице [rustdesk.netsrv.pw](https://rustdesk.netsrv.pw/) нажав `Continue with Bouncer SSO`, запросить добавить в нужную группу операторов внутри rustdesk.
  {{< /tab >}}
  {{< tab >}}
  Завести задачу на команду TRN.Infra для доступа к определлёным игровым машинам, после перевода задачи в статус `Done` залогиниться на странице [rustdesk.netsrv.pw](https://rustdesk.netsrv.pw/) нажав `Continue with Bouncer SSO`
  {{< /tab >}}

{{< /tabs >}}


### Step 2
Получить программу `rustdesk-operator-portable.exe` (windows) или `rustdesk-operator-arm64.dmg` (macos), нажать на иконку с монитором > Войти > `Continue with Bouncer SSO`
![monitor-icon](./pc_icon.webp)

{{% /steps %}}

## FAQ
> Нет кнопки Continue with Bouncer SSO

Нет связи со сервера rustdesk.netsrv.pw по тем или иным причинам. На некоторых пк блокировует встроенный браундмауэр windows и антивирус

> Сброшено удалённым узлом (на любое подключение)

Некоторые proxy клиенты ломают hole-punching, следует их выключить и подключить корпоративный vpn.