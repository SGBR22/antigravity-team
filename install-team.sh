#!/usr/bin/env bash
# ==============================================================================
# Antigravity Multi-Agent Ecosystem - Local Installer (Linux / macOS)
# ==============================================================================
# Usage:
#   bash install-team.sh
#   or: chmod +x install-team.sh && ./install-team.sh
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
echo -e "${CYAN}  ⚡ Установка Antigravity Multi-Agent Team (v2.7.0)            ${NC}"
echo -e "${CYAN}=================================================================${NC}"

# Определение рабочей директории
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_PLUGIN_DIR="$SCRIPT_DIR/antigravity-team"
ZIP_BUNDLE="$SCRIPT_DIR/antigravity-team-portable.zip"
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

# [1/4] Проверка исходных файлов
echo -e "\n${YELLOW}[1/4] Проверка исходных файлов...${NC}"
if [ ! -d "$SOURCE_PLUGIN_DIR" ]; then
    if [ -f "$ZIP_BUNDLE" ]; then
        echo -e "${YELLOW}Папка 'antigravity-team' не найдена, распаковываем из portable-архива...${NC}"
        if command -v unzip >/dev/null 2>&1; then
            unzip -q -o "$ZIP_BUNDLE" -d "$SCRIPT_DIR"
        elif [ -n "$PYTHON_BIN" ]; then
            "$PYTHON_BIN" -m zipfile -e "$ZIP_BUNDLE" "$SCRIPT_DIR"
        fi
    fi
fi

if [ ! -d "$SOURCE_PLUGIN_DIR" ]; then
    echo -e "${RED}ОШИБКА: Папка 'antigravity-team' не найдена рядом со скриптом установки!${NC}" >&2
    echo -e "${RED}Убедитесь, что архив был полностью распакован перед запуском.${NC}" >&2
    exit 1
fi
echo -e "${GREEN}Исходные файлы найдены: $SOURCE_PLUGIN_DIR${NC}"

# [2/4] Копирование плагина
echo -e "\n${YELLOW}[2/4] Копирование плагина в глобальную конфигурацию Antigravity...${NC}"
mkdir -p "$TARGET_PLUGINS_BASE"
rm -rf "$TARGET_PLUGIN_DIR"
cp -r "$SOURCE_PLUGIN_DIR" "$TARGET_PLUGIN_DIR"
echo -e "${GREEN}Плагин успешно скопирован в: $TARGET_PLUGIN_DIR${NC}"

# [3/4] Активация плагина в config.json
echo -e "\n${YELLOW}[3/4] Активация плагина в настройках Antigravity (config.json)...${NC}"
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
echo -e "${GREEN}Плагин 'antigravity-team' активирован в: $ANTIGRAVITY_CONFIG_FILE${NC}"

# [4/4] Проверка Python и запрос на установку кросс-платформенных зависимостей
echo -e "\n${YELLOW}[4/4] Проверка зависимостей Python...${NC}"
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
        echo -e "${CYAN}Установить рекомендуемые кросс-платформенные библиотеки [pytest, mypy, pydantic, numpy, scipy, sympy, matplotlib, trimesh, pint, uncertainties, MPh]? [Y/n]${NC}"
        echo -n "Ваш выбор: "
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
echo -e "${GREEN}   ПОЗДРАВЛЯЕМ! Мультиагентная команда успешно установлена!      ${NC}"
echo -e "${GREEN}=================================================================${NC}"
echo -e "${CYAN}Все 10 агентов и 15 скилов (Auto-Dispatch) готовы к работе во всех проектах.${NC}"
echo -e "${YELLOW}Перезапустите Google Antigravity для применения изменений.${NC}"
