@echo off
chcp 65001 >nul
title 🌐 نشر متجر Variteks-Algérie على الإنترنت

:menu
cls
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                🌐 نشر متجر Variteks-Algérie                  ║
echo ║                    على الإنترنت                            ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo 🚀 اختر طريقة النشر:
echo.
echo   1. 📖 دليل النشر الشامل
echo   2. 🌐 فتح Netlify (الأسهل)
echo   3. 🐙 فتح GitHub Pages
echo   4. ⚡ فتح Vercel
echo   5. 📁 تحضير ملفات النشر
echo   6. 🧪 اختبار المتجر محلياً
echo   7. ❌ خروج
echo.
set /p choice="👆 اختر رقم (1-7): "

if "%choice%"=="1" goto guide
if "%choice%"=="2" goto netlify
if "%choice%"=="3" goto github
if "%choice%"=="4" goto vercel
if "%choice%"=="5" goto prepare
if "%choice%"=="6" goto test
if "%choice%"=="7" goto exit
echo ❌ اختيار غير صحيح!
timeout /t 2 >nul
goto menu

:guide
cls
echo.
echo 📖 فتح دليل النشر الشامل...
echo.
start notepad DEPLOYMENT_GUIDE.md
echo ✅ تم فتح الدليل!
echo.
echo 📚 أدلة أخرى مفيدة:
echo   • deploy-netlify.md - دليل Netlify
echo   • deploy-github.md - دليل GitHub
echo.
pause
goto menu

:netlify
cls
echo.
echo 🌐 فتح موقع Netlify...
echo.
echo 📋 الخطوات:
echo   1. أنشئ حساب مجاني
echo   2. انقر "Add new site"
echo   3. اختر "Deploy manually"
echo   4. اسحب مجلد المشروع كاملاً
echo   5. انتظر 1-2 دقيقة
echo   6. احصل على الرابط!
echo.
start https://netlify.com
echo ✅ تم فتح Netlify في المتصفح!
pause
goto menu

:github
cls
echo.
echo 🐙 فتح موقع GitHub...
echo.
echo 📋 الخطوات:
echo   1. أنشئ حساب GitHub
echo   2. أنشئ مستودع جديد
echo   3. ارفع الملفات
echo   4. فعل GitHub Pages
echo   5. احصل على الرابط!
echo.
start https://github.com
echo ✅ تم فتح GitHub في المتصفح!
pause
goto menu

:vercel
cls
echo.
echo ⚡ فتح موقع Vercel...
echo.
echo 📋 الخطوات:
echo   1. أنشئ حساب Vercel
echo   2. انقر "New Project"
echo   3. ارفع الملفات أو اربط GitHub
echo   4. انقر "Deploy"
echo   5. احصل على الرابط!
echo.
start https://vercel.com
echo ✅ تم فتح Vercel في المتصفح!
pause
goto menu

:prepare
cls
echo.
echo 📁 تحضير ملفات النشر...
echo.

REM إنشاء مجلد النشر
if not exist "deploy" mkdir deploy

REM نسخ الملفات المطلوبة
echo 🔄 نسخ الملفات...
copy "store.html" "deploy\" >nul
copy "advanced-admin.html" "deploy\" >nul
copy "test-sync.html" "deploy\" >nul
copy "index.html" "deploy\" >nul
copy "netlify.toml" "deploy\" >nul
copy "sitemap.xml" "deploy\" >nul

REM نسخ المجلدات
xcopy "public" "deploy\public\" /E /I /Q >nul
xcopy "src" "deploy\src\" /E /I /Q >nul

echo ✅ تم تحضير الملفات في مجلد "deploy"
echo.
echo 📋 الملفات الجاهزة للنشر:
echo   • store.html (المتجر الرئيسي)
echo   • advanced-admin.html (لوحة التحكم)
echo   • test-sync.html (اختبار المزامنة)
echo   • netlify.toml (إعدادات Netlify)
echo   • sitemap.xml (خريطة الموقع)
echo   • public/ (الملفات العامة)
echo.
echo 🌐 يمكنك الآن رفع مجلد "deploy" إلى أي خدمة استضافة!
echo.
pause
goto menu

:test
cls
echo.
echo 🧪 اختبار المتجر محلياً...
echo.

REM التحقق من Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Python غير متوفر!
    pause
    goto menu
)

echo ✅ Python متوفر
echo 🔄 بدء تشغيل خادم الاختبار...
echo.
echo 🌐 سيتم فتح المتجر على: http://localhost:8002
echo 🛑 اضغط Ctrl+C لإيقاف الخادم
echo.

python test-server.py

pause
goto menu

:exit
cls
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    🌐 نشر ناجح!                             ║
echo ║                                                              ║
echo ║         متجر Variteks-Algérie جاهز للعالم! 🚀               ║
echo ║                                                              ║
echo ║              شارك الرابط مع زبائنك واستمتع                ║
echo ║                    بالمبيعات الرقمية! 💰                   ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
timeout /t 3 >nul
exit
