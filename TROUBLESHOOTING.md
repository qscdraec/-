# 🔧 دليل حل مشاكل الاتصال - متجر Variteks-Algérie

## 🚨 المشكلة الشائعة: "Unable to connect" أو "لا يمكن الاتصال"

### الحلول السريعة:

#### 1. استخدام خادم الاختبار
```bash
# شغل هذا الأمر في Terminal/Command Prompt:
python test-server.py

# ثم افتح في المتصفح:
http://localhost:8002
```

#### 2. استخدام خادم Python المدمج
```bash
# إذا فشل الخادم الاختباري:
python -m http.server 8003

# ثم افتح في المتصفح:
http://localhost:8003
```

#### 3. تشغيل تلقائي
```bash
# انقر نقراً مزدوجاً على:
run-server.bat
```

## 🔍 تشخيص المشاكل

### فحص Python:
```bash
python --version
# يجب أن يظهر: Python 3.x.x
```

### فحص المنافذ المستخدمة:
```bash
netstat -an | findstr :8002
# إذا ظهر شيء، فالمنفذ مستخدم
```

### فحص جدار الحماية:
1. افتح Windows Defender Firewall
2. اختر "Allow an app through firewall"
3. ابحث عن Python وفعله

## 🌐 الوصول من أجهزة أخرى

### 1. معرفة عنوان IP:
```bash
ipconfig | findstr IPv4
```

### 2. استخدام العنوان:
```
http://[YOUR_IP]:8002
# مثال: http://192.168.1.100:8002
```

## 📱 اختبار سريع

### الطريقة الأولى: فتح الملفات مباشرة
1. افتح مجلد المشروع
2. انقر نقراً مزدوجاً على `advanced-admin.html`
3. انقر نقراً مزدوجاً على `store.html`

### الطريقة الثانية: استخدام Live Server (VS Code)
1. افتح المشروع في VS Code
2. ثبت إضافة "Live Server"
3. انقر بالزر الأيمن على `advanced-admin.html`
4. اختر "Open with Live Server"

## 🛠️ حلول متقدمة

### تغيير المنفذ:
```python
# في test-server.py، غير:
PORT = 8004  # أو أي رقم آخر
```

### تعطيل جدار الحماية مؤقتاً:
1. افتح Windows Security
2. اذهب إلى Firewall & network protection
3. عطل Windows Defender Firewall مؤقتاً
4. جرب الاتصال
5. أعد تفعيل جدار الحماية

### استخدام متصفح مختلف:
- جرب Chrome بدلاً من Firefox
- جرب Edge
- جرب في وضع التصفح الخاص

## 📋 قائمة فحص سريعة

- [ ] Python مثبت ويعمل
- [ ] الخادم يعمل (ظهور رسالة "الخادم يعمل")
- [ ] المنفذ غير مستخدم من برنامج آخر
- [ ] جدار الحماية يسمح لـ Python
- [ ] المتصفح يدعم localhost
- [ ] لا توجد برامج VPN تتداخل

## 🆘 إذا لم تنجح الحلول

### جرب هذا الترتيب:
1. `python test-server.py` → `http://localhost:8002`
2. `python -m http.server 8003` → `http://localhost:8003`
3. فتح `advanced-admin.html` مباشرة في المتصفح
4. استخدام VS Code Live Server

### معلومات للدعم:
- نظام التشغيل: Windows
- إصدار Python: (شغل `python --version`)
- المتصفح المستخدم: Firefox/Chrome/Edge
- رسالة الخطأ الكاملة

---

**نصيحة:** الطريقة الأسهل هي فتح الملفات مباشرة في المتصفح إذا كنت تستخدم النظام محلياً فقط!
