#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
خادم ويب لمتجر Variteks-Algérie
يدعم المشاركة عبر الشبكة المحلية والإنترنت
"""

import http.server
import socketserver
import socket
import json
import os
import sys
import webbrowser
from urllib.parse import urlparse, parse_qs
import threading
import time

class VariteksHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    """معالج طلبات HTTP مخصص لمتجر Variteks"""
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=os.getcwd(), **kwargs)
    
    def end_headers(self):
        """إضافة headers للسماح بالوصول من أي مصدر"""
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type, Authorization')
        self.send_header('Cache-Control', 'no-cache, no-store, must-revalidate')
        self.send_header('Pragma', 'no-cache')
        self.send_header('Expires', '0')
        super().end_headers()
    
    def do_OPTIONS(self):
        """معالجة طلبات OPTIONS للـ CORS"""
        self.send_response(200)
        self.end_headers()
    
    def do_GET(self):
        """معالجة طلبات GET"""
        if self.path == '/':
            self.path = '/advanced-admin.html'
        elif self.path == '/store':
            self.path = '/store.html'
        elif self.path == '/test':
            self.path = '/test-sync.html'
        elif self.path == '/api/status':
            self.send_api_response({'status': 'online', 'server': 'Variteks-Algérie'})
            return
        
        super().do_GET()
    
    def send_api_response(self, data):
        """إرسال استجابة API"""
        response = json.dumps(data, ensure_ascii=False).encode('utf-8')
        self.send_response(200)
        self.send_header('Content-Type', 'application/json; charset=utf-8')
        self.end_headers()
        self.wfile.write(response)
    
    def log_message(self, format, *args):
        """تسجيل الرسائل مع الوقت"""
        timestamp = time.strftime('%Y-%m-%d %H:%M:%S')
        print(f"[{timestamp}] {format % args}")

def get_local_ip():
    """الحصول على عنوان IP المحلي"""
    try:
        # إنشاء اتصال وهمي للحصول على IP المحلي
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        local_ip = s.getsockname()[0]
        s.close()
        return local_ip
    except Exception:
        return "127.0.0.1"

def find_free_port(start_port=8000):
    """البحث عن منفذ متاح"""
    for port in range(start_port, start_port + 100):
        try:
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
                s.bind(('', port))
                return port
        except OSError:
            continue
    return None

def print_server_info(ip, port):
    """طباعة معلومات الخادم"""
    print("=" * 60)
    print("🏪 خادم متجر Variteks-Algérie")
    print("=" * 60)
    print(f"📍 عنوان IP المحلي: {ip}")
    print(f"🔌 المنفذ: {port}")
    print()
    print("🔗 الروابط المتاحة:")
    print(f"   📊 لوحة التحكم: http://{ip}:{port}/")
    print(f"   🏪 المتجر: http://{ip}:{port}/store")
    print(f"   🧪 اختبار المزامنة: http://{ip}:{port}/test")
    print()
    print("🌐 للوصول من أجهزة أخرى في الشبكة:")
    print(f"   استخدم العنوان: http://{ip}:{port}/")
    print()
    print("⚠️  تأكد من:")
    print("   • إيقاف جدار الحماية أو السماح للمنفذ")
    print("   • الاتصال بنفس الشبكة المحلية")
    print()
    print("🛑 لإيقاف الخادم: اضغط Ctrl+C")
    print("=" * 60)

def open_browser_delayed(url, delay=2):
    """فتح المتصفح بعد تأخير"""
    time.sleep(delay)
    try:
        webbrowser.open(url)
        print(f"🌐 تم فتح المتصفح: {url}")
    except Exception as e:
        print(f"❌ تعذر فتح المتصفح: {e}")

def main():
    """الدالة الرئيسية"""
    try:
        # الحصول على عنوان IP والمنفذ
        local_ip = get_local_ip()
        port = find_free_port()
        
        if not port:
            print("❌ لم يتم العثور على منفذ متاح!")
            sys.exit(1)
        
        # إنشاء الخادم
        handler = VariteksHTTPRequestHandler
        httpd = socketserver.TCPServer(("", port), handler)
        
        # طباعة معلومات الخادم
        print_server_info(local_ip, port)
        
        # فتح المتصفح في thread منفصل
        browser_thread = threading.Thread(
            target=open_browser_delayed, 
            args=(f"http://{local_ip}:{port}/",)
        )
        browser_thread.daemon = True
        browser_thread.start()
        
        # بدء الخادم
        print("🚀 بدء تشغيل الخادم...")
        httpd.serve_forever()
        
    except KeyboardInterrupt:
        print("\n🛑 تم إيقاف الخادم بواسطة المستخدم")
        httpd.shutdown()
        sys.exit(0)
    except Exception as e:
        print(f"❌ خطأ في تشغيل الخادم: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
