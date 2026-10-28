# ==============================================================================
# Antigravity Multi-Agent Ecosystem - 1-Click Installer for Friend
# ==============================================================================
# Этот скрипт автоматически устанавливает команду агентов, скилы и правила в Antigravity.
# Запуск: Нажать правой кнопкой мыши -> "Выполнить с помощью PowerShell"
# Или в терминале: powershell -ExecutionPolicy Bypass -File .\install-team.ps1
# ==============================================================================

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = "Stop"

Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "  Установка Antigravity Multi-Agent Team (v2.9.0)               " -ForegroundColor Cyan
Write-Host "=================================================================" -ForegroundColor Cyan

# 1. Определение путей
$currentDir = $PSScriptRoot
if (-not $currentDir) { $currentDir = (Get-Location).Path }

$sourcePluginDir = Join-Path $currentDir "antigravity-team"
$zipBundle = Join-Path $currentDir "antigravity-team-portable.zip"
$targetPluginsBase = Join-Path $HOME ".gemini\config\plugins"
$targetPluginDir = Join-Path $targetPluginsBase "antigravity-team"
$antigravityConfigDir = Join-Path $HOME ".gemini\antigravity"
$antigravityConfigFile = Join-Path $antigravityConfigDir "config.json"

Write-Host "`n[1/4] Проверка исходных файлов..." -ForegroundColor Yellow

if (-not (Test-Path $sourcePluginDir)) {
    if (Test-Path $zipBundle) {
        Write-Host "Папка 'antigravity-team' не распакована, но найден ZIP-архив. Распаковываем..." -ForegroundColor Yellow
        Expand-Archive -Path $zipBundle -DestinationPath $currentDir -Force
    }
}

if (-not (Test-Path $sourcePluginDir)) {
    Write-Host "ОШИБКА: Папка 'antigravity-team' не найдена рядом со скриптом установки!" -ForegroundColor Red
    Write-Host "Убедитесь, что архив был полностью распакован перед запуском." -ForegroundColor Red
    Write-Host "`nНажмите любую клавишу для выхода..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    Exit 1
}
Write-Host "Исходные файлы найдены: $sourcePluginDir" -ForegroundColor Green

# 2. Копирование глобального плагина
Write-Host "`n[2/4] Копирование плагина в глобальную конфигурацию Antigravity..." -ForegroundColor Yellow
if (-not (Test-Path $targetPluginsBase)) {
    New-Item -ItemType Directory -Force -Path $targetPluginsBase | Out-Null
}
Copy-Item -Path $sourcePluginDir -Destination $targetPluginsBase -Recurse -Force
Write-Host "Плагин успешно скопирован в: $targetPluginDir" -ForegroundColor Green

# 3. Активация плагина в config.json
Write-Host "`n[3/4] Активация плагина в настройках Antigravity (config.json)..." -ForegroundColor Yellow
if (-not (Test-Path $antigravityConfigDir)) {
    New-Item -ItemType Directory -Force -Path $antigravityConfigDir | Out-Null
}

$config = @{}
if (Test-Path $antigravityConfigFile) {
    try {
        $rawJson = Get-Content -Path $antigravityConfigFile -Raw -Encoding UTF8
        if ($rawJson.Trim()) {
            $config = $rawJson | ConvertFrom-Json -AsHashtable
        }
    } catch {
        Write-Host "Предупреждение: Не удалось прочитать старый config.json, создаем свежую структуру." -ForegroundColor DarkYellow
        $config = @{}
    }
}

if (-not $config.ContainsKey("plugins")) {
    $config["plugins"] = @{}
}
if (-not $config["plugins"].ContainsKey("enabled")) {
    $config["plugins"]["enabled"] = @{}
}
$config["plugins"]["enabled"]["antigravity-team"] = $true

$newJson = $config | ConvertTo-Json -Depth 10
Set-Content -Path $antigravityConfigFile -Value $newJson -Encoding UTF8
Write-Host "Плагин 'antigravity-team' активирован в: $antigravityConfigFile" -ForegroundColor Green

# 4. Проверка Python-окружения
Write-Host "`n[4/4] Проверка зависимостей Python..." -ForegroundColor Yellow
$pythonInstalled = $false
try {
    $pyVer = python --version 2>&1
    if ($LASTEXITCODE -eq 0 -or $pyVer -like "*Python*") {
        $pythonInstalled = $true
        Write-Host "Python обнаружен: $pyVer" -ForegroundColor Green
    }
} catch {
    $pythonInstalled = $false
}

if ($pythonInstalled) {
    if ([Environment]::UserInteractive -and -not [Console]::IsOutputRedirected) {
        Write-Host "Установить рекомендуемые библиотеки [MPh, pytest, pint, uncertainties, numpy, scipy] сейчас? [Y/N]" -ForegroundColor Cyan
        $answer = Read-Host
        if ($answer -eq 'Y' -or $answer -eq 'y' -or $answer -eq 'д' -or $answer -eq 'Д' -or $answer -eq '') {
            Write-Host "Установка библиотек через pip..." -ForegroundColor Yellow
            pip install --upgrade MPh pytest mypy pydantic numpy scipy sympy matplotlib pywin32 trimesh pint uncertainties
        }
    } else {
        Write-Host "Неинтерактивный режим: пропуск интерактивного запроса pip." -ForegroundColor Gray
    }
} else {
    Write-Host "Python не найден в PATH. Если потребуются инженерные расчеты (COMSOL, pint), установите Python 3.10+." -ForegroundColor DarkYellow
}

Write-Host "`n=================================================================" -ForegroundColor Green
Write-Host "   ПОЗДРАВЛЯЕМ! Мультиагентная команда успешно установлена!      " -ForegroundColor Green
Write-Host "=================================================================" -ForegroundColor Green
Write-Host "Все 15 агентов и 16 скилов (Auto-Dispatch, OpenSpec SDD) готовы к работе во всех проектах." -ForegroundColor Cyan
Write-Host "Перезапустите Google Antigravity для применения изменений." -ForegroundColor Yellow
