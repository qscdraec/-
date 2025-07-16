@echo off
chcp 65001 >nul
title خادم متجر Variteks-Algérie

echo.
echo ========================================
echo    🏪 متجر Variteks-Algérie
echo ========================================
echo.
echo 🔄 بدء تشغيل الخادم...
echo.

REM التحقق من وجود Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Python غير مثبت على النظام!
    echo 📥 يرجى تحميل Python من: https://python.org
    pause
    exit /b 1
)

REM تشغيل الخادم البسيط
python simple-server.py

REM في حالة فشل الخادم البسيط، جرب الخادم المتقدم
if %errorlevel% neq 0 (
    echo.
    echo ⚠️ فشل الخادم البسيط، جاري المحاولة مع الخادم المتقدم...
    python server.py
)

REM في حالة فشل كلا الخادمين، استخدم خادم Python المدمج
if %errorlevel% neq 0 (
    echo.
    echo ⚠️ فشل الخادم المتقدم، جاري المحاولة مع خادم Python المدمج...
    python -m http.server 8000
)

REM في حالة إغلاق الخادم
echo.
echo 🛑 تم إيقاف الخادم
pause
