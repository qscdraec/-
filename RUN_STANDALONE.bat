@echo off
chcp 65001 >nul
title 🏪 متجر Variteks-Algérie - الملف الكامل المستقل

:menu
cls
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║              🏪 متجر Variteks-Algérie                        ║
echo ║                الملف الكامل المستقل                        ║
echo ║                                                              ║
echo ║    📄 ملف واحد يحتوي على كل شيء - HTML + CSS + JS          ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo 📦 الملف الرئيسي:
echo   • variteks-complete-standalone.html
echo.
echo ✨ الميزات:
echo   • متجر إلكتروني كامل في ملف واحد
echo   • لوحة تحكم مدمجة
echo   • لا يحتاج اتصال إنترنت للتشغيل
echo   • جميع الأيقونات والخطوط مدمجة
echo   • يعمل على أي متصفح حديث
echo.
echo 🚀 اختر طريقة التشغيل:
echo.
echo   1. 💻 فتح مباشر (الأسهل)
echo   2. 🌐 خادم محلي للاختبار
echo   3. 🌍 تحضير للنشر على الإنترنت
echo   4. 📖 عرض معلومات الملف
echo   5. 🧪 اختبار الميزات
echo   6. ❌ خروج
echo.
set /p choice="👆 اختر رقم (1-6): "

if "%choice%"=="1" goto direct
if "%choice%"=="2" goto server
if "%choice%"=="3" goto deploy
if "%choice%"=="4" goto info
if "%choice%"=="5" goto test
if "%choice%"=="6" goto exit
echo ❌ اختيار غير صحيح!
timeout /t 2 >nul
goto menu

:direct
cls
echo.
echo 💻 فتح مباشر...
echo.
echo 🔄 جاري فتح المتجر الكامل...
start variteks-complete-standalone.html
timeout /t 2 >nul

echo ✅ تم فتح المتجر!
echo.
echo 📋 للاستخدام:
echo   1. المتجر مفتوح الآن في المتصفح
echo   2. انقر على زر الإعدادات (⚙️) لفتح لوحة التحكم
echo   3. أضف منتجات من لوحة التحكم
echo   4. شاهد المنتجات تظهر فوراً في المتجر!
echo   5. جرب إضافة منتجات للسلة
echo   6. اختبر إتمام الطلب عبر WhatsApp
echo.
echo 💡 نصائح:
echo   • احفظ الصفحة في المفضلة
echo   • يمكن استخدامها بدون إنترنت
echo   • جميع البيانات محفوظة محلياً
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
    echo 📥 يرجى تثبيت Python أولاً من: https://python.org
    pause
    goto menu
)

echo ✅ Python متوفر
echo 🔄 بدء تشغيل الخادم...
echo.
echo 🌐 سيتم فتح المتجر على: http://localhost:8003
echo 📄 الملف: variteks-complete-standalone.html
echo 🛑 اضغط Ctrl+C لإيقاف الخادم
echo.

REM إنشاء خادم Python بسيط
python -c "
import http.server
import socketserver
import webbrowser
import threading
import time

PORT = 8003

def open_browser():
    time.sleep(1)
    webbrowser.open('http://localhost:8003/variteks-complete-standalone.html')

Handler = http.server.SimpleHTTPRequestHandler
threading.Thread(target=open_browser).start()

with socketserver.TCPServer(('', PORT), Handler) as httpd:
    print(f'خادم يعمل على http://localhost:{PORT}')
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
if exist "deploy-standalone" rmdir /s /q "deploy-standalone"
mkdir "deploy-standalone"

echo 🔄 نسخ الملف الأساسي...
copy "variteks-complete-standalone.html" "deploy-standalone\index.html" >nul

REM إنشاء ملف _redirects لـ Netlify
echo # Redirects for Netlify > "deploy-standalone\_redirects"
echo /* /index.html 200 >> "deploy-standalone\_redirects"

REM إنشاء ملف README للنشر
echo # متجر Variteks-Algérie - الملف الكامل المستقل > "deploy-standalone\README.md"
echo. >> "deploy-standalone\README.md"
echo ## الملف الوحيد: >> "deploy-standalone\README.md"
echo - index.html (المتجر الكامل + لوحة التحكم) >> "deploy-standalone\README.md"
echo. >> "deploy-standalone\README.md"
echo ## الميزات: >> "deploy-standalone\README.md"
echo - متجر إلكتروني كامل في ملف واحد >> "deploy-standalone\README.md"
echo - لوحة تحكم مدمجة >> "deploy-standalone\README.md"
echo - لا يحتاج اتصال إنترنت >> "deploy-standalone\README.md"
echo - جميع الموارد مدمجة >> "deploy-standalone\README.md"
echo. >> "deploy-standalone\README.md"
echo ## للنشر على Netlify: >> "deploy-standalone\README.md"
echo 1. اذهب إلى https://netlify.com >> "deploy-standalone\README.md"
echo 2. اسحب هذا المجلد كاملاً >> "deploy-standalone\README.md"
echo 3. احصل على الرابط! >> "deploy-standalone\README.md"

REM إنشاء ملف package.json
echo { > "deploy-standalone\package.json"
echo   "name": "variteks-algerie-standalone", >> "deploy-standalone\package.json"
echo   "version": "1.0.0", >> "deploy-standalone\package.json"
echo   "description": "متجر Variteks-Algérie - الملف الكامل المستقل", >> "deploy-standalone\package.json"
echo   "main": "index.html", >> "deploy-standalone\package.json"
echo   "scripts": { >> "deploy-standalone\package.json"
echo     "start": "python -m http.server 8000" >> "deploy-standalone\package.json"
echo   }, >> "deploy-standalone\package.json"
echo   "keywords": ["ecommerce", "algeria", "variteks", "standalone"], >> "deploy-standalone\package.json"
echo   "author": "Variteks-Algérie", >> "deploy-standalone\package.json"
echo   "license": "MIT" >> "deploy-standalone\package.json"
echo } >> "deploy-standalone\package.json"

echo ✅ تم تحضير ملفات النشر!
echo.
echo 📁 المجلد الجاهز: deploy-standalone\
echo 📄 الملف الوحيد: index.html (1.5MB تقريباً)
echo.
echo 🌐 للنشر على Netlify:
echo   1. اذهب إلى: https://netlify.com
echo   2. اسحب مجلد "deploy-standalone" كاملاً
echo   3. احصل على رابط مثل: https://variteks-algerie.netlify.app
echo.
echo 🔗 الرابط بعد النشر:
echo   • المتجر + لوحة التحكم: https://your-site.netlify.app/
echo.
echo 💡 مميزات النشر:
echo   • ملف واحد فقط = تحميل سريع
echo   • لا يحتاج قواعد بيانات
echo   • يعمل على أي استضافة
echo   • مجاني تماماً
echo.

REM فتح مجلد النشر
start explorer deploy-standalone

echo 💡 تم فتح مجلد النشر في المستكشف
echo.
pause
goto menu

:info
cls
echo.
echo 📖 معلومات الملف الكامل...
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                   📄 معلومات الملف                          ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo 📄 اسم الملف: variteks-complete-standalone.html
echo 📏 الحجم: ~1.5 MB (تقريباً)
echo 🏗️ البنية: HTML + CSS + JavaScript في ملف واحد
echo.
echo ✨ المحتويات:
echo   • HTML كامل للمتجر ولوحة التحكم
echo   • CSS متقدم مع تصميم متجاوب
echo   • JavaScript كامل لجميع الوظائف
echo   • أيقونات Font Awesome مدمجة (كـ Emoji)
echo   • صور افتراضية مدمجة (SVG)
echo   • بيانات تجريبية للمنتجات
echo.
echo 🎯 الوظائف:
echo   • عرض المنتجات بتصميم جذاب
echo   • بحث وتصفية متقدمة
echo   • سلة تسوق كاملة
echo   • إتمام الطلبات عبر WhatsApp
echo   • لوحة تحكم لإدارة المنتجات
echo   • مزامنة فورية بين المتجر ولوحة التحكم
echo   • حفظ البيانات محلياً (localStorage)
echo.
echo 🌐 التوافق:
echo   • جميع المتصفحات الحديثة
echo   • أجهزة الكمبيوتر والجوال
echo   • يعمل بدون إنترنت (بعد التحميل الأول)
echo   • لا يحتاج خادم أو قاعدة بيانات
echo.
echo 🔧 التقنيات المستخدمة:
echo   • HTML5 Semantic Elements
echo   • CSS3 Grid و Flexbox
echo   • CSS Variables للألوان
echo   • JavaScript ES6+
echo   • LocalStorage API
echo   • SVG للصور الافتراضية
echo   • Responsive Design
echo.
pause
goto menu

:test
cls
echo.
echo 🧪 اختبار الميزات...
echo.
echo 🔄 جاري فتح المتجر للاختبار...
start variteks-complete-standalone.html
timeout /t 3 >nul

echo ✅ تم فتح المتجر!
echo.
echo 🧪 قائمة الاختبارات:
echo.
echo ✅ اختبارات أساسية:
echo   1. تحميل الصفحة بنجاح
echo   2. عرض المنتجات التجريبية (6 منتجات)
echo   3. تشغيل البحث والتصفية
echo   4. فتح وإغلاق سلة التسوق
echo.
echo ✅ اختبارات متقدمة:
echo   5. إضافة منتجات للسلة
echo   6. تعديل الكميات في السلة
echo   7. حذف منتجات من السلة
echo   8. فتح لوحة التحكم (زر الإعدادات)
echo.
echo ✅ اختبارات لوحة التحكم:
echo   9. إضافة منتج جديد
echo   10. تعديل منتج موجود
echo   11. حذف منتج
echo   12. مزامنة فورية مع المتجر
echo.
echo ✅ اختبارات الاستجابة:
echo   13. تصغير نافذة المتصفح (جوال)
echo   14. اختبار القوائم المنسدلة
echo   15. اختبار الأزرار والروابط
echo.
echo 💡 نصائح للاختبار:
echo   • جرب جميع الأزرار والقوائم
echo   • اختبر على أحجام شاشة مختلفة
echo   • تأكد من حفظ البيانات بعد إعادة التحميل
echo   • جرب البحث بكلمات مختلفة
echo   • اختبر إضافة منتجات متعددة للسلة
echo.
echo 🐛 في حالة وجود مشاكل:
echo   • اضغط F12 لفتح أدوات المطور
echo   • تحقق من رسائل الخطأ في Console
echo   • جرب في متصفح مختلف
echo   • امسح cache المتصفح (Ctrl+F5)
echo.
pause
goto menu

:exit
cls
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    🎉 شكراً لك!                             ║
echo ║                                                              ║
echo ║      متجر Variteks-Algérie الكامل جاهز للاستخدام! 🚀       ║
echo ║                                                              ║
echo ║                ملف واحد = متجر كامل! 📄                    ║
echo ║                                                              ║
echo ║              استمتع بتجارتك الإلكترونية! 💰                ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo 📄 الملف الرئيسي: variteks-complete-standalone.html
echo 🌐 للنشر: استخدم مجلد deploy-standalone
echo 📖 للمساعدة: اقرأ README.md
echo.
timeout /t 5 >nul
exit
