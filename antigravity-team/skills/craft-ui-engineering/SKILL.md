---
name: craft-ui-engineering
description: Modern, non-AI craft frontend engineering and visual styling. Adapts fluidly to project context, domain, and modern web design trends (Linear dev-tools, Swiss editorial, industrial hardware, refined humanist, dynamic product SaaS). Incorporates curated GitHub repositories (cmdk, sonner, vaul, motion-primitives, kokonutui, originui, kibo, cult-ui, magicui) and enforces an ironclad Anti-AI Design Manifesto with zero-lag data contract pipelines.
---

# 🎨 Craft UI Engineering & Non-AI Project Styling

## Overview

This skill establishes the engineering and aesthetic standards for **all visual project styling, frontend design, dashboards, interactive showpieces, and UI components**. 

It eliminates generic "AI slop" (overused purple gradient blobs, fake frosted glass without refraction, floating 3D plastic spheres, hollow bento cards) in favor of **purposeful, context-adaptive, contemporary web design** informed by top-tier open-source design systems and modern frontend craft.

---

## 1. 🌐 Adaptive Contextual Aesthetics (Дизайн под задачу и контекст)

> **КРИТИЧЕСКИЙ ПРИНЦИП:** Не замыкайтесь в одном техническом шаблоне или «стекломорфизме Apple»!
> Стиль обязан **динамически адаптироваться под контекст проекта, аудиторию и запрос пользователя**.

| Архетип стиля | Когда применять | Характерные черты и палитра | Референсы & GitHub |
| :--- | :--- | :--- | :--- |
| **Technical Minimalist (Dev-Tool)** | Терминалы, бенчмарки, утилиты разработчика, CLI, API-дашборды | Обсидиан (`#090a0f`), цинк, 1px specular highlight границы, `tabular-nums`, `⌘K` палитры, сверхбыстрый отклик. | Linear, Raycast, Vercel Geist, `cmdk` |
| **Swiss Modern / Editorial** | Научные статьи, архивы, документация, лонгриды, манифесты | Абсолютный B&W контраст, модульная сетка, шрифт Neue Haas/Geist, 0px скругления, ровно один акцент (Klein Blue / Vermilion / Acid Lime). | `mattlean/eswiss`, Swiss Typography |
| **Industrial / Cyber-Tactile** | Измерительные приборы, физические расчеты, телеметрия, САПР | Матовые корпуса (`#18181b`), CRT-янтарные (`#ffb000`) или фосфорные индикаторы, точечная матрица, 2px жесткие тени 0-blur. | Teenage Engineering, Nothing OS |
| **Refined Humanist / Organic** | Образование, медиа, портфолио, культура, книги | Теплый алебастр (`#fcfbf9`), уголь (`#1f1e1d`), терракота/олива, антиквенные заголовки (Newsreader / Instrument Serif), мягкие тени. | Stripe Press, Kinfolk, ReadCV |
| **Modern Product SaaS / App** | Бизнес-сервисы, продуктовые витрины, пользовательские панели | Свежий светлый/темный цинк, чистые карточки, живые спарклайны, четкая иерархия кнопок, микро-тултипы. | Supabase, Tailwind UI, `originui`, `kibo` |
| **Creative / Portfolio Showcase** | Витрины проектов, промо-страницы, концепты | Асимметричная верстка, крупная экспрессивная типографика, плавный tilt карточек, интерактивные SVG/Canvas. | `magicui`, `aceternity-ui`, `cult-ui` |

---

## 2. 🚫 The Anti-AI Design Manifesto (Манифест против AI-штампов)

### ❌ Что категорически запрещено (AI Slop Hall of Shame):
1. **The Purple Gradient Soup**:
   - `bg-gradient-to-r from-purple-500 via-indigo-500 to-pink-500 blur-3xl` — дешевый признак сгенерированного лендинга.
2. **Пустой псевдо-стекломорфизм**:
   - `backdrop-blur-md bg-white/5 border-white/10` на монотонном черном фоне, где сзади нечего размывать (получается грязный мутный пластик). Размытие имеет смысл *только* при скролле поверх реального контента или подложке с геометрией.
3. **Бессмысленные летающие талисманы & Sparkles**:
   - Пластиковые 3D-роботы, искры `✨` там, где нет генеративных функций, и светящиеся летающие шары.
4. **Полые бенто-сетки (Empty Bento Grids)**:
   - Карточки с бессмысленными 3D-иконками или фальшивыми неработающими переключателями. Каждая ячейка бенто обязана нести **полезную информацию** (дифф кода, спарклайн, телеметрию, интерактивный фильтр).
5. **Замедляющие анимации**:
   - Всплытия по 800ms с задержками, мешающие мгновенному клику. Интерфейс должен ощущаться невесомым и быстрым.
6. **Выцветший серый текст**:
   - `#555` на черном фоне, не проходящий стандарты контрастности WCAG. Текст должен читаться легко.

### ✅ Что обязательно соблюдать (High-Craft Invariants):
1. **Правило 90/10**:
   - 90% интерфейса — выверенные нейтральные тона (обсидиан, цинк, бумажный белый, теплый камень).
   - 10% — точечный функциональный акцент (статус, фокус, ключевое действие).
2. **Субпиксельные границы 1px со Specular Highlight**:
   ```css
   border: 1px solid rgba(255, 255, 255, 0.08);
   box-shadow: inset 0 1px 0 0 rgba(255, 255, 255, 0.06);
   ```
3. **Табличная типографика для чисел**:
   - Любые счетчики, метрики, таймеры, координаты и версии оформляются с `font-variant-numeric: tabular-nums` (в Tailwind: `tabular-nums font-mono`). Это предотвращает дергание верстки при обновлении цифр.
4. **Полноценный Keyboard-First UX**:
   - Четкие состояния `:focus-visible` (ring-offset, ring-2), поддержка `Esc` для закрытия окон и шорткатов командной строки (`⌘K` / `Ctrl+K`).
5. **Точечная локальная обратная связь**:
   - При копировании или действии индикатор меняется прямо на месте клика (галочка вместо иконки копирования, спиннер внутри кнопки), а не выбрасывает тост в противоположный угол экрана.

---

## 3. 📦 Curated GitHub Repositories & Component Architecture

Интегрируйте в свои решения проверенные паттерны из эталонных открытых репозиториев:

### Взаимодействие и управление:
- **[`pacocoursey/cmdk`](https://github.com/pacocoursey/cmdk)** — нестилизованный, доступный командный движок. Идеален для палитр команд и быстрого поиска по проекту.
- **[`emilkowalski/sonner`](https://github.com/emilkowalski/sonner)** — физически корректные, стекуемые уведомления без лагов.
- **[`emilkowalski/vaul`](https://github.com/emilkowalski/vaul)** — нативные свайп-дроверы с физикой пружин.
- **[`ibelick/motion-primitives`](https://github.com/ibelick/motion-primitives)** — микродвижения: morphing dialogs, text shuffles, animated tabs, magnetic buttons.

### Плотные компоненты и блоки данных:
- **[`origin-space/originui`](https://github.com/origin-space/originui)** — прагматичные элементы форм: numeric steppers, badge inputs, тегированные фильтры.
- **[`shadcnblocks/kibo`](https://github.com/shadcnblocks/kibo)** — сложные блоки: фильтр-билдеры, плотные data-таблицы, вложенные деревья файлов.
- **[`kokonut-labs/kokonutui`](https://github.com/kokonut-labs/kokonutui)** & **[`nolly-studio/cult-ui`](https://github.com/nolly-studio/cult-ui)** — тактильные карточки, dock-панели, интерактивные контролы.
- **[`magicuidesign/magicui`](https://github.com/magicuidesign/magicui)** & **[`aceternity/aceternity-ui`](https://github.com/aceternity/aceternity-ui)** — витринные эффекты: retro grids, marquee, tracing beams, spotlights.
- **[`alexpate/awesome-design-systems`](https://github.com/alexpate/awesome-design-systems)** — эталонная база дизайн-систем (Linear, Vercel Geist, GitHub Primer, Shopify Polaris).

---

## 4. 🔄 Data Contract Protocol (`visual-contract.v1.json`)

Для разделения логики бэкенда (`senior-dev`, `science-compute`) и фронтенда (`visual-designer`) используется строгий JSON-контракт:

### Расположение: `artifacts/ui_data.json`

```json
{
  "$schema": "https://antigravity.io/schemas/visual-contract.v1.json",
  "meta": {
    "title": "Система моделирования / Project Name",
    "description": "Краткое назначение интерфейса или отчета",
    "archetype": "technical-minimalist",
    "theme": "dark",
    "updatedAt": "2026-10-24T12:00:00Z"
  },
  "kpis": [
    {
      "id": "kpi_throughput",
      "label": "Пропускная способность",
      "value": "24,500 оп/с",
      "unit": "ops/s",
      "delta": "+18.2%",
      "status": "positive",
      "sparkline": [18, 19, 21, 20, 23, 24.5]
    }
  ],
  "charts": [
    {
      "id": "chart_main",
      "title": "Динамика параметров",
      "type": "area",
      "xAxis": ["00:00", "04:00", "08:00", "12:00", "16:00", "20:00"],
      "series": [
        { "name": "Эксперимент", "data": [12, 18, 15, 28, 24, 30] },
        { "name": "Модель", "data": [11, 17, 16, 26, 25, 29] }
      ]
    }
  ],
  "tables": [
    {
      "id": "results_table",
      "headers": ["Модуль", "Статус", "Время (мс)", "Память"],
      "rows": [
        ["core-engine", "active", "1.2", "45 MB"],
        ["femm-solver", "idle", "14.8", "128 MB"]
      ]
    }
  ],
  "controls": [
    {
      "id": "resolution",
      "label": "Шаг сетки",
      "type": "range",
      "min": 1,
      "max": 100,
      "default": 10
    }
  ]
}
```

### ⚡ Speculative UI Pipelining (Параллельная верстка без задержек):
1. При параллельном старте `visual-designer` **не ждет** появления `artifacts/ui_data.json`.
2. В коде шаблона закладывается fallback:
   ```javascript
   const initialData = window.__INITIAL_DATA__ || {
     meta: { title: "Загрузка проекта...", archetype: "technical-minimalist" },
     kpis: [/* реалистичные мок-значения для немедленной отрисовки верстки */],
     charts: [/* мок-серии */]
   };
   ```
3. При появлении реального `artifacts/ui_data.json` интерфейс мгновенно выполняет рендеринг без повторной верстки.

---

## 5. 🛠️ Рекомендуемый стек реализации

1. **Автономные витрины и артефакты (Zero-Build HTML)**:
   - Современный HTML5 + Tailwind Play CDN + Lucide Icons + Chart.js / Canvas.
   - Чистая модульная структура в одном самодостаточном файле (`.html`), который открывается в любом браузере двойным кликом без `npm install`.
2. **Продуктовые веб-приложения (Node/React/Vite)**:
   - React 19 / Next.js + Tailwind CSS v4 + Radix Primitives + Lucide + Motion.
3. **Архитектурные диаграммы**:
   - Высококонтрастные чистые Mermaid-диаграммы со строгой типизацией узлов.
