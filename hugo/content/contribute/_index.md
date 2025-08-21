---
title: "Hugo"
date: 2025-06-14
cascade:
  type: docs
sidebar:
  open: true
---

Это генератор статических сайтов, написанный на языке Go. Он позволяет быстро создавать сайты, генерируя готовые HTML-страницы из шаблонов и контента (обычно написанного в Markdown). Это особенно удобно для блогов, документации, портфолио и других проектов, где не нужен полноценный backend. Очень высокая скорость генерации даже больших сайтов ⚡ 

## Установка и запуск
Официальная инструкция по установке для Windows, macOS и других платформ находится здесь: [gohugo.io/installation/](https://gohugo.io/installation/)
{{% steps %}}

### Step 1

{{< tabs items="Windows(winget),MacOS(brew),Linux(apt)" >}}

  {{< tab >}}Выполнить в powershell
  ```powershell
  winget install Hugo.Hugo.Extended
  ```
  {{< /tab >}}
  {{< tab >}}
  ```sh
  brew install hugo
  ```
  {{< /tab >}}
  {{< tab >}}
  ```sh
  sudo apt install hugo
  ```
  {{< /tab >}}

{{< /tabs >}}

### Step 2

Запустить из директории `/hugo`, редактировать в директории `hugo/content`
```
hugo server --buildDrafts --disableFastRender
```

### Step 3
[http://localhost:1313](http://localhost:1313) - ты на коне 🐎

{{% /steps %}}
