---
name: typst-report
description: Author, format, and compile scientific and technical reports in Typst according to GOST 7.32 (using the modern-g7-32 package), CeTZ native vector graphics, or executive technical memos. Use when the user asks for a formatted report, paper, or research deliverable.
---

# Typst Report Generator Skill (ГОСТ 7.32 + CeTZ Vector Graphics)

This skill provides step-by-step procedures, templates, and build commands for generating publication-ready PDF reports with Typst, `@preview/modern-g7-32:0.2.0`, and native vector graphics with `@preview/cetz:0.3.4`.

## 1. Prerequisites Check
Verify Typst is available:
```powershell
typst --version
```

---

## 2. ГОСТ 7.32 Standard Report Template (`modern-g7-32`)

```typst
#import "@preview/modern-g7-32:0.2.0": gost, abstract, appendixes
#import "@preview/cetz:0.3.4"

#show: gost.with(
  ministry: "МИНИСТЕРСТВО НАУКИ И ВЫСШЕГО ОБРАЗОВАНИЯ РОССИЙСКОЙ ФЕДЕРАЦИИ",
  organization: (
    full: "Наименование Университета / Предприятия",
    short: "Организация"
  ),
  about: "О научно-исследовательской работе",
  research: "Расчет изоляции и моделирование высоковольтных вводов",
  subject: "ОТЧЕТ О НАУЧНО-ИССЛЕДОВАТЕЛЬСКОЙ РАБОТЕ",
  manager: (name: "Петров П.П.", position: "Руководитель НИР", title: "д.т.н., проф."),
  city: "Москва",
  year: "2026",
  performers: (
    (name: "Иванов И.И.", position: "Инженер-исследователь", part: "разделы 1-3"),
  )
)

#abstract("высоковольтный ввод", "RIP-изоляция", "электрическое поле", "CeTZ", "ГОСТ 7.32")[
  В отчете представлены расчеты емкостных обкладок высоковольтного ввода 110 кВ, анализ напряженности электрического поля и теплового режима диэлектрика.
]

#outline()

= Введение
Целью настоящей работы является расчет параметров высоковольтной изоляции...

= 1 Аналитический расчет конденсаторного ввода
Радиусы ступеней конденсаторных обкладок определяются из условия постоянства максимальной радиальной напряженности:

$ r_k = r_0 dot exp(k dot frac(ln(r_n / r_0), n)) $ <eq_rk>

Где $r_0$ --- радиус токоведущей трубы, $r_n$ --- внутренний радиус заземленного фланца.

#figure(
  table(
    columns: (auto, auto, auto, auto),
    [№ слоя $k$], [Радиус $r_k$, мм], [Длина $l_k$, мм], [Емкость $C_k$, пФ],
    [1], [27.2], [580], [35.1],
    [2], [29.6], [532], [35.0],
    [3], [32.2], [489], [35.2],
  ),
  caption: [Геометрические и емкостные параметры обкладок],
) <tab_layers>
```

---

## 3. Векторные чертежи и схемы без растровых картинок (`CeTZ`)

CeTZ позволяет рисовать масштабируемые векторные схемы (профиль ввода, распределение потенциала) прямо в коде документа:

```typst
#figure(
  cetz.canvas({
    import cetz.draw: *
    
    // Центральный токоведущий стержень
    rect((-0.5, -4), (0.5, 4), fill: rgb("ffcc80"), stroke: black)
    content((0, 0), [Токоведущая труба], angle: 90deg)
    
    // Изоляционное тело RIP
    rect((-2.0, -2.5), (-0.5, 2.5), fill: rgb("e0e0e0"), stroke: black)
    rect((0.5, -2.5), (2.0, 2.5), fill: rgb("e0e0e0"), stroke: black)
    
    // Заземленный фланец
    rect((-2.8, -0.6), (-2.0, 0.6), fill: rgb("90a4ae"), stroke: black)
    rect((2.0, -0.6), (2.8, 0.6), fill: rgb("90a4ae"), stroke: black)
    content((3.5, 0), [Фланец (Земля)])
    
    // Размеры и выноски
    line((-0.5, 4.3), (0.5, 4.3), mark: (start: ">", end: ">"), stroke: blue)
    content((0, 4.6), [$d_0 = 50$ мм], anchor: "south")
  }),
  caption: [Эскиз расчетной геометрии высоковольтного ввода (векторная графика CeTZ)],
)
```

---

## 4. Сборка документа

Для компиляции в PDF выполните команду:
```powershell
typst compile report.typ
```
Typst мгновенно компилирует файл за 20–50 мс без промежуточных фаз.
