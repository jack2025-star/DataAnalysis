@echo off
chcp 65001 >nul

echo 正在从 Kaggle 下载数据集到 data/ 文件夹

:: 检查 data 目录是否存在，不存在则创建
if not exist "data" mkdir data

:: 检查 kaggle 命令是否可用
where kaggle >nul 2>nul
if %errorlevel% neq 0 (
    echo [错误] 未找到 kaggle 命令，请先激活虚拟环境并执行: pip install kaggle
    pause
    exit /b 1
)

:: 检查数据是否已存在（以核心文件作为标志）
if exist "data\olist_orders_dataset.csv" (
    echo 数据已存在，跳过下载
) else (
    echo 开始下载，请稍候...
    kaggle datasets download -d olistbr/brazilian-ecommerce -p ./data --unzip
    if %errorlevel% neq 0 (
        echo [失败] 下载出错，请检查网络或Kaggle API配置
    ) else (
        echo [成功] 下载并解压完成！学习是一个长久的过程，请不要放弃
    )
)
pause