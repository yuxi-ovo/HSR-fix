#!/bin/bash

HOSTS_FILE="/etc/hosts"
ENTRY="0.0.0.0 globaldp-prod-cn01.bhsr.com"

# 检查是否有root权限
if [[ $EUID -ne 0 ]]; then
    echo "🌟请使用sudo运行此脚本。"
    exit 1
fi

# 检查hosts文件是否存在
if [[ ! -f "$HOSTS_FILE" ]]; then
    echo "❌未找到hosts文件：$HOSTS_FILE"
    exit 2
fi

# 检查条目是否已存在
if grep -Fxq "$ENTRY" "$HOSTS_FILE"; then
    echo "✅条目已存在于hosts文件中，无需添加。"
    exit 0
fi

# 尝试添加条目
echo "$ENTRY" >> "$HOSTS_FILE"
if [[ $? -eq 0 ]]; then
    echo "✅成功添加条目到hosts文件：$ENTRY"
else
    echo "❌添加条目失败，请检查文件权限。"
    exit 3
fi
