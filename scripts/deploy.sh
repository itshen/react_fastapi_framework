#!/bin/bash

# 检查部署方式
echo "请选择部署方式："
echo "1) 本地部署（使用 gunicorn）"
echo "2) Docker 部署"
read -p "请输入选项 [1/2]: " deploy_option

case $deploy_option in
    1)
        # 本地部署
        echo "开始本地部署..."
        
        # 激活虚拟环境
        cd backend
        source venv/bin/activate
        
        # 构建前端
        cd ../frontend
        npm run build
        
        # 启动生产服务器
        cd ../backend
        gunicorn app.main:app --workers 4 --worker-class uvicorn.workers.UvicornWorker --bind 0.0.0.0:8000
        ;;
        
    2)
        # Docker 部署
        echo "开始 Docker 部署..."
        
        # 检查环境变量
        if [ ! -f .env ]; then
            echo "错误：未找到 .env 文件"
            echo "请创建 .env 文件并设置必要的环境变量"
            exit 1
        fi
        
        # 构建并启动容器
        docker-compose -f docker-compose.prod.yml up --build -d
        ;;
        
    *)
        echo "无效的选项"
        exit 1
        ;;
esac
™
echo "部署完成！" 