#!/usr/bin/env python3
import http.server
import socketserver
import os
import sys

# تغيير المجلد الحالي إلى مجلد الملف
os.chdir(os.path.dirname(os.path.abspath(__file__)))

PORT = 8002

class MyHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        print(f"طلب GET: {self.path}")
        
        if self.path == '/':
            self.path = '/advanced-admin.html'
        elif self.path == '/store':
            self.path = '/store.html'
        elif self.path == '/test':
            self.path = '/test-sync.html'
            
        return super().do_GET()

try:
    with socketserver.TCPServer(("", PORT), MyHandler) as httpd:
        print("=" * 50)
        print(f"🏪 خادم اختبار Variteks-Algérie")
        print(f"🔌 المنفذ: {PORT}")
        print(f"🌐 الرابط: http://localhost:{PORT}")
        print("🛑 لإيقاف الخادم: اضغط Ctrl+C")
        print("=" * 50)
        
        httpd.serve_forever()
        
except KeyboardInterrupt:
    print("\n🛑 تم إيقاف الخادم")
except Exception as e:
    print(f"❌ خطأ: {e}")
    sys.exit(1)
