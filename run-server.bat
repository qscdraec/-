@echo off
chcp 65001 >nul
title خادم متجر Variteks-Algérie

echo.
echo ========================================
echo    🏪 متجر Variteks-Algérie
echo ========================================
echo.

REM التحقق من وجود Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Python غير مثبت على النظام!
    echo 📥 يرجى تحميل Python من: https://python.org
    pause
    exit /b 1
)

echo 🔄 بدء تشغيل الخادم...
echo.

REM تجربة الخادم الاختباري أولاً
echo 🧪 تشغيل خادم الاختبار...
python test-server.py

REM إذا فشل، جرب خادم Python المدمج
if %errorlevel% neq 0 (
    echo.
    echo ⚠️ فشل خادم الاختبار، جاري تشغيل خادم Python المدمج...
    python -m http.server 8003
)

echo.
echo 🛑 تم إيقاف الخادم
pause
