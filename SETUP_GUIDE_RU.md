# ⚡ Руководство по установке и настройке Antigravity Multi-Agent Squad в терминале (v2.7.0)

<div align="center">

**Русская версия** • **[English Guide](SETUP_GUIDE.md)** • **[Главный README](README_RU.md)**

</div>

---

## 🚀 1. Кросс-платформенная установка в терминале

### 🐧 Вариант А: Терминал Linux и macOS (Рекомендуется)

#### Способ 1: Удаленная установка в одну строку (curl / wget)
Выполните в любом терминале (Bash, Zsh):
```bash
curl -fsSL https://raw.githubusercontent.com/SGBR22/antigravity-team/main/install.sh | bash
```
Или через `wget`:
```bash
wget -qO- https://raw.githubusercontent.com/SGBR22/antigravity-team/main/install.sh | bash
```

#### Способ 2: Локальная оффлайн-установка (из Git или ZIP)
```bash
git clone https://github.com/SGBR22/antigravity-team.git
cd antigravity-team
chmod +x install-team.sh
./install-team.sh
```

*Что делает Linux-установщик:*
1. Копирует файлы плагина в каталог `~/.gemini/config/plugins/antigravity-team`.
2. Регистрирует и активирует `"antigravity-team": true` в конфигурационном файле `~/.gemini/antigravity/config.json` (3-уровневый безопасный каскад: Python 3 $\to$ jq $\to$ bash).
3. Проверяет наличие Python 3 и предлагает установить кросс-платформенные зависимости: `pytest`, `mypy`, `pydantic`, `numpy`, `scipy`, `sympy`, `matplotlib`, `trimesh`, `pint`, `uncertainties`, `MPh`.
4. Исключает Windows-специфичные библиотеки (например, `pywin32`).

---

### 🪟 Вариант Б: Windows PowerShell

#### Способ 1: Удаленная установка в одну строку
Откройте PowerShell и выполните:
```powershell
irm https://raw.githubusercontent.com/SGBR22/antigravity-team/main/install.ps1 | iex
```

#### Способ 2: Локальная установка
```powershell
git clone https://github.com/SGBR22/antigravity-team.git
cd antigravity-team
powershell -ExecutionPolicy Bypass -File .\install-team.ps1
```
*(Или дважды кликните по файлу `install.bat`)*

---

## 📦 2. Окружение и инструментарий терминала

### Python 3 и виртуальные окружения (Linux)
Для научных расчетов и запуска TDD-тестов рекомендуется Python 3.10+:
```bash
# Ubuntu / Debian
sudo apt update && sudo apt install -y python3 python3-pip python3-venv git unzip

# Fedora / RHEL
sudo dnf install -y python3 python3-pip git unzip

# Arch Linux
sudo pacman -S python python-pip git unzip
```

Для создания изолированного виртуального окружения:
```bash
python3 -m venv ~/.venv/antigravity
source ~/.venv/antigravity/bin/activate
pip install --upgrade pytest mypy pydantic numpy scipy sympy matplotlib trimesh pint uncertainties MPh
```

### Typst (для генерации отчетов по ГОСТ 7.32)
Субагент `typst-reporter` компилирует публикационные PDF через Typst:
- **Готовый бинарный файл** (самый быстрый способ):
  ```bash
  curl -fsSL https://github.com/typst/typst/releases/latest/download/typst-x86_64-unknown-linux-musl.tar.xz | tar -xJ --strip-components=1 -C /usr/local/bin typst-x86_64-unknown-linux-musl/typst
  ```
- **Через Cargo**:
  ```bash
  cargo install --locked typst-cli
  ```
- **В Arch Linux**:
  ```bash
  sudo pacman -S typst
  ```

---

## 🔍 3. Проверка корректности установки в терминале

После выполнения скрипта установки убедитесь, что плагин зарегистрирован:

### В Linux / macOS:
```bash
# 1. Проверка наличия каталога плагина:
ls -la ~/.gemini/config/plugins/antigravity-team

# 2. Проверка активации в config.json:
grep -A 5 "antigravity-team" ~/.gemini/antigravity/config.json
```
Ожидаемый фрагмент:
```json
"plugins": {
  "enabled": {
    "antigravity-team": true
  }
}
```

### В Windows:
```powershell
Test-Path "$HOME\.gemini\config\plugins\antigravity-team"
Get-Content "$HOME\.gemini\antigravity\config.json"
```

Перезапустите приложение Google Antigravity или терминальную сессию. Все 10 субагентов и 15 скилов сразу готовы к работе.

---

## 🚨 4. Автоматическая диспетчеризация (Auto-Dispatch)

Вам не нужно вручную вызывать нужного агента по точному имени — оркестратор сам определяет домен задачи:

```text
Запрос пользователя
         │
         ▼
[system-architect] ──▶ Проектирует DAG, контракты файлов и критерии DoD
         │
         ▼
[coordinator]      ──▶ Параллельный запуск потоков (Спекулятивный скелет)
         │
         ├──▶ [senior-dev]       (Бэкенд, логика, CLI и TDD)
         ├──▶ [visual-designer]  (Визуальный стиль, SVG, интерфейсы)
         ├──▶ [science-compute]  (COMSOL, FEMM, расчет погрешностей)
         ├──▶ [cad-specialist]   (Blender bpy, 3D-печать)
         ├──▶ [typst-reporter]   (Публикационный PDF по ГОСТ)
         └──▶ [researcher]       (Автономный исследовательский цикл)
         │
         ▼ Zero-Lag Join (Мгновенное сведение)
[code-reviewer]    ──▶ Противнический QA-аудит и верификация DoD
         │
         ▼
Сдача готового результата пользователю
```

---

## 👥 5. Справочник субагентов (10 ролей)

| Субагент | Роль | Основная специализация |
| :--- | :--- | :--- |
| **`coordinator`** | Главный диспетчер | Декомпозиция задач, параллельные потоки, сборка финального результата. |
| **`senior-dev`** | Системный разработчик | Серверная логика, CLI-утилиты, TDD, Clean Code без лишней бюрократии. |
| **`code-reviewer`** | QA-аудитор и контролер плана | Проверка каждого пункта плана, анализ утечек памяти и граничных условий. |
| **`researcher`** | Автономный исследователь | Эмпирический цикл Карпатого: гипотеза $\to$ скрипт-зонд $\to$ факты и метрики. |
| **`system-architect`** | Главный архитектор | Модульная архитектура ECC, файловые контракты и архитектурные решения (ADR). |
| **`science-compute`** | Инженер-расчетчик | Электрофизика, высоковольтные вводы, COMSOL MPh, FEMM, ГОСТ 8.207. |
| **`cad-specialist`** | САПР и 3D-моделирование | Скрипты Blender `bpy`, Компас-3D (pywin32 под Win), проверка для 3D-печати. |
| **`typst-reporter`** | Мастер документации | Генерация отчетов в Typst по ГОСТ 7.32, векторные схемы CeTZ. |
| **`visual-designer`** | Дизайн и UI/UX | Современный веб-дизайн (Craft UI), векторные схемы SVG, инфографика. |
| **`web-surfer`** | Точечный веб-поиск | Быстрый поиск официальных стандартов (ГОСТ, IEC) и документации API. |

---

## 🛠️ 6. Справочник навыков (15 скилов)

1. **`autoresearch`**: Автономный исследовательский цикл (Гипотеза $\to$ Зонд $\to$ Метрики).
2. **`system-architecture`**: Модульная архитектура ECC и документация решений (ADR).
3. **`token-budget-optimizer`**: Активный щит токенов и принцип Карпатого "Think in Code".
4. **`test-driven-development`**: Разработка через тестирование (TDD: Red-Green-Refactor).
5. **`systematic-debugging`**: Научная локализация ошибок с правилом «Стоп на 2».
6. **`code-refactoring-and-architecture`**: Снижение когнитивной сложности и удаление мертвого кода.
7. **`craft-ui-engineering`**: Современный веб-дизайн без AI-шаблонов и пайплайны нулевой задержки.
8. **`git-workflow-and-commits`**: Стандарт Conventional Commits 1.0 и гигиена репозитория.
9. **`hv-bushing-calc`**: Расчет высоковольтных вводов в COMSOL и FEMM.
10. **`metrology-lab-data`**: Обработка лабораторных данных по ГОСТ 8.207 (Стьюдент, МНК).
11. **`uncertainty-and-units`**: Физические размерности (`pint`) и расчет неопределенностей (GUM).
12. **`kompas-3d-automation`**: Автоматизация чертежей Компас-3D через pywin32 API 5/7 (Windows).
13. **`blender-bpy-modeling`**: Процедурное 3D-моделирование через скрипты Blender `bpy`.
14. **`three-d-printing-preflight`**: Проверка 3D-моделей перед печатью (FDM/SLA).
15. **`typst-report`**: Оформление отчетов в Typst с векторной графикой CeTZ.

---

## ❓ 7. Частые вопросы (FAQ)

### Требуются ли права sudo для `install.sh`?
**Нет.** Скрипт устанавливает файлы только в вашу домашнюю папку пользователя (`$HOME/.gemini`). `sudo` может потребоваться только для установки системных пакетов ОС (`apt`, `pacman`).

### Как упаковать плагин в архив на Linux для отправки товарищу?
Выполните `bash export-team.sh`. В текущей папке появится переносимый архив `antigravity-team-portable.zip`.
