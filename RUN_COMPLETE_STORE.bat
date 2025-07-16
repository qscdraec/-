@echo off
chcp 65001 >nul
title 🏪 متجر Variteks-Algérie الكامل

:menu
cls
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                🏪 متجر Variteks-Algérie                      ║
echo ║                   المشروع الكامل                           ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo 📦 الملفات الأساسية:
echo   • variteks-store-complete.html (المتجر الكامل)
echo   • admin-simple.html (لوحة التحكم المبسطة)
echo.
echo 🚀 اختر طريقة التشغيل:
echo.
echo   1. 💻 فتح مباشر (الأسهل والأسرع)
echo   2. 🌐 خادم محلي (للاختبار المتقدم)
echo   3. 🌍 تحضير للنشر على الإنترنت
echo   4. 📖 عرض دليل المشروع الكامل
echo   5. ❌ خروج
echo.
set /p choice="👆 اختر رقم (1-5): "

if "%choice%"=="1" goto direct
if "%choice%"=="2" goto server
if "%choice%"=="3" goto deploy
if "%choice%"=="4" goto guide
if "%choice%"=="5" goto exit
echo ❌ اختيار غير صحيح!
timeout /t 2 >nul
goto menu

:direct
cls
echo.
echo 💻 فتح مباشر...
echo.
echo 🔄 جاري فتح المتجر الكامل...
start variteks-store-complete.html
timeout /t 2 >nul

echo ✅ تم فتح المتجر!
echo.
echo 📋 للاستخدام:
echo   1. المتجر مفتوح الآن في المتصفح
echo   2. انقر على زر الإعدادات (⚙️) لفتح لوحة التحكم
echo   3. أضف منتجات من لوحة التحكم
echo   4. شاهد المنتجات تظهر فوراً في المتجر!
echo.
echo 💡 نصيحة: احفظ الصفحة في المفضلة للوصول السريع
echo.
pause
goto menu

:server
cls
echo.
echo 🌐 تشغيل خادم محلي...
echo.

REM التحقق من Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Python غير متوفر!
    echo 📥 يرجى تثبيت Python أولاً
    pause
    goto menu
)

echo ✅ Python متوفر
echo 🔄 بدء تشغيل الخادم...
echo.
echo 🌐 سيتم فتح المتجر على: http://localhost:8002
echo 🛑 اضغط Ctrl+C لإيقاف الخادم
echo.

python test-server.py

pause
goto menu

:deploy
cls
echo.
echo 🌍 تحضير للنشر على الإنترنت...
echo.

REM إنشاء مجلد النشر
if exist "deploy-complete" rmdir /s /q "deploy-complete"
mkdir "deploy-complete"

echo 🔄 نسخ الملفات الأساسية...
copy "variteks-store-complete.html" "deploy-complete\index.html" >nul
copy "admin-simple.html" "deploy-complete\admin.html" >nul

REM إنشاء ملف _redirects لـ Netlify
echo # Redirects for Netlify > "deploy-complete\_redirects"
echo /admin /admin.html 200 >> "deploy-complete\_redirects"

REM إنشاء ملف README للنشر
echo # متجر Variteks-Algérie - جاهز للنشر > "deploy-complete\README.md"
echo. >> "deploy-complete\README.md"
echo ## الملفات: >> "deploy-complete\README.md"
echo - index.html (المتجر الكامل) >> "deploy-complete\README.md"
echo - admin.html (لوحة التحكم) >> "deploy-complete\README.md"
echo. >> "deploy-complete\README.md"
echo ## للنشر على Netlify: >> "deploy-complete\README.md"
echo 1. اذهب إلى https://netlify.com >> "deploy-complete\README.md"
echo 2. اسحب هذا المجلد كاملاً >> "deploy-complete\README.md"
echo 3. احصل على الرابط! >> "deploy-complete\README.md"

echo ✅ تم تحضير ملفات النشر!
echo.
echo 📁 المجلد الجاهز: deploy-complete\
echo.
echo 🌐 للنشر على Netlify:
echo   1. اذهب إلى: https://netlify.com
echo   2. اسحب مجلد "deploy-complete" كاملاً
echo   3. احصل على رابط مثل: https://variteks-algerie.netlify.app
echo.
echo 🔗 الروابط بعد النشر:
echo   • المتجر: https://your-site.netlify.app/
echo   • لوحة التحكم: https://your-site.netlify.app/admin
echo.

REM فتح مجلد النشر
start explorer deploy-complete

echo 💡 تم فتح مجلد النشر في المستكشف
echo.
pause
goto menu

:guide
cls
echo.
echo 📖 عرض دليل المشروع الكامل...
echo.
start notepad COMPLETE_PROJECT_README.md
echo ✅ تم فتح الدليل!
echo.
pause
goto menu

:exit
cls
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    🎉 شكراً لك!                             ║
echo ║                                                              ║
echo ║         متجر Variteks-Algérie جاهز للاستخدام! 🚀           ║
echo ║                                                              ║
echo ║              استمتع بتجارتك الإلكترونية! 💰                ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
timeout /t 3 >nul
exit
