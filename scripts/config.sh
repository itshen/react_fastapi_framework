#!/bin/bash

# 项目名称和版本
PROJECT_NAME="ai-base-framework"
PROJECT_VERSION="1.0.0"

# Python 相关配置
PYTHON_VERSION="3.8"
VENV_NAME="venv"

# Node.js 相关配置
NODE_VERSION="16"
REACT_VERSION="17.0.2"

# 后端依赖
BACKEND_DEPS=(
    "fastapi==0.68.0"
    "uvicorn==0.15.0"
    "sqlalchemy==1.4.23"
    "python-jose==3.3.0"
    "passlib==1.7.4"
    "python-multipart==0.0.5"
    "lancedb==0.1.0"
    "python-dotenv==0.19.0"
    "alembic==1.7.1"
    "pytest==6.2.5"
)

# 前端依赖
FRONTEND_DEPS=(
    "react@17.0.2"
    "antd@4.16.13"
    "axios@0.21.1"
    "react-router-dom@5.3.0"
    "@ant-design/icons@4.6.3"
    "typescript@4.4.2"
)

# 端口配置
BACKEND_PORT=8000
FRONTEND_PORT=3000

# 颜色配置，用于输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color 