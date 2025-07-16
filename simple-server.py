#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
خادم بسيط لمتجر Variteks-Algérie
"""

import http.server
import socketserver
import socket
import webbrowser
import threading
import time
import os

def get_local_ip():
    """الحصول على عنوان IP المحلي"""
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        local_ip = s.getsockname()[0]
        s.close()
        return local_ip
    except Exception:
        return "127.0.0.1"

def find_free_port(start_port=8000):
    """البحث عن منفذ متاح"""
    for port in range(start_port, start_port + 10):
        try:
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
                s.bind(('', port))
                return port
        except OSError:
            continue
    return None

class SimpleHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        super().end_headers()
    
    def do_GET(self):
        if self.path == '/':
            self.path = '/advanced-admin.html'
        elif self.path == '/store':
            self.path = '/store.html'
        elif self.path == '/test':
            self.path = '/test-sync.html'
        super().do_GET()

def open_browser_delayed(url, delay=2):
    """فتح المتصفح بعد تأخير"""
    time.sleep(delay)
    try:
        webbrowser.open(url)
        print(f"🌐 تم فتح المتصفح: {url}")
    except Exception as e:
        print(f"❌ تعذر فتح المتصفح: {e}")

def main():
    # الحصول على IP والمنفذ
    local_ip = get_local_ip()
    port = find_free_port()
    
    if not port:
        print("❌ لم يتم العثور على منفذ متاح!")
        return
    
    # إنشاء الخادم
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    
    with socketserver.TCPServer(("", port), SimpleHandler) as httpd:
        print("=" * 60)
        print("🏪 خادم متجر Variteks-Algérie")
        print("=" * 60)
        print(f"📍 عنوان IP المحلي: {local_ip}")
        print(f"🔌 المنفذ: {port}")
        print()
        print("🔗 الروابط المتاحة:")
        print(f"   📊 لوحة التحكم: http://{local_ip}:{port}/")
        print(f"   🏪 المتجر: http://{local_ip}:{port}/store")
        print(f"   🧪 اختبار المزامنة: http://{local_ip}:{port}/test")
        print()
        print("🌐 للوصول من أجهزة أخرى في الشبكة:")
        print(f"   استخدم العنوان: http://{local_ip}:{port}/")
        print()
        print("🛑 لإيقاف الخادم: اضغط Ctrl+C")
        print("=" * 60)
        
        # فتح المتصفح
        browser_thread = threading.Thread(
            target=open_browser_delayed, 
            args=(f"http://{local_ip}:{port}/",)
        )
        browser_thread.daemon = True
        browser_thread.start()
        
        try:
            print("🚀 الخادم يعمل...")
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\n🛑 تم إيقاف الخادم")

if __name__ == "__main__":
    main()
