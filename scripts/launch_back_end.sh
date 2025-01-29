#!/bin/bash

# 获取脚本所在目录的绝对路径
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( dirname "$SCRIPT_DIR" )"

# 导入颜色配置
source "${SCRIPT_DIR}/config.sh"

# 输出函数
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

# 启动后端
log_info "启动后端服务器..."
cd "${PROJECT_ROOT}/backend"
source venv/bin/activate
python3 -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000 