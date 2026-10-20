# ⚡ Полное руководство по настройке и использованию Antigravity Multi-Agent Ecosystem (v2.5)

<div align="center">

**[English Guide](SETUP_GUIDE.md)** • **Русская версия**

</div>

---

## 🚀 Установка и активация за 3 шага

### Шаг 1. Клонирование репозитория
Откройте PowerShell и выполните:
```bash
git clone https://github.com/SGBR22/antigravity-team.git
cd antigravity-team
```

### Шаг 2. Запуск автоматического инсталлятора
```powershell
powershell -ExecutionPolicy Bypass -File .\install-team.ps1
```
*Скрипт выполнит:*
1. Копирование файлов плагина в глобальную директорию `~/.gemini/config/plugins/antigravity-team`.
2. Регистрацию плагина в `~/.gemini/antigravity/config.json`.
3. Проверку и предложение установить Python-пакеты: `MPh`, `pytest`, `pint`, `uncertainties`, `pywin32`, `numpy`, `scipy`.

### Шаг 3. Перезапуск Google Antigravity
Перезапустите приложение Google Antigravity. Все 10 субагентов и 14 навыков будут доступны глобально во всех ваших проектах.

---

## 🚨 Протокол автоматического выбора (Auto-Dispatch)

Система больше не требует явного ручного обращения по имени субагента:
- При написании кода или фиксе багов управление передается `senior-dev`.
- Для ревью и поиска логических дыр запускается `code-reviewer`.
- Для исследования библиотек и бенчмарков вызывается `researcher`.
- Для проектирования модулей и архитектуры подключается `system-architect`.
- При расчетах физики, COMSOL и погрешностей задействуется `science-compute`.
- Для САПР (КОМПАС-3D, Blender) и 3D-печати запускается `cad-specialist`.
- При верстке отчетов по ГОСТ подключается `typst-reporter`.

---

## 👥 Справочник субагентов (10 ролей)

| Субагент | Назначение |
| :--- | :--- |
| **`coordinator`** | Декомпозиция задач, сетевые графики, распределение нагрузки. |
| **`senior-dev`** | Чистый код, TDD, скрипты, систематическая отладка. |
| **`code-reviewer`** | Противнический 6-точечный QA аудит (логика, безопасность, утечки). |
| **`researcher`** | Автоисследования в стиле Karpathy и Hermes через headless-скрипты. |
| **`system-architect`** | Системный архитектор в стиле ECC, интерфейсные контракты, ADR. |
| **`science-compute`** | COMSOL Multiphysics через MPh, FEMM, расчет вводов, ГОСТ 8.207. |
| **`cad-specialist`** | КОМПАС-3D API 5/7, штамп ГОСТ 2.104, Blender bpy, 3D-печать. |
| **`typst-reporter`** | Верстка публикационных отчетов в Typst по ГОСТ 7.32, CeTZ. |
| **`visual-designer`** | Диаграммы Mermaid, интерфейсы Generative UI, дашборды. |
| **`web-surfer`** | Точечный поиск актуальной документации и стандартов ГОСТ/IEC. |

---

## 🛠️ Справочник 14 навыков (Skills)

1. **`autoresearch`**: Автономная петля исследования Karpathy.
2. **`system-architecture`**: Модульная архитектура и ADR по стандарту ECC.
3. **`token-budget-optimizer`**: Контроль расхода токенов по парадигме "Think in Code".
4. **`test-driven-development`**: Разработка через тестирование (Red-Green-Refactor).
5. **`systematic-debugging`**: Научная локализация ошибок с правилом Halt-at-2.
6. **`code-refactoring-and-architecture`**: Рефакторинг, Clean Code.
7. **`git-workflow-and-commits`**: Стандарты Conventional Commits 1.0.
8. **`hv-bushing-calc`**: Моделирование высоковольтных вводов в COMSOL и FEMM.
9. **`metrology-lab-data`**: Метрологическая обработка измерений по ГОСТ 8.207.
10. **`uncertainty-and-units`**: Расчет неопределенностей по стандарту GUM.
11. **`kompas-3d-automation`**: Автоматизация КОМПАС-3D через pywin32 API 5/7.
12. **`blender-bpy-modeling`**: Процедурное моделирование в Blender (`bpy`).
13. **`three-d-printing-preflight`**: Инженерный контроль 3D-печати.
14. **`typst-report`**: Компиляция отчетов по ГОСТ 7.32 с CeTZ графикой.
