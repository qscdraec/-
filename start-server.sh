#!/bin/bash

# تعيين الترميز
export LANG=en_US.UTF-8

echo ""
echo "========================================"
echo "    🏪 متجر Variteks-Algérie"
echo "========================================"
echo ""
echo "🔄 بدء تشغيل الخادم..."
echo ""

# التحقق من وجود Python
if ! command -v python3 &> /dev/null; then
    if ! command -v python &> /dev/null; then
        echo "❌ Python غير مثبت على النظام!"
        echo "📥 يرجى تثبيت Python أولاً"
        exit 1
    else
        PYTHON_CMD="python"
    fi
else
    PYTHON_CMD="python3"
fi

# تشغيل الخادم
$PYTHON_CMD server.py

echo ""
echo "🛑 تم إيقاف الخادم"
