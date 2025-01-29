#!/bin/bash

# 设置错误时退出
set -e

# 获取脚本所在的绝对路径
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# 导入配置
source "${SCRIPT_DIR}/scripts/config.sh"

# 生成项目路径（时间戳在前，随机字符串在后）
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
RANDOM_STRING=$(LC_ALL=C tr -dc 'a-z0-9' < /dev/urandom | head -c 4)
PROJECT_DIR="${SCRIPT_DIR}/../${PROJECT_NAME}_${TIMESTAMP}_${RANDOM_STRING}"

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

# 检查必要的命令是否存在
check_requirements() {
    log_info "检查系统要求..."
    
    # 检查 python3
    if ! command -v python3 &> /dev/null; then
        log_error "python3 未安装，请先安装 Python 3.8 或更高版本"
        exit 1
    fi

    # 检查其他命令
    commands=("node" "npm" "git")
    for cmd in "${commands[@]}"; do
        if ! command -v $cmd &> /dev/null; then
            log_error "$cmd 未安装，请先安装必要的依赖"
            exit 1
        fi
    done
    
    log_info "系统要求检查完成 ✓"
}

# 创建并准备项目目录
prepare_project() {
    log_info "开始创建项目..."
    
    # 创建项目目录
    mkdir -p "${PROJECT_DIR}"
    
    # 创建基本目录结构
    mkdir -p "${PROJECT_DIR}"/{backend,frontend,docker,scripts}
    mkdir -p "${PROJECT_DIR}/backend/app/"{api,core,db,models,schemas}
    mkdir -p "${PROJECT_DIR}/backend/tests"
    mkdir -p "${PROJECT_DIR}/backend/alembic"
    mkdir -p "${PROJECT_DIR}/frontend/src/"{components,pages,services,utils}
    mkdir -p "${PROJECT_DIR}/frontend/src/components/"{Layout,Auth,Common}
    mkdir -p "${PROJECT_DIR}/frontend/src/pages/"{Home,Login,Register,Dashboard}
    mkdir -p "${PROJECT_DIR}/frontend/public"
    mkdir -p "${PROJECT_DIR}/docker/"{nginx,scripts}
    
    # 添加 .vscode 目录
    mkdir -p "${PROJECT_DIR}/frontend/.vscode"
    mkdir -p "${PROJECT_DIR}/backend/.vscode"
    
    # 复制所有脚本和配置文件
    cp -r "${SCRIPT_DIR}/scripts"/* "${PROJECT_DIR}/scripts/"
    cp "${SCRIPT_DIR}/.gitignore" "${PROJECT_DIR}/"
    cp "${SCRIPT_DIR}/LICENSE" "${PROJECT_DIR}/"
    cp "${SCRIPT_DIR}/README.md" "${PROJECT_DIR}/"
    
    # 复制 VS Code 配置文件
    cp "${SCRIPT_DIR}/frontend/.vscode/launch.json" "${PROJECT_DIR}/frontend/.vscode/"
    cp "${SCRIPT_DIR}/backend/.vscode/launch.json" "${PROJECT_DIR}/backend/.vscode/"
    
    # 设置脚本执行权限
    chmod +x "${PROJECT_DIR}/scripts/"*.sh
    
    log_info "项目结构创建完成 ✓"
    
    # 切换到项目目录
    cd "${PROJECT_DIR}"
}

# 设置开发环境
setup_environment() {
    # 创建并激活 Python 虚拟环境
    log_info "创建 Python 虚拟环境..."
    cd backend
    python3 -m venv venv
    source venv/bin/activate
    python3 -m pip install --upgrade pip
    cd ..
    log_info "Python 虚拟环境创建完成 ✓"
    
    # 设置后端
    log_info "开始设置后端..."
    cd backend
    bash ../scripts/setup_backend.sh
    cd ..
    log_info "后端设置完成 ✓"
    
    # 设置前端
    log_info "开始设置前端..."
    cd frontend
    bash ../scripts/setup_frontend.sh
    cd ..
    log_info "前端设置完成 ✓"
}

# 主函数
main() {
    log_info "开始初始化 ${PROJECT_NAME} v${PROJECT_VERSION}"
    log_info "项目将创建在: ${PROJECT_DIR}"
    
    # 检查要求
    check_requirements
    
    # 准备项目目录
    prepare_project
    
    # 设置开发环境
    setup_environment
    
    log_info "项目初始化完成！"
    log_info "使用以下命令启动项目："
    echo "cd ${PROJECT_DIR}"
    echo "bash scripts/start.sh"
}

# 执行主函数
main

# 添加启动脚本执行权限
chmod +x scripts/launch_front_end.sh scripts/launch_back_end.sh 