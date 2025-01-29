#!/bin/bash

# 导入配置（如果存在）
if [ -f "./scripts/config.sh" ]; then
    source ./scripts/config.sh
fi

# 输出颜色配置
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 输出函数
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 确认函数
confirm() {
    read -p "$(echo -e ${YELLOW}"$1 [y/N]: "${NC})" choice
    case "$choice" in
        y|Y ) return 0;;
        * ) return 1;;
    esac
}

# 主清理函数
main() {
    # 查找所有生成的项目目录
    PROJECT_DIRS=$(find .. -maxdepth 1 -type d -name "${PROJECT_NAME}_*")
    
    if [ -z "$PROJECT_DIRS" ]; then
        log_info "没有找到需要清理的项目目录"
        exit 0
    fi
    
    log_warning "将删除以下项目目录："
    echo "$PROJECT_DIRS"
    
    if ! confirm "是否确定要继续？"; then
        log_info "操作已取消"
        exit 0
    fi

    # 停止所有运行中的容器
    for dir in $PROJECT_DIRS; do
        if [ -f "$dir/scripts/stop.sh" ]; then
            log_info "停止 $dir 中的容器..."
            (cd "$dir" && bash scripts/stop.sh) || true
        fi
    done

    # 删除项目目录
    for dir in $PROJECT_DIRS; do
        log_info "删除目录: $dir"
        rm -rf "$dir"
    done

    log_info "清理完成！"
}

# 执行主函数
main 