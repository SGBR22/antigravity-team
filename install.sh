#!/usr/bin/env bash
# ==============================================================================
# Antigravity Multi-Agent Ecosystem - 1-Line Remote Web Installer (Linux / macOS)
# ==============================================================================
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/SGBR22/antigravity-team/main/install.sh | bash
# ==============================================================================
set -euo pipefail

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${CYAN}=================================================================${NC}"
echo -e "${CYAN}  ⚡ Antigravity Multi-Agent Ecosystem - Remote Web Installer    ${NC}"
echo -e "${CYAN}                     Version 2.0.0                               ${NC}"
echo -e "${CYAN}=================================================================${NC}"

REPO_ZIP_URL="https://github.com/SGBR22/antigravity-team/archive/refs/heads/main.zip"
TARGET_PLUGINS_BASE="$HOME/.gemini/config/plugins"
TARGET_PLUGIN_DIR="$TARGET_PLUGINS_BASE/antigravity-team"
ANTIGRAVITY_CONFIG_DIR="$HOME/.gemini/antigravity"
ANTIGRAVITY_CONFIG_FILE="$ANTIGRAVITY_CONFIG_DIR/config.json"

get_python() {
    if command -v python3 >/dev/null 2>&1 && python3 --version >/dev/null 2>&1; then
        echo "python3"
    elif command -v python >/dev/null 2>&1 && python --version >/dev/null 2>&1; then
        echo "python"
    else
        echo ""
    fi
}
PYTHON_BIN="$(get_python)"

TMP_DIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'antigravity-team')
cleanup() {
    rm -rf "$TMP_DIR"
}
trap cleanup EXIT INT TERM

# [1/4] Скачивание архива
echo -e "\n${YELLOW}[1/4] Скачивание последней версии плагина с GitHub...${NC}"
ZIP_PATH="$TMP_DIR/main.zip"
if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$REPO_ZIP_URL" -o "$ZIP_PATH"
elif command -v wget >/dev/null 2>&1; then
    wget -qO "$ZIP_PATH" "$REPO_ZIP_URL"
else
    echo -e "${RED}Ошибка: Для загрузки требуется curl или wget.${NC}" >&2
    exit 1
fi
echo -e "${GREEN}Архив успешно загружен.${NC}"

# [2/4] Распаковка архива
echo -e "\n${YELLOW}[2/4] Распаковка компонентов плагина...${NC}"
EXTRACT_DIR="$TMP_DIR/extract"
mkdir -p "$EXTRACT_DIR"

if command -v unzip >/dev/null 2>&1; then
    unzip -q -o "$ZIP_PATH" -d "$EXTRACT_DIR"
elif [ -n "$PYTHON_BIN" ]; then
    "$PYTHON_BIN" -m zipfile -e "$ZIP_PATH" "$EXTRACT_DIR"
else
    echo -e "${RED}Ошибка: Для распаковки требуется unzip или python3.${NC}" >&2
    exit 1
fi

SOURCE_PLUGIN=""
if [ -d "$EXTRACT_DIR/antigravity-team" ]; then
    SOURCE_PLUGIN="$EXTRACT_DIR/antigravity-team"
else
    FOUND=$(find "$EXTRACT_DIR" -maxdepth 2 -type d -name "antigravity-team" 2>/dev/null | head -n 1)
    if [ -n "$FOUND" ] && [ -d "$FOUND" ]; then
        SOURCE_PLUGIN="$FOUND"
    fi
fi

if [ -z "$SOURCE_PLUGIN" ] || [ ! -d "$SOURCE_PLUGIN" ]; then
    echo -e "${RED}Ошибка: Папка 'antigravity-team' не найдена в загруженном архиве.${NC}" >&2
    exit 1
fi

# [3/4] Установка плагина
echo -e "\n${YELLOW}[3/4] Установка в $TARGET_PLUGIN_DIR...${NC}"
mkdir -p "$TARGET_PLUGINS_BASE"
rm -rf "$TARGET_PLUGIN_DIR"
cp -r "$SOURCE_PLUGIN" "$TARGET_PLUGIN_DIR"
echo -e "${GREEN}Файлы плагина успешно скопированы!${NC}"

# [4/4] Активация в config.json
echo -e "\n${YELLOW}[4/4] Активация плагина в Antigravity config.json...${NC}"
mkdir -p "$ANTIGRAVITY_CONFIG_DIR"

update_config_json() {
    local cfg="$1"
    if [ -n "$PYTHON_BIN" ]; then
        "$PYTHON_BIN" -c "
import json, os, sys
p = sys.argv[1]
data = {}
if os.path.exists(p):
    try:
        with open(p, 'r', encoding='utf-8') as f:
            data = json.load(f)
    except Exception:
        data = {}
if not isinstance(data, dict):
    data = {}
plugins = data.setdefault('plugins', {})
if not isinstance(plugins, dict):
    plugins = data['plugins'] = {}
enabled = plugins.setdefault('enabled', {})
if not isinstance(enabled, dict):
    enabled = plugins['enabled'] = {}
enabled['antigravity-team'] = True
with open(p, 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
    f.write('\n')
" "$cfg"
    elif command -v jq >/dev/null 2>&1; then
        if [ -f "$cfg" ] && [ -s "$cfg" ]; then
            tmp_json=$(mktemp)
            if jq '.plugins.enabled["antigravity-team"] = true' "$cfg" > "$tmp_json" 2>/dev/null; then
                mv "$tmp_json" "$cfg"
            else
                rm -f "$tmp_json"
                echo '{"plugins":{"enabled":{"antigravity-team":true}}}' > "$cfg"
            fi
        else
            echo '{"plugins":{"enabled":{"antigravity-team":true}}}' > "$cfg"
        fi
    else
        # Pure bash fallback
        if [ ! -f "$cfg" ] || [ ! -s "$cfg" ]; then
            cat << 'EOF' > "$cfg"
{
  "plugins": {
    "enabled": {
      "antigravity-team": true
    }
  }
}
EOF
        else
            if ! grep -q '"antigravity-team"' "$cfg"; then
                if grep -q '"enabled"' "$cfg"; then
                    awk '/"enabled"[[:space:]]*:[[:space:]]*\{/ { print; print "      \"antigravity-team\": true,"; next }1' "$cfg" > "${cfg}.tmp" && mv "${cfg}.tmp" "$cfg"
                else
                    cat << 'EOF' > "$cfg"
{
  "plugins": {
    "enabled": {
      "antigravity-team": true
    }
  }
}
EOF
                fi
            fi
        fi
    fi
}

update_config_json "$ANTIGRAVITY_CONFIG_FILE"
echo -e "${GREEN}Плагин 'antigravity-team' успешно активирован в config.json.${NC}"

# Проверка Python и запрос на установку кросс-платформенных зависимостей
echo -e "\n${YELLOW}[+] Проверка окружения Python...${NC}"
if [ -n "$PYTHON_BIN" ]; then
    PY_VER=$("$PYTHON_BIN" --version 2>&1)
    echo -e "${GREEN}Python обнаружен: $PY_VER ($PYTHON_BIN)${NC}"

    IS_INTERACTIVE=false
    TTY_DEV=""
    if [ -t 0 ]; then
        IS_INTERACTIVE=true
    elif [ -r /dev/tty ] && [ -w /dev/tty ]; then
        IS_INTERACTIVE=true
        TTY_DEV="/dev/tty"
    fi

    if [ "$IS_INTERACTIVE" = true ]; then
        echo -e "${CYAN}Установить рекомендуемые кросс-платформенные библиотеки для расчетов и тестов?${NC}"
        echo -e "${CYAN}[pytest, mypy, pydantic, numpy, scipy, sympy, matplotlib, trimesh, pint, uncertainties, MPh]${NC}"
        echo -n "Установить сейчас? [Y/n]: "
        if [ -n "$TTY_DEV" ]; then
            read -r answer < "$TTY_DEV" 2>/dev/null || answer="n"
        else
            read -r answer 2>/dev/null || answer="n"
        fi

        case "$answer" in
            [yY][eE][sS]|[yY]|"")
                echo -e "${YELLOW}Установка библиотек через pip (без pywin32 на Linux/macOS)...${NC}"
                "$PYTHON_BIN" -m pip install --upgrade --user pytest mypy pydantic numpy scipy sympy matplotlib trimesh pint uncertainties MPh 2>/dev/null || \
                "$PYTHON_BIN" -m pip install --upgrade --break-system-packages pytest mypy pydantic numpy scipy sympy matplotlib trimesh pint uncertainties MPh 2>/dev/null || \
                "$PYTHON_BIN" -m pip install --upgrade pytest mypy pydantic numpy scipy sympy matplotlib trimesh pint uncertainties MPh || \
                echo -e "${YELLOW}Предупреждение: не удалось установить pip-пакеты автоматически. Вы можете установить их вручную.${NC}"
                ;;
            *)
                echo -e "Пропуск установки pip-зависимостей."
                ;;
        esac
    else
        echo -e "Неинтерактивный режим: пропуск интерактивного запроса pip."
    fi
else
    echo -e "${YELLOW}Python 3 не найден в PATH. Если потребуются инженерные расчеты (MPh, pint, uncertainties), установите Python 3.10+.${NC}"
fi

echo -e "\n${GREEN}=================================================================${NC}"
echo -e "${GREEN}   ПОЗДРАВЛЯЕМ! Мультиагентная экосистема v2.0.0 установлена!    ${NC}"
echo -e "${GREEN}=================================================================${NC}"
echo -e "${CYAN}Все 10 агентов и 15 скилов активны (Auto-Dispatch).${NC}"
echo -e "${YELLOW}Перезапустите Google Antigravity для применения изменений.${NC}"
