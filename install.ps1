# ==============================================================================
# Antigravity Multi-Agent Ecosystem - 1-Line Remote Web Installer
# ==============================================================================
# Usage:
#   irm https://raw.githubusercontent.com/SGBR22/antigravity-team/main/install.ps1 | iex
# ==============================================================================

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = "Stop"

Write-Host "=================================================================" -ForegroundColor Cyan
Write-Host "  ⚡ Antigravity Multi-Agent Ecosystem - Remote Web Installer   " -ForegroundColor Cyan
Write-Host "=================================================================" -ForegroundColor Cyan

$repoZipUrl = "https://github.com/SGBR22/antigravity-team/archive/refs/heads/main.zip"
$tempZip = Join-Path $env:TEMP "antigravity-team-install.zip"
$tempExtract = Join-Path $env:TEMP "antigravity-team-temp-$(Get-Random)"
$targetPluginsBase = Join-Path $HOME ".gemini\config\plugins"
$targetPluginDir = Join-Path $targetPluginsBase "antigravity-team"
$antigravityConfigDir = Join-Path $HOME ".gemini\antigravity"
$antigravityConfigFile = Join-Path $antigravityConfigDir "config.json"

try {
    Write-Host "`n[1/4] Скачивание последней версии плагина с GitHub..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri $repoZipUrl -OutFile $tempZip -UseBasicParsing
    Write-Host "Архив успешно загружен." -ForegroundColor Green

    Write-Host "`n[2/4] Распаковка компонентов плагина..." -ForegroundColor Yellow
    Expand-Archive -Path $tempZip -DestinationPath $tempExtract -Force
    
    $extractedRoot = Get-ChildItem -Path $tempExtract -Directory | Select-Object -First 1
    $extractedPlugin = Join-Path $extractedRoot.FullName "antigravity-team"
    
    if (-not (Test-Path $extractedPlugin)) {
        throw "Не найдена папка antigravity-team в загруженном архиве."
    }

    if (-not (Test-Path $targetPluginsBase)) {
        New-Item -ItemType Directory -Force -Path $targetPluginsBase | Out-Null
    }

    Write-Host "`n[3/4] Установка в $targetPluginDir..." -ForegroundColor Yellow
    Copy-Item -Path $extractedPlugin -Destination $targetPluginsBase -Recurse -Force
    Write-Host "Файлы плагина успешно скопированы!" -ForegroundColor Green

    Write-Host "`n[4/4] Активация плагина в Antigravity config.json..." -ForegroundColor Yellow
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
    Write-Host "Плагин 'antigravity-team' успешно активирован." -ForegroundColor Green

    Write-Host "`n=================================================================" -ForegroundColor Green
    Write-Host "   ПОЗДРАВЛЯЕМ! Мультиагентная экосистема успешно установлена!  " -ForegroundColor Green
    Write-Host "=================================================================" -ForegroundColor Green
    Write-Host "Все 10 агентов и 14 навыков активированы (Auto-Dispatch)." -ForegroundColor Cyan
    Write-Host "Перезапустите Google Antigravity для применения изменений." -ForegroundColor Yellow
}
finally {
    # Очистка временных файлов
    if (Test-Path $tempZip) { Remove-Item -Path $tempZip -Force -ErrorAction SilentlyContinue }
    if (Test-Path $tempExtract) { Remove-Item -Path $tempExtract -Recurse -Force -ErrorAction SilentlyContinue }
}
