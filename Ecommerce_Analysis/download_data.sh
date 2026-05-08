#!/bin/bash
echo "正在从 Kaggle 下载数据集到 data/ 文件夹..."
kaggle datasets download -d olistbr/brazilian-ecommerce -p ./data --unzip
echo "下载并解压完成！"
