@echo off
chcp 65001 >nul
title 🚀 نشر متجر Variteks-Algérie على Netlify

cls
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                🚀 نشر على Netlify                           ║
echo ║                متجر Variteks-Algérie                        ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo ✅ الحزمة جاهزة في مجلد: netlify-deploy
echo.
echo 📋 خطوات النشر:
echo   1. سيتم فتح موقع Netlify
echo   2. أنشئ حساب مجاني (أو سجل دخول)
echo   3. انقر "Add new site" ثم "Deploy manually"
echo   4. اسحب مجلد "netlify-deploy" كاملاً
echo   5. انتظر 1-2 دقيقة
echo   6. احصل على الرابط!
echo.
echo 🌐 سيتم فتح Netlify في المتصفح...
echo.
pause

REM فتح موقع Netlify
start https://netlify.com

REM فتح مجلد النشر
start explorer netlify-deploy

echo.
echo ✅ تم فتح:
echo   • موقع Netlify في المتصفح
echo   • مجلد netlify-deploy في المستكشف
echo.
echo 📁 اسحب مجلد "netlify-deploy" إلى موقع Netlify
echo.
echo 🎯 بعد النشر، الرابط سيكون شيء مثل:
echo    https://amazing-name.netlify.app
echo.
echo 💡 يمكنك تغيير الاسم من إعدادات الموقع
echo.
pause
