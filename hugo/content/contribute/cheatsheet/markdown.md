---
title: "Разметка"
weight: 1
---

Hugo поддерживает синтаксис Markdown для форматирования текста, создания списков и не только. Эта страница покажет вам некоторые из самых распространённых примеров синтаксиса Markdown.

<!--more-->

## Примеры Markdown

### Стилизация текста

| Style   | Syntax     | Example   | Output   |
| --------  | -------- | ------ | ------ |
| Жирный | `**bold text**` | `**bold text**` | **bold text** |
| Курсив | `*italicized text*` | `*italicized text*` | *italicized text* |
| Зачёркнутый | `~~strikethrough text~~` | `~~strikethrough text~~` | ~~strikethrough text~~ |
| Нижний индекс	 | `<sub></sub>` | `This is a <sub>subscript</sub> text` | This is a <sub>subscript</sub> text |
| Верхний индекс	 | `<sup></sup>` | `This is a <sup>superscript</sup> text` | This is a <sup>superscript</sup> text |

### Оповещения

{{< new-feature version="v0.9.0" >}}

Оповещения — это расширение Markdown, основанное на синтаксисе блоковой цитаты, которое можно использовать для выделения важной информации. Поддерживаются
[оповещения в стиле GitHub](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#alerts).

> [!NOTE]
> Useful information that users should know, even when skimming content.

> [!TIP]
> Helpful advice for doing things better or more easily.

> [!IMPORTANT]
> Key information users need to know to achieve their goal.

> [!WARNING]
> Urgent info that needs immediate user attention to avoid problems.

> [!CAUTION]
> Advises about risks or negative outcomes of certain actions.

```markdown {filename=Markdown}
> [!NOTE]
> Useful information that users should know, even when skimming content.

> [!TIP]
> Helpful advice for doing things better or more easily.

> [!IMPORTANT]
> Key information users need to know to achieve their goal.

> [!WARNING]
> Urgent info that needs immediate user attention to avoid problems.

> [!CAUTION]
> Advises about risks or negative outcomes of certain actions.
```

### Таблицы

|   Name | Age  |
|--------|------|
|    Bob | 27   |
|  Alice | 23   |

```markdown {filename=Markdown}
|   Name | Age  |
|--------|------|
|    Bob | 27   |
|  Alice | 23   |
```

#### Встраиваемый Markdown в таблицах

| Italics   | Bold     | Code   |
| --------  | -------- | ------ |
| *italics* | **bold** | `code` |

```markdown {filename=Markdown}
| Italics   | Bold     | Code   |
| --------  | -------- | ------ |
| *italics* | **bold** | `code` |
```

### Блоки кода

{{< cards >}}
  {{< card link="../syntax-highlighting" title="Подсветка кода" icon="sparkles" >}}
{{< /cards >}}

### Lists

#### Нумерованный список

1. First item
2. Second item
3. Third item

```markdown {filename=Markdown}
1. First item
2. Second item
3. Third item
```

#### Маркированный список

* List item
* Another item
* And another item

```markdown {filename=Markdown}
* List item
* Another item
* And another item
```

#### Вложенный список

* Fruit
  * Apple
  * Orange
  * Banana
* Dairy
  * Milk
  * Cheese

```markdown {filename=Markdown}
* Fruit
  * Apple
  * Orange
  * Banana
* Dairy
  * Milk
  * Cheese
```

### Изображения

![landscape](https://picsum.photos/800/600)

```markdown {filename=Markdown}
![landscape](https://picsum.photos/800/600)
```

С описанием:

![landscape](./sadovnik.jpg "Садовник")

```markdown {filename=Markdown}
![landscape](./sadovnik.jpg "Садовник")
```