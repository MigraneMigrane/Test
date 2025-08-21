---
title: "Подсветка кода"
weight: 2
---

Hugo использует [Chroma](https://github.com/alecthomas/chroma) — универсальную библиотеку для подсветки синтаксиса, написанную на Go.
Рекомендуется использовать обратные кавычки (backticks) для оформления блоков кода в Markdown. Например:

<!--more-->

````markdown {filename="Markdown"}
```csharp
using System;

class Program
{
    static void Main()
    {
        Console.WriteLine("Hello, world!");
    }
}
```
````

станет:

```csharp
using System;

class Program
{
    static void Main()
    {
        Console.WriteLine("Hello, world!");
    }
}
```

## Возможности

### Имя файла

Чтобы добавить имя файла или заголовок к блоку кода, укажите атрибут `filename`:



````markdown {filename="Markdown"}
```proto {filename="hello.proto"}
syntax = "proto3";

package example;

// Описание сообщения User
message User {
  int32 id = 1;
  string name = 2;
  string email = 3;
}

// Описание сервиса UserService
service UserService {
  // Получение пользователя по id
  rpc GetUser (GetUserRequest) returns (User);
}

// Запрос для получения пользователя
message GetUserRequest {
  int32 id = 1;
}
```
````

```proto {filename="hello.proto"}
syntax = "proto3";

package example;

// Описание сообщения User
message User {
  int32 id = 1;
  string name = 2;
  string email = 3;
}

// Описание сервиса UserService
service UserService {
  // Получение пользователя по id
  rpc GetUser (GetUserRequest) returns (User);
}

// Запрос для получения пользователя
message GetUserRequest {
  int32 id = 1;
}
```

### Ссылка на файл

{{< new-feature version="v0.9.2" >}}

Вы можете использовать атрибут `base_url`, чтобы указать базовый URL, который будет объединён с именем файла для создания ссылки.

Имя файла может содержать относительный путь, если нужно указать расположение файла относительно базового пути.

````markdown {filename="Markdown"}
```go {base_url="https://github.com/imfing/hextra/blob/main/",filename="exampleSite/hugo.work"}
go 1.20
```
````

```go {base_url="https://github.com/imfing/hextra/blob/main/",filename="exampleSite/hugo.work"}
go 1.20
```

### Нумерация строк

Чтобы добавить номера строк, задайте атрибут `linenos` как `table`, а также при необходимости укажите с какого номера начинать с помощью `linenostart`:

````markdown {filename="Markdown"}
```python {linenos=table,linenostart=42}
def say_hello():
    print("Hello!")
```
````

```python {linenos=table,linenostart=42}
def say_hello():
    print("Hello!")
```

### Подсветка строк

Чтобы выделить определённые строки, укажите атрибут `hl_lines` со списком номеров строк:


````markdown {filename="Markdown"}
```python {linenos=table,hl_lines=[2,4],linenostart=1,filename="hello.py"}
def say_hello():
    print("Hello!")

def main():
    say_hello()
```
````

```python {linenos=table,hl_lines=[2,4],linenostart=1,filename="hello.py"}
def say_hello():
    print("Hello!")

def main():
    say_hello()
```

### Кнопка копирования

По умолчанию кнопка для копирования кода включена для блоков кода. Её поведение можно изменить через конфигурационный файл сайта:

```yaml {linenos=table,linenostart=42,filename="hugo.yaml"}
params:
  highlight:
    copy:
      enable: true
      # hover | always
      display: hover
```

## Поддерживаемые языки

Список поддерживаемых языков смотрите в [документации Chroma](https://github.com/alecthomas/chroma#supported-languages).