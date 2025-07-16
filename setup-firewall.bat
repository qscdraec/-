@echo off
chcp 65001 >nul
title إعداد جدار الحماية - متجر Variteks-Algérie

echo.
echo ========================================
echo    🔥 إعداد جدار الحماية
echo ========================================
echo.
echo هذا الملف سيقوم بإعداد جدار الحماية للسماح
echo بالوصول لمتجر Variteks-Algérie من الشبكة المحلية
echo.

REM التحقق من صلاحيات المدير
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ يجب تشغيل هذا الملف كمدير!
    echo 👆 انقر بالزر الأيمن واختر "تشغيل كمدير"
    pause
    exit /b 1
)

echo 🔧 إعداد قواعد جدار الحماية...
echo.

REM إضافة قاعدة للمنفذ 8000
netsh advfirewall firewall add rule name="Variteks Store - Port 8000" dir=in action=allow protocol=TCP localport=8000
if %errorlevel% equ 0 (
    echo ✅ تم إضافة قاعدة للمنفذ 8000
) else (
    echo ❌ فشل في إضافة قاعدة للمنفذ 8000
)

REM إضافة قاعدة للمنفذ 8001-8010 (احتياطي)
netsh advfirewall firewall add rule name="Variteks Store - Ports 8001-8010" dir=in action=allow protocol=TCP localport=8001-8010
if %errorlevel% equ 0 (
    echo ✅ تم إضافة قواعد للمنافذ 8001-8010
) else (
    echo ❌ فشل في إضافة قواعد للمنافذ الاحتياطية
)

REM إضافة قاعدة لـ Python
netsh advfirewall firewall add rule name="Variteks Store - Python Server" dir=in action=allow program="%SystemRoot%\System32\python.exe"
netsh advfirewall firewall add rule name="Variteks Store - Python3" dir=in action=allow program="%LocalAppData%\Programs\Python\Python*\python.exe"

echo.
echo ========================================
echo    ✅ تم إعداد جدار الحماية بنجاح!
echo ========================================
echo.
echo الآن يمكن للأجهزة الأخرى في الشبكة المحلية
echo الوصول إلى متجر Variteks-Algérie
echo.
echo 🚀 يمكنك الآن تشغيل الخادم باستخدام:
echo    start-server.bat
echo.

pause
