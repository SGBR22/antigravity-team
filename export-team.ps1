# ==============================================================================
# Antigravity Multi-Agent Ecosystem - 1-Click Packager & Exporter
# ==============================================================================
# Этот скрипт собирает плагин, агентов и установщик для товарища в единый ZIP.
# ==============================================================================

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = 'Stop'

Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "  Сборка чистого пакета Antigravity Team для товарища / GitHub    " -ForegroundColor Cyan
Write-Host "=================================================================" -ForegroundColor Cyan

$workspaceDir = $PSScriptRoot
if (-not $workspaceDir) { $workspaceDir = (Get-Location).Path }

# Источник плагина: приоритет локальной папке репозитория, фолбэк на глобальный плагин
$pluginSource = Join-Path $workspaceDir "antigravity-team"
if (-not (Test-Path $pluginSource)) {
    $pluginSource = Join-Path $HOME ".gemini\config\plugins\antigravity-team"
}

$tempBundleDir = Join-Path $env:TEMP "antigravity-team-bundle"
$zipOutputLocal = Join-Path $workspaceDir "antigravity-team-portable.zip"
$zipOutputDesktop = Join-Path ([Environment]::GetFolderPath("Desktop")) "antigravity-team-portable.zip"

Write-Host "`n[1/4] Проверка каталога плагина..." -ForegroundColor Yellow
if (-not (Test-Path $pluginSource)) {
    Write-Host "ОШИБКА: Каталог плагина не найден ни в проекте, ни в системе!" -ForegroundColor Red
    Exit 1
}
Write-Host "Плагин найден: $pluginSource" -ForegroundColor Green

# 2. Подготовка временной папки сборки
Write-Host "`n[2/4] Формирование структуры пакета..." -ForegroundColor Yellow
if (Test-Path $tempBundleDir) {
    Remove-Item -Path $tempBundleDir -Recurse -Force | Out-Null
}
New-Item -ItemType Directory -Force -Path $tempBundleDir | Out-Null

# 2.1 Копируем плагин (агенты, скилы, правила)
$bundlePluginTarget = Join-Path $tempBundleDir "antigravity-team"
Copy-Item -Path $pluginSource -Destination $bundlePluginTarget -Recurse -Force

# 2.2 Копируем скрипт установки для друга
$installerSource = Join-Path $workspaceDir "install-team.ps1"
if (Test-Path $installerSource) {
    Copy-Item -Path $installerSource -Destination $tempBundleDir -Force
}

# 2.3 Создаем краткую текстовую инструкцию в корне архива
$quickNotePath = Join-Path $tempBundleDir "README_INSTALL.txt"

$quickNoteLines = @(
    "=================================================================",
    "  ЧТО ДЕЛАТЬ ПОСЛЕ РАСПАКОВКИ АРХИВА:",
    "=================================================================",
    "1. Нажмите правой кнопкой мыши на файл: install-team.ps1",
    "   и выберите 'Выполнить с помощью PowerShell'.",
    "   (Или запустите в терминале: powershell -ExecutionPolicy Bypass -File .\install-team.ps1)",
    "",
    "2. Скрипт сам скопирует всех 10 агентов и 14 скилов в системную",
    "   папку Antigravity (~/.gemini/config/plugins/antigravity-team)",
    "   и активирует плагин в config.json.",
    "",
    "3. Перезапустите Google Antigravity.",
    "   Все агенты готовы к работе во всех ваших проектах!",
    "",
    "Подробное описание агентов и скилов смотрите в файле:",
    "ANTIGRAVITY_TEAM_SETUP_GUIDE.md"
)
Set-Content -Path $quickNotePath -Value $quickNoteLines -Encoding UTF8

# 2.4 Копируем подробные руководства
foreach ($guideName in @("ANTIGRAVITY_TEAM_SETUP_GUIDE.md", "README.md", "КАК_ПЕРЕДАТЬ_ДРУГУ.md")) {
    $guidePath = Join-Path $workspaceDir $guideName
    if (Test-Path $guidePath) {
        Copy-Item -Path $guidePath -Destination $tempBundleDir -Force
    }
}

# 3. Сжатие в ZIP-архив
Write-Host "`n[3/4] Упаковка в единый ZIP-архив..." -ForegroundColor Yellow
if (Test-Path $zipOutputLocal) {
    Remove-Item -Path $zipOutputLocal -Force
}
Compress-Archive -Path "$tempBundleDir\*" -DestinationPath $zipOutputLocal -Force
Write-Host "Архив успешно создан: $zipOutputLocal" -ForegroundColor Green

# Копируем на Рабочий стол для удобства
try {
    Copy-Item -Path $zipOutputLocal -Destination $zipOutputDesktop -Force
    Write-Host "Архив помещен на ваш Рабочий стол: $zipOutputDesktop" -ForegroundColor Green
} catch {
    Write-Host "Архив доступен в: $zipOutputLocal" -ForegroundColor Yellow
}

# 4. Очистка временной папки
Remove-Item -Path $tempBundleDir -Recurse -Force | Out-Null

Write-Host "`n=================================================================" -ForegroundColor Green
Write-Host "   СБОРКА УСПЕШНО ЗАВЕРШЕНА!                                     " -ForegroundColor Green
Write-Host "=================================================================" -ForegroundColor Green
Write-Host "Архив для отправки другу:"
Write-Host "-> $zipOutputDesktop" -ForegroundColor Cyan
