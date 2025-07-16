@echo off
chcp 65001 >nul
title إنشاء ملف ZIP - متجر Variteks-Algérie

echo.
echo 📦 إنشاء ملف ZIP للنشر...
echo.

REM التحقق من وجود PowerShell
powershell -Command "Get-Command Compress-Archive" >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ PowerShell غير متوفر لإنشاء ZIP
    echo 💡 يمكنك ضغط مجلد netlify-deploy يدوياً
    pause
    exit /b 1
)

REM إنشاء ملف ZIP
echo 🔄 جاري إنشاء ملف ZIP...
powershell -Command "Compress-Archive -Path 'netlify-deploy\*' -DestinationPath 'variteks-algerie-netlify.zip' -Force"

if exist "variteks-algerie-netlify.zip" (
    echo ✅ تم إنشاء ملف ZIP بنجاح!
    echo 📁 اسم الملف: variteks-algerie-netlify.zip
    echo.
    echo 🌐 يمكنك الآن:
    echo   1. رفع هذا الملف على Netlify
    echo   2. أو استخراجه ورفع المحتويات
    echo.
) else (
    echo ❌ فشل في إنشاء ملف ZIP
    echo 💡 استخدم مجلد netlify-deploy مباشرة
)

pause
