@echo off
chcp 65001 >nul
title 🏪 متجر Variteks-Algérie - تشغيل سريع

:menu
cls
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    🏪 متجر Variteks-Algérie                    ║
echo ║                      تشغيل سريع ومحسن                        ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo 🚀 اختر طريقة التشغيل:
echo.
echo   1. 🌐 خادم شبكة (للوصول من أجهزة أخرى)
echo   2. 💻 فتح محلي (أسرع وأبسط)
echo   3. 🧪 اختبار الاتصال
echo   4. 📖 دليل حل المشاكل
echo   5. ❌ خروج
echo.
set /p choice="👆 اختر رقم (1-5): "

if "%choice%"=="1" goto server
if "%choice%"=="2" goto local
if "%choice%"=="3" goto test
if "%choice%"=="4" goto help
if "%choice%"=="5" goto exit
echo ❌ اختيار غير صحيح!
timeout /t 2 >nul
goto menu

:server
cls
echo.
echo 🌐 تشغيل خادم الشبكة...
echo.

REM التحقق من Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Python غير مثبت!
    echo 📥 يرجى تحميل Python من: https://python.org
    echo.
    pause
    goto menu
)

echo ✅ Python متوفر
echo 🔄 بدء تشغيل الخادم...
echo.

REM تشغيل خادم الاختبار
python test-server.py

REM إذا فشل، جرب البديل
if %errorlevel% neq 0 (
    echo.
    echo ⚠️ جاري تجربة خادم بديل...
    python -m http.server 8003
)

pause
goto menu

:local
cls
echo.
echo 💻 فتح محلي...
echo.
echo 🔄 جاري فتح الملفات في المتصفح...
echo.

start advanced-admin.html
timeout /t 1 >nul
start store.html
timeout /t 1 >nul
start test-sync.html

echo ✅ تم فتح جميع الصفحات!
echo.
echo 📊 لوحة التحكم: advanced-admin.html
echo 🏪 المتجر: store.html  
echo 🧪 اختبار المزامنة: test-sync.html
echo.
pause
goto menu

:test
cls
echo.
echo 🧪 اختبار الاتصال...
echo.

REM فحص Python
python --version
if %errorlevel% neq 0 (
    echo ❌ Python غير متوفر
) else (
    echo ✅ Python متوفر
)

echo.
REM فحص المنافذ
echo 🔍 فحص المنافذ المستخدمة:
netstat -an | findstr :800
echo.

REM فتح صفحة الاختبار
echo 🧪 فتح صفحة اختبار المزامنة...
start test-sync.html

pause
goto menu

:help
cls
echo.
echo 📖 دليل حل المشاكل
echo.
echo سيتم فتح دليل حل المشاكل...
start notepad TROUBLESHOOTING.md
echo.
echo 📚 الأدلة المتاحة:
echo   • TROUBLESHOOTING.md - حل المشاكل
echo   • VARITEKS_README.md - دليل شامل
echo   • SYNC_GUIDE.md - دليل المزامنة
echo   • NETWORK_GUIDE.md - دليل الشبكة
echo.
pause
goto menu

:exit
cls
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                 👋 شكراً لاستخدام                           ║
echo ║                متجر Variteks-Algérie                        ║
echo ║                                                              ║
echo ║            🚀 استمتع بتجربة تجارة إلكترونية متميزة!          ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
timeout /t 3 >nul
exit
