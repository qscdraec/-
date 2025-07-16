@echo off
chcp 65001 >nul
title تشغيل سريع - متجر Variteks-Algérie

:menu
cls
echo.
echo ========================================
echo    🏪 متجر Variteks-Algérie
echo    تشغيل سريع
echo ========================================
echo.
echo اختر طريقة التشغيل:
echo.
echo 1. 🌐 تشغيل عبر الشبكة (موصى به)
echo 2. 💻 تشغيل محلي فقط
echo 3. 🧪 اختبار المزامنة
echo 4. 🔥 إعداد جدار الحماية
echo 5. 📖 عرض الأدلة
echo 6. ❌ خروج
echo.
set /p choice="اختر رقم (1-6): "

if "%choice%"=="1" goto network
if "%choice%"=="2" goto local
if "%choice%"=="3" goto test
if "%choice%"=="4" goto firewall
if "%choice%"=="5" goto guides
if "%choice%"=="6" goto exit
goto menu

:network
cls
echo.
echo 🌐 تشغيل الخادم عبر الشبكة...
echo.
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Python غير مثبت!
    echo 📥 يرجى تحميل Python من: https://python.org
    pause
    goto menu
)

echo 🚀 بدء تشغيل الخادم...
python server.py
pause
goto menu

:local
cls
echo.
echo 💻 تشغيل محلي...
echo.
echo سيتم فتح الملفات في المتصفح الافتراضي
echo.
start advanced-admin.html
timeout /t 2 >nul
start store.html
timeout /t 2 >nul
start test-sync.html
echo.
echo ✅ تم فتح جميع الصفحات!
pause
goto menu

:test
cls
echo.
echo 🧪 اختبار المزامنة...
echo.
start test-sync.html
echo.
echo ✅ تم فتح صفحة الاختبار!
pause
goto menu

:firewall
cls
echo.
echo 🔥 إعداد جدار الحماية...
echo.
echo ⚠️  يتطلب صلاحيات المدير
echo.
setup-firewall.bat
pause
goto menu

:guides
cls
echo.
echo 📖 الأدلة المتاحة:
echo.
echo 1. VARITEKS_README.md - دليل شامل
echo 2. SYNC_GUIDE.md - دليل المزامنة
echo 3. NETWORK_GUIDE.md - دليل الشبكة
echo.
echo سيتم فتح الأدلة في المفكرة...
echo.
start notepad VARITEKS_README.md
timeout /t 1 >nul
start notepad SYNC_GUIDE.md
timeout /t 1 >nul
start notepad NETWORK_GUIDE.md
echo.
echo ✅ تم فتح جميع الأدلة!
pause
goto menu

:exit
cls
echo.
echo 👋 شكراً لاستخدام متجر Variteks-Algérie!
echo.
timeout /t 2 >nul
exit
