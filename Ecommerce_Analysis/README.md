# 巴西电商数据分析 

本项目基于巴西知名电商平台 Olist 的数据集



## 数据说明

本项目使用 [Olist Brazilian E-Commerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) 数据集。

这是一个巴西电商公开数据集，包含在 Olist 商店下的订单信息。该数据集涵盖了 2016 年至 2018 年间在巴西多个市场平台上完成的 10 万订单。其特征允许从多个维度查看订单：从订单状态、价格、支付和货运表现到客户位置、产品属性，以及客户最终撰写的评论。

包含以下 9 张关联表：

- `olist_orders_dataset.csv`：订单核心信息
- `olist_order_items_dataset.csv`：订单商品明细
- `olist_order_payments_dataset.csv`：订单支付信息
- `olist_order_reviews_dataset.csv`：订单评价信息
- `olist_customers_dataset.csv`：客户信息
- `olist_sellers_dataset.csv`：卖家信息
- `olist_products_dataset.csv`：商品信息
- `olist_geolocation_dataset.csv`：地理位置信息
- `product_category_name_translation.csv`：商品类别英葡翻译表



## 项目目录结构

```reStructuredText
Ecommerce_Analysis/
├── data/                     # 📂 数据文件夹 (⚠️ 未上传，需按下方指南下载)
├── notebooks/                # 📂 Jupyter Notebook 分析代码
│   ├── 01_
│   ├── 02_
│   └── 03_
├── .gitignore                # Git 忽略规则 (已忽略 data/ 和虚拟环境)
├── requirements.txt          # 📌 项目依赖清单
├── download_data.bat         # 🪟 Windows 一键数据下载脚本
├── download_data.sh          # 🐧 macOS/Linux 一键数据下载脚本
└── README.md                 # 项目说明文档 (本文件)
```



## 数据下载

💡 **为什么需要虚拟环境？**

避免不同项目的依赖相互冲突，并且能精准锁定本项目所需的包版本，确保未来的你能完美复现。

### Python环境

打开终端：Windows 用 PowerShell 或 CMD，macOS/Linux 用 Terminal），查看Python环境

```bash
python --version
```

要求：Python 3.12 或更高版本（本项目基于 3.12.7 开发）。
如果没有安装 Python，请先前往 [python.org](https://www.python.org/downloads/) 下载安装。

### Miniconda

使用虚拟环境推荐使用Miniconda管理，下载推荐使用清华镜像源：[清华大学开源软件镜像站 ](https://mirrors.tuna.tsinghua.edu.cn/#)

官网下载：[Miniconda - Anaconda](https://www.anaconda.com/docs/getting-started/miniconda/main)

#### 方式一：使用 Python 自带的 venv（跨平台）

```bash
# 创建虚拟环境（会在当前目录下生成一个叫 venv 的文件夹）
python -m venv venv
```

1. 然后激活虚拟环境：

| 操作系统               | 激活命令                    |
| ---------------------- | --------------------------- |
| 🪟 Windows (CMD)        | `venv\Scripts\activate.bat` |
| 🪟 Windows (PowerShell) | `venv\Scripts\Activate.ps1` |
| 🍎 macOS / 🐧 Linux      | `source venv/bin/activate`  |

2. 验证激活是否成功：

激活后，终端提示符前面会出现 `(venv)` 字样。再执行 `python --version` 确认版本正确。

3. 退出虚拟环境：`deactivate`

#### 方式二：使用 Conda（如果你已经安装 Anaconda/Miniconda）

```bash
# 创建名为 myenv 的 conda 环境，指定 Python 3.12
conda create -n myenv python=3.12 -y

# 激活环境
conda activate myenv
```

📌 注意：后续的 `pip install` 命令需要在激活的 conda 环境中执行。

#### 安装项目依赖

确保你已经在**激活的虚拟环境**中（终端前缀有 `(venv)` 或 `(myenv)`），然后执行：

```bash
# 一键安装所有依赖
pip install -r requirements.txt

#如果遇到网络慢的问题，可以临时使用国内镜像源，例如：
pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
```

### 配置 Kaggle API（下载数据必需）

由于数据集托管在 Kaggle，需配置 API 密钥才能自动下载：

1. 登录 [Kaggle](https://www.kaggle.com/)，点击头像 -> **Settings**
2. 在 API 部分点击 **Generate New Token**，输入名称后，请妥善保管`API TOKEN`
3. 将该文件放置到指定位置：
   - 🪟 Windows: `C:\Users\<你的电脑用户名>\.kaggle\access_token`
   - 🍎/🐧 macOS/Linux: `~/.kaggle/access_token`

> 💡 如果 `.kaggle` 文件夹不存在，请手动创建。

注：如有变化，请以官方提示文档操作。



### 下载数据集

⚠️ 请确保你的虚拟环境已激活，并且已安装依赖（第 3 步，其中包含 `kaggle` 库）。
然后根据你的操作系统选择下方对应脚本。



🪟 Windows 用户

```bash
.\download_data.bat
```

项目根目录下提供了 `download_data.bat`，双击运行即可。
若你希望手动创建该脚本，请用记事本保存以下内容为 `download_data.bat`：

```batch
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
```



🍎 macOS / 🐧 Linux 用户

项目根目录下提供了 `download_data.sh`，请先给脚本执行权限，然后运行：

```bash
chmod +x download_data.sh
./download_data.sh
```

若你希望手动创建该脚本，请用编辑器保存以下内容为 `download_data.sh`：

```bash
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
```



**备选方案：手动命令行**

如果你不想使用脚本，也可以在激活虚拟环境后，直接在终端执行：

```bash
kaggle datasets download -d olistbr/brazilian-ecommerce -p ./data --unzip
```

数据下载完成后，即可正常阅读和运行 `notebooks/` 下所有分析代码！



## 分析





