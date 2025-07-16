@echo off
chcp 65001 >nul
title إنشاء حزمة Netlify - متجر Variteks-Algérie

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║              📦 إنشاء حزمة Netlify                          ║
echo ║                متجر Variteks-Algérie                        ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

REM إنشاء مجلد النشر
if exist "netlify-deploy" rmdir /s /q "netlify-deploy"
mkdir "netlify-deploy"

echo 🔄 نسخ الملفات الأساسية...

REM نسخ الملفات الرئيسية
copy "store.html" "netlify-deploy\" >nul
copy "advanced-admin.html" "netlify-deploy\" >nul
copy "test-sync.html" "netlify-deploy\" >nul
copy "welcome.html" "netlify-deploy\" >nul
copy "index.html" "netlify-deploy\" >nul

REM نسخ ملفات الإعداد
copy "netlify.toml" "netlify-deploy\" >nul
copy "sitemap.xml" "netlify-deploy\" >nul

REM نسخ المجلدات المطلوبة
echo 🔄 نسخ المجلدات...
if exist "public" xcopy "public" "netlify-deploy\public\" /E /I /Q >nul
if exist "src" xcopy "src" "netlify-deploy\src\" /E /I /Q >nul
if exist "assets" xcopy "assets" "netlify-deploy\assets\" /E /I /Q >nul

REM إنشاء ملف _redirects لـ Netlify
echo 🔄 إنشاء ملف _redirects...
echo # Redirects for Netlify > "netlify-deploy\_redirects"
echo / /store.html 200 >> "netlify-deploy\_redirects"
echo /admin /advanced-admin.html 200 >> "netlify-deploy\_redirects"
echo /test /test-sync.html 200 >> "netlify-deploy\_redirects"
echo /welcome /welcome.html 200 >> "netlify-deploy\_redirects"

REM إنشاء ملف README للنشر
echo 🔄 إنشاء ملف README...
echo # متجر Variteks-Algérie > "netlify-deploy\README.md"
echo. >> "netlify-deploy\README.md"
echo هذا المجلد جاهز للرفع على Netlify >> "netlify-deploy\README.md"
echo. >> "netlify-deploy\README.md"
echo ## الروابط: >> "netlify-deploy\README.md"
echo - المتجر: / >> "netlify-deploy\README.md"
echo - لوحة التحكم: /admin >> "netlify-deploy\README.md"
echo - اختبار المزامنة: /test >> "netlify-deploy\README.md"
echo - صفحة الترحيب: /welcome >> "netlify-deploy\README.md"

REM إنشاء ملف package.json (اختياري)
echo 🔄 إنشاء ملف package.json...
echo { > "netlify-deploy\package.json"
echo   "name": "variteks-algerie-store", >> "netlify-deploy\package.json"
echo   "version": "2.0.0", >> "netlify-deploy\package.json"
echo   "description": "متجر Variteks-Algérie للتجارة الإلكترونية", >> "netlify-deploy\package.json"
echo   "main": "store.html", >> "netlify-deploy\package.json"
echo   "scripts": { >> "netlify-deploy\package.json"
echo     "build": "echo 'Building Variteks Store...'" >> "netlify-deploy\package.json"
echo   }, >> "netlify-deploy\package.json"
echo   "keywords": ["ecommerce", "algeria", "variteks", "store"], >> "netlify-deploy\package.json"
echo   "author": "Variteks-Algérie", >> "netlify-deploy\package.json"
echo   "license": "MIT" >> "netlify-deploy\package.json"
echo } >> "netlify-deploy\package.json"

echo.
echo ✅ تم إنشاء حزمة Netlify بنجاح!
echo.
echo 📁 المجلد الجاهز: netlify-deploy\
echo.
echo 📋 محتويات الحزمة:
dir "netlify-deploy" /b
echo.
echo 🌐 خطوات النشر على Netlify:
echo   1. اذهب إلى: https://netlify.com
echo   2. أنشئ حساب مجاني
echo   3. انقر "Add new site" ثم "Deploy manually"
echo   4. اسحب مجلد "netlify-deploy" كاملاً
echo   5. انتظر 1-2 دقيقة
echo   6. احصل على الرابط!
echo.
echo 🎯 الرابط سيكون شيء مثل:
echo    https://amazing-name-123456.netlify.app
echo.
echo 💡 نصيحة: يمكنك تغيير اسم الموقع من إعدادات Netlify
echo.

pause
