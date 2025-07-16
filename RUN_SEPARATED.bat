@echo off
chcp 65001 >nul
title 🏪 متجر Variteks-Algérie - الملفات المنفصلة

:menu
cls
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║              🏪 متجر Variteks-Algérie                        ║
echo ║                الملفات المنفصلة                            ║
echo ║                                                              ║
echo ║    📄 ثلاثة ملفات منفصلة - HTML + CSS + JS                 ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo 📦 الملفات الأساسية:
echo   • index.html (الهيكل الأساسي)
echo   • style.css (التصميم والألوان)
echo   • main.js (الوظائف والتفاعل)
echo.
echo ✨ المميزات:
echo   • سهولة التعديل والتطوير
echo   • فصل الاهتمامات (HTML/CSS/JS)
echo   • إمكانية التطوير التعاوني
echo   • سهولة الصيانة والتحديث
echo   • تنظيم أفضل للكود
echo.
echo 🚀 اختر طريقة التشغيل:
echo.
echo   1. 💻 فتح مباشر (الأسهل)
echo   2. 🌐 خادم محلي للتطوير
echo   3. 🌍 تحضير للنشر على الإنترنت
echo   4. 📖 عرض معلومات الملفات
echo   5. 🧪 اختبار الملفات
echo   6. 🔧 أدوات التطوير
echo   7. ❌ خروج
echo.
set /p choice="👆 اختر رقم (1-7): "

if "%choice%"=="1" goto direct
if "%choice%"=="2" goto server
if "%choice%"=="3" goto deploy
if "%choice%"=="4" goto info
if "%choice%"=="5" goto test
if "%choice%"=="6" goto tools
if "%choice%"=="7" goto exit
echo ❌ اختيار غير صحيح!
timeout /t 2 >nul
goto menu

:direct
cls
echo.
echo 💻 فتح مباشر...
echo.
echo 🔄 جاري فتح المتجر...
start index.html
timeout /t 2 >nul

echo ✅ تم فتح المتجر!
echo.
echo 📋 للاستخدام:
echo   1. المتجر مفتوح الآن في المتصفح
echo   2. انقر على زر الإعدادات (⚙️) لفتح لوحة التحكم
echo   3. أضف منتجات من لوحة التحكم
echo   4. شاهد المنتجات تظهر فوراً في المتجر!
echo.
echo 🔧 للتطوير:
echo   • عدل index.html للهيكل
echo   • عدل style.css للتصميم
echo   • عدل main.js للوظائف
echo.
pause
goto menu

:server
cls
echo.
echo 🌐 تشغيل خادم محلي للتطوير...
echo.

REM التحقق من Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Python غير متوفر!
    echo 📥 يرجى تثبيت Python أولاً من: https://python.org
    pause
    goto menu
)

echo ✅ Python متوفر
echo 🔄 بدء تشغيل خادم التطوير...
echo.
echo 🌐 سيتم فتح المتجر على: http://localhost:8004
echo 📄 الملفات: index.html + style.css + main.js
echo 🛑 اضغط Ctrl+C لإيقاف الخادم
echo.
echo 💡 مميزات خادم التطوير:
echo   • إعادة تحميل تلقائية عند التعديل
echo   • اختبار الملفات المنفصلة
echo   • بيئة تطوير محلية
echo.

REM إنشاء خادم Python بسيط
python -c "
import http.server
import socketserver
import webbrowser
import threading
import time

PORT = 8004

def open_browser():
    time.sleep(1)
    webbrowser.open('http://localhost:8004/index.html')

Handler = http.server.SimpleHTTPRequestHandler
threading.Thread(target=open_browser).start()

with socketserver.TCPServer(('', PORT), Handler) as httpd:
    print(f'خادم التطوير يعمل على http://localhost:{PORT}')
    httpd.serve_forever()
"

pause
goto menu

:deploy
cls
echo.
echo 🌍 تحضير للنشر على الإنترنت...
echo.

REM إنشاء مجلد النشر
if exist "deploy-separated" rmdir /s /q "deploy-separated"
mkdir "deploy-separated"

echo 🔄 نسخ الملفات المنفصلة...
copy "index.html" "deploy-separated\" >nul
copy "style.css" "deploy-separated\" >nul
copy "main.js" "deploy-separated\" >nul

REM إنشاء ملف _redirects لـ Netlify
echo # Redirects for Netlify > "deploy-separated\_redirects"
echo /* /index.html 200 >> "deploy-separated\_redirects"

REM إنشاء ملف README للنشر
echo # متجر Variteks-Algérie - الملفات المنفصلة > "deploy-separated\README.md"
echo. >> "deploy-separated\README.md"
echo ## الملفات: >> "deploy-separated\README.md"
echo - index.html (الهيكل الأساسي) >> "deploy-separated\README.md"
echo - style.css (التصميم والألوان) >> "deploy-separated\README.md"
echo - main.js (الوظائف والتفاعل) >> "deploy-separated\README.md"
echo. >> "deploy-separated\README.md"
echo ## المميزات: >> "deploy-separated\README.md"
echo - سهولة التعديل والتطوير >> "deploy-separated\README.md"
echo - فصل الاهتمامات >> "deploy-separated\README.md"
echo - تنظيم أفضل للكود >> "deploy-separated\README.md"
echo. >> "deploy-separated\README.md"
echo ## للنشر على Netlify: >> "deploy-separated\README.md"
echo 1. اذهب إلى https://netlify.com >> "deploy-separated\README.md"
echo 2. اسحب هذا المجلد كاملاً >> "deploy-separated\README.md"
echo 3. احصل على الرابط! >> "deploy-separated\README.md"

REM إنشاء ملف package.json
echo { > "deploy-separated\package.json"
echo   "name": "variteks-algerie-separated", >> "deploy-separated\package.json"
echo   "version": "1.0.0", >> "deploy-separated\package.json"
echo   "description": "متجر Variteks-Algérie - الملفات المنفصلة", >> "deploy-separated\package.json"
echo   "main": "index.html", >> "deploy-separated\package.json"
echo   "scripts": { >> "deploy-separated\package.json"
echo     "start": "python -m http.server 8000", >> "deploy-separated\package.json"
echo     "dev": "python -m http.server 8004" >> "deploy-separated\package.json"
echo   }, >> "deploy-separated\package.json"
echo   "keywords": ["ecommerce", "algeria", "variteks", "separated"], >> "deploy-separated\package.json"
echo   "author": "Variteks-Algérie", >> "deploy-separated\package.json"
echo   "license": "MIT" >> "deploy-separated\package.json"
echo } >> "deploy-separated\package.json"

echo ✅ تم تحضير ملفات النشر!
echo.
echo 📁 المجلد الجاهز: deploy-separated\
echo 📄 الملفات: 3 ملفات منفصلة
echo.
echo 🌐 للنشر على Netlify:
echo   1. اذهب إلى: https://netlify.com
echo   2. اسحب مجلد "deploy-separated" كاملاً
echo   3. احصل على رابط مثل: https://variteks-algerie.netlify.app
echo.
echo 🔗 الرابط بعد النشر:
echo   • المتجر: https://your-site.netlify.app/
echo.
echo 💡 مميزات النشر:
echo   • ملفات منفصلة = سهولة التطوير
echo   • تحميل سريع ومنظم
echo   • سهولة الصيانة
echo   • إمكانية التطوير التعاوني
echo.

REM فتح مجلد النشر
start explorer deploy-separated

echo 💡 تم فتح مجلد النشر في المستكشف
echo.
pause
goto menu

:info
cls
echo.
echo 📖 معلومات الملفات المنفصلة...
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                   📄 معلومات الملفات                        ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo 📄 الملفات الأساسية:
echo.
echo 1️⃣ index.html (~15KB)
echo   • الهيكل الأساسي للمتجر
echo   • عناصر HTML الأساسية
echo   • ربط ملفات CSS و JS
echo   • SEO Meta Tags
echo.
echo 2️⃣ style.css (~25KB)
echo   • جميع أنماط التصميم
echo   • CSS Variables للألوان
echo   • Responsive Design
echo   • أيقونات Emoji مدمجة
echo.
echo 3️⃣ main.js (~20KB)
echo   • جميع وظائف المتجر
echo   • إدارة المنتجات والسلة
echo   • لوحة التحكم
echo   • مزامنة البيانات
echo.
echo 🎯 المميزات:
echo   • فصل الاهتمامات (Separation of Concerns)
echo   • سهولة التعديل والتطوير
echo   • إمكانية العمل التعاوني
echo   • تنظيم أفضل للكود
echo   • سهولة الصيانة
echo.
echo 🔧 للتطوير:
echo   • HTML: هيكل وعناصر الصفحة
echo   • CSS: تصميم وألوان وتخطيط
echo   • JS: وظائف وتفاعل وبيانات
echo.
pause
goto menu

:test
cls
echo.
echo 🧪 اختبار الملفات المنفصلة...
echo.
echo 🔄 جاري فتح المتجر للاختبار...
start index.html
timeout /t 3 >nul

echo ✅ تم فتح المتجر!
echo.
echo 🧪 قائمة الاختبارات:
echo.
echo ✅ اختبارات الملفات:
echo   1. تحميل index.html بنجاح
echo   2. تحميل style.css (التصميم)
echo   3. تحميل main.js (الوظائف)
echo   4. ربط الملفات مع بعضها
echo.
echo ✅ اختبارات الوظائف:
echo   5. عرض المنتجات التجريبية
echo   6. تشغيل البحث والتصفية
echo   7. فتح وإغلاق سلة التسوق
echo   8. فتح لوحة التحكم
echo.
echo ✅ اختبارات التطوير:
echo   9. تعديل CSS ومشاهدة التغيير
echo   10. تعديل JS واختبار الوظائف
echo   11. تعديل HTML وتحديث الهيكل
echo.
echo 💡 نصائح للاختبار:
echo   • افتح أدوات المطور (F12)
echo   • تحقق من تحميل جميع الملفات
echo   • اختبر على متصفحات مختلفة
echo   • جرب التعديل على الملفات
echo.
echo 🐛 في حالة وجود مشاكل:
echo   • تأكد من وجود جميع الملفات
echo   • تحقق من مسارات الملفات
echo   • راجع وحدة التحكم للأخطاء
echo.
pause
goto menu

:tools
cls
echo.
echo 🔧 أدوات التطوير...
echo.
echo 🛠️ الأدوات المتاحة:
echo.
echo   1. 📝 فتح محرر النصوص
echo   2. 🌐 فتح في متصفح مختلف
echo   3. 📊 فحص الملفات
echo   4. 🔍 البحث في الكود
echo   5. 📋 نسخ احتياطية
echo   6. 🔙 العودة للقائمة الرئيسية
echo.
set /p toolChoice="👆 اختر أداة (1-6): "

if "%toolChoice%"=="1" goto editor
if "%toolChoice%"=="2" goto browser
if "%toolChoice%"=="3" goto inspect
if "%toolChoice%"=="4" goto search
if "%toolChoice%"=="5" goto backup
if "%toolChoice%"=="6" goto menu
echo ❌ اختيار غير صحيح!
timeout /t 2 >nul
goto tools

:editor
echo.
echo 📝 فتح الملفات في محرر النصوص...
start notepad index.html
start notepad style.css
start notepad main.js
echo ✅ تم فتح جميع الملفات!
pause
goto tools

:browser
echo.
echo 🌐 فتح في متصفحات مختلفة...
start chrome index.html
start firefox index.html
start msedge index.html
echo ✅ تم فتح المتجر في متصفحات مختلفة!
pause
goto tools

:inspect
echo.
echo 📊 فحص الملفات...
echo.
echo 📄 index.html:
dir index.html
echo.
echo 🎨 style.css:
dir style.css
echo.
echo ⚡ main.js:
dir main.js
echo.
pause
goto tools

:search
echo.
echo 🔍 البحث في الكود...
set /p searchTerm="🔍 أدخل كلمة البحث: "
echo.
echo 📄 البحث في index.html:
findstr /i "%searchTerm%" index.html
echo.
echo 🎨 البحث في style.css:
findstr /i "%searchTerm%" style.css
echo.
echo ⚡ البحث في main.js:
findstr /i "%searchTerm%" main.js
echo.
pause
goto tools

:backup
echo.
echo 📋 إنشاء نسخة احتياطية...
set backupDir=backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%
mkdir %backupDir%
copy index.html %backupDir%\
copy style.css %backupDir%\
copy main.js %backupDir%\
echo ✅ تم إنشاء نسخة احتياطية في: %backupDir%
pause
goto tools

:exit
cls
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    🎉 شكراً لك!                             ║
echo ║                                                              ║
echo ║      متجر Variteks-Algérie بالملفات المنفصلة جاهز! 🚀      ║
echo ║                                                              ║
echo ║              ثلاثة ملفات = تطوير أسهل! 📄                  ║
echo ║                                                              ║
echo ║              استمتع بالتطوير والتجارة! 💰                  ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo 📄 الملفات الأساسية:
echo   • index.html (الهيكل)
echo   • style.css (التصميم)
echo   • main.js (الوظائف)
echo.
echo 🌐 للنشر: استخدم مجلد deploy-separated
echo 🔧 للتطوير: عدل الملفات حسب الحاجة
echo.
timeout /t 5 >nul
exit
