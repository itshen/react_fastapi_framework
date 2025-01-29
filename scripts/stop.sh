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

# 停止后端
stop_backend() {
    log_info "停止后端服务器..."
    pkill -f "uvicorn app.main:app"
}

# 停止前端
stop_frontend() {
    log_info "停止前端开发服务器..."
    pkill -f "react-scripts start"
}

# 停止所有服务
stop_all() {
    stop_backend
    stop_frontend
    log_info "所有服务已停止"
}

# 显示帮助信息
show_help() {
    echo "使用方法: $0 [选项]"
    echo "选项:"
    echo "  -h, --help     显示帮助信息"
    echo "  -f, --frontend 只停止前端"
    echo "  -b, --backend  只停止后端"
    echo "  不带参数则停止所有服务"
}

# 主函数
main() {
    case "$1" in
        -h|--help)
            show_help
            ;;
        -f|--frontend)
            stop_frontend
            ;;
        -b|--backend)
            stop_backend
            ;;
        "")
            stop_all
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