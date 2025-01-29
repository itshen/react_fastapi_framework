#!/bin/bash

# 导入配置
source ./scripts/config.sh

# 创建项目根目录
mkdir -p "${PROJECT_NAME}"
cd "${PROJECT_NAME}"

# 创建后端目录结构
mkdir -p backend/app/{api,core,db,models,schemas}
mkdir -p backend/tests
mkdir -p backend/alembic

# 创建前端目录结构
mkdir -p frontend/src/{components,pages,services,utils}
mkdir -p frontend/src/components/{Layout,Auth,Common}
mkdir -p frontend/src/pages/{Home,Login,Register,Dashboard}
mkdir -p frontend/public

# 创建 Docker 相关目录
mkdir -p docker/{nginx,scripts}

# 创建部署脚本目录
mkdir -p scripts

# 创建必要的空文件
touch backend/app/{__init__.py,main.py}
touch backend/app/api/{__init__.py,auth.py,users.py,vector.py}
touch backend/app/core/{__init__.py,config.py,security.py,database.py}
touch backend/app/models/{__init__.py,user.py}
touch backend/app/schemas/{__init__.py,user.py}

# 创建前端基础文件
touch frontend/src/index.tsx
touch frontend/src/App.tsx
touch frontend/src/services/{api.ts,auth.ts}
touch frontend/src/utils/{request.ts,storage.ts}

# 创建配置文件
touch backend/.env.example
touch frontend/.env.development
touch frontend/.env.production
touch docker-compose.yml
touch docker-compose.prod.yml

# 创建 README
cat > README.md << EOL
# ${PROJECT_NAME}

这是一个基础的 AI 应用框架，使用 FastAPI + React (Ant Design) 构建。

## 功能特性

- 🚀 现代化技术栈
- 🔐 内置用户认证系统
- 🎨 美观的 Ant Design 界面
- 📦 Docker 容器化部署
- 🔄 自动化开发环境
- 📊 基础数据可视化
- 🔍 向量数据库支持

## 快速开始

### 环境要求
- Python 3.8+
- Node.js 16+
- Docker & Docker Compose (可选)

### 开发环境启动

1. 启动所有服务（前端 + 后端）：
\`\`\`bash
bash scripts/start.sh
\`\`\`

2. 只启动后端：
\`\`\`bash
bash scripts/start.sh -b
# 或
bash scripts/start.sh --backend
\`\`\`

3. 只启动前端：
\`\`\`bash
bash scripts/start.sh -f
# 或
bash scripts/start.sh --frontend
\`\`\`

4. 停止服务：
\`\`\`bash
# 停止所有服务
bash scripts/stop.sh

# 只停止后端
bash scripts/stop.sh -b

# 只停止前端
bash scripts/stop.sh -f
\`\`\`

启动后可以访问：
- 前端：http://localhost:3000
- 后端 API：http://localhost:8000
- API 文档：http://localhost:8000/docs

## 项目结构

\`\`\`
${PROJECT_NAME}/
├── backend/                # 后端代码
│   ├── app/
│   │   ├── api/           # API 路由
│   │   ├── core/          # 核心配置
│   │   ├── models/        # 数据模型
│   │   └── schemas/       # 数据模式
│   ├── tests/             # 测试文件
│   └── requirements.txt    # Python 依赖
├── frontend/              # 前端代码
│   ├── src/
│   │   ├── components/    # React 组件
│   │   ├── pages/        # 页面组件
│   │   ├── services/     # API 服务
│   │   └── utils/        # 工具函数
│   └── package.json      # Node.js 依赖
└── scripts/              # 项目脚本
    ├── start.sh          # 启动脚本
    ├── stop.sh           # 停止脚本
    ├── deploy.sh         # 部署脚本
    └── backup.sh         # 备份脚本
\`\`\`

## 配置说明

### 后端配置
配置文件：\`backend/.env\`
- \`DATABASE_URL\`：数据库连接 URL
- \`SECRET_KEY\`：JWT 密钥
- \`CORS_ORIGINS\`：允许的跨域来源
- \`LOG_LEVEL\`：日志级别

### 前端配置
配置文件：\`frontend/.env\`
- \`REACT_APP_API_URL\`：后端 API 地址
- \`REACT_APP_ENV\`：环境标识

## 部署说明

### 本地部署
\`\`\`bash
bash scripts/deploy.sh
# 选择选项 1：本地部署（使用 gunicorn）
\`\`\`

### Docker 部署
\`\`\`bash
bash scripts/deploy.sh
# 选择选项 2：Docker 部署
\`\`\`

## 数据备份
\`\`\`bash
bash scripts/backup.sh
\`\`\`

## 常见问题

1. 启动失败
- 检查环境要求是否满足
- 检查端口是否被占用（默认：前端 3000，后端 8000）
- 查看日志文件排查问题

2. 数据库连接失败
- 检查数据库配置
- 确保数据库服务正常运行

3. 前端 API 调用失败
- 检查后端服务是否正常运行
- 确认 API 地址配置正确
- 检查 CORS 配置

## 许可证

MIT License
EOL

echo "项目结构创建完成！" 