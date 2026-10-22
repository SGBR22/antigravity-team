@echo off
chcp 65001 >nul
title Установка Antigravity Multi-Agent Squad

echo ========================================================
echo   ⚡ Antigravity Multi-Agent Ecosystem - Installer
echo ========================================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install-team.ps1"

echo.
pause
