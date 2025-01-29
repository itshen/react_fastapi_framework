#!/bin/bash

# 获取脚本所在目录的绝对路径
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( dirname "$SCRIPT_DIR" )"

# 导入颜色配置
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 输出函数
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 创建日志目录
mkdir -p "${PROJECT_ROOT}/logs"

# 启动后端
start_backend() {
    log_info "启动后端服务器..."
    cd "${PROJECT_ROOT}/backend"
    source venv/bin/activate
    python3 -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000 2>&1 | tee "${PROJECT_ROOT}/logs/backend.log"
}

# 启动前端
start_frontend() {
    log_info "启动前端开发服务器..."
    cd "${PROJECT_ROOT}/frontend"
    export NODE_OPTIONS=--openssl-legacy-provider
    npm start 2>&1 | tee "${PROJECT_ROOT}/logs/frontend.log"
}

# 启动所有服务
start_all() {
    log_info "启动所有服务..."
    
    # 启动后端（在新终端窗口中）
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        osascript -e "tell application \"Terminal\" to do script \"cd '${PROJECT_ROOT}/backend' && source venv/bin/activate && python3 -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000 2>&1 | tee '${PROJECT_ROOT}/logs/backend.log'\""
    else
        # Linux
        gnome-terminal -- bash -c "cd '${PROJECT_ROOT}/backend' && source venv/bin/activate && python3 -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000 2>&1 | tee '${PROJECT_ROOT}/logs/backend.log'"
    fi
    
    # 等待后端启动
    log_info "等待后端服务启动..."
    sleep 2
    
    # 启动前端（在当前终端）
    cd "${PROJECT_ROOT}/frontend"
    export NODE_OPTIONS=--openssl-legacy-provider
    npm start 2>&1 | tee "${PROJECT_ROOT}/logs/frontend.log"
}

# 显示帮助信息
show_help() {
    echo "使用方法: $0 [选项]"
    echo "选项:"
    echo "  -h, --help     显示帮助信息"
    echo "  -f, --frontend 只启动前端"
    echo "  -b, --backend  只启动后端"
    echo "  不带参数则启动所有服务"
    echo ""
    echo "日志文件位置:"
    echo "  后端日志: ${PROJECT_ROOT}/logs/backend.log"
    echo "  前端日志: ${PROJECT_ROOT}/logs/frontend.log"
}

# 主函数
main() {
    case "$1" in
        -h|--help)
            show_help
            ;;
        -f|--frontend)
            start_frontend
            ;;
        -b|--backend)
            start_backend
            ;;
        "")
            start_all
            ;;
        *)
            log_error "未知选项: $1"
            show_help
            exit 1
            ;;
    esac
}

# 执行主函数
main "$@" 