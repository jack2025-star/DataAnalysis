#!/bin/bash

echo "正在从 Kaggle 下载数据集到 data/ 文件夹..."

# 检查 data 目录，不存在则创建
if [ ! -d "data" ]; then
    mkdir -p data
fi

# 检查 kaggle 命令是否可用
if ! command -v kaggle &> /dev/null; then
    echo "[错误]未找到 kaggle 命令，请先激活虚拟环境并执行: pip install kaggle"
    exit 1
fi

# 检查数据是否已存在（以核心文件作为标志）
if [ -f "data/olist_orders_dataset.csv" ]; then
    echo "数据已存在，跳过下载"
else
    echo "开始下载，请稍候..."
    kaggle datasets download -d olistbr/brazilian-ecommerce -p ./data --unzip
    if [ $? -ne 0 ]; then
        echo "[失败] 下载出错，请检查网络或 Kaggle API 配置（第4步）"
    else
        echo "[成功] 下载并解压完成！学习是一个长久的过程，请不要放弃"
    fi
fi