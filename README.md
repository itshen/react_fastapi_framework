# AI 应用基础框架

这是一个现代化的 AI 应用基础框架，使用 FastAPI + React + TypeScript 构建，提供完整的开发环境和部署流程。

## 功能特性

- 🚀 现代化技术栈：React 17 + TypeScript + FastAPI
- 🔐 内置用户认证系统和 JWT 支持
- 🎨 精美的 Ant Design 4.x UI 界面
- 📦 完整的 Docker 容器化部署方案
- 🔄 自动化开发环境配置
- 📊 基础数据可视化支持
- 🔍 API 状态实时监控
- 🛠 完整的部署和维护工具链

## 技术栈

### 后端
- FastAPI：高性能 Python Web 框架
- SQLite：关系型数据库
- SQLAlchemy：ORM
- JWT：用户认证

### 前端
- React 17.0.2：前端框架
- TypeScript 4.4.2：类型安全
- Ant Design 4.16.13：UI 组件库
- React Router 5.3.0：路由管理
- Axios 0.21.1：HTTP 请求

### 部署
- Docker：容器化
- Nginx：反向代理
- Docker Compose：服务编排

## 快速开始

### 环境要求
- Python 3.8+
- Node.js 16+
- Docker & Docker Compose（可选，用于容器化部署）
- Git

### 安装步骤

1. 克隆项目
```bash
git clone <项目地址>
cd learn_react
```

2. 初始化项目
```bash
./init_project.sh
```

3. 启动开发环境
```bash
bash scripts/start.sh
```

现在可以访问：
- 前端：http://localhost:3000
- 后端 API：http://localhost:8000
- API 文档：http://localhost:8000/docs 或 http://localhost:8000/redoc

## 项目结构

```
learn_react/
├── frontend/              # 前端代码
│   ├── src/
│   │   ├── components/    # React 组件
│   │   ├── utils/        # 工具函数（包含 request.ts）
│   │   └── App.tsx       # 主应用组件
│   ├── public/           # 静态资源
│   ├── package.json      # 前端依赖配置
│   └── tsconfig.json     # TypeScript 配置
├── backend/              # 后端代码
├── scripts/             # 自动化脚本
│   ├── setup_frontend.sh  # 前端环境配置
│   ├── setup_backend.sh   # 后端环境配置
│   ├── start.sh          # 启动服务
│   ├── stop.sh           # 停止服务
│   ├── deploy.sh         # 部署脚本
│   └── backup.sh         # 备份脚本
└── docker/              # Docker 配置
```

## 开发指南

### 前端开发
1. 安装依赖：
```bash
cd frontend
npm install
```

2. 启动开发服务器：
```bash
npm start
```

注意：由于使用了较旧版本的 React Scripts，启动时需要设置 NODE_OPTIONS=--openssl-legacy-provider

### 环境配置

#### 前端环境变量
- 开发环境（.env.development）：
  ```
  REACT_APP_API_URL=http://localhost:8000
  REACT_APP_ENV=development
  ```
- 生产环境（.env.production）：
  ```
  REACT_APP_API_URL=/api
  REACT_APP_ENV=production
  ```

## 部署指南

### 开发环境
```bash
bash scripts/start.sh
```

### 生产环境
```bash
bash scripts/deploy.sh
```

### 数据备份
```bash
bash scripts/backup.sh
```

## 常用命令

- 启动服务：`bash scripts/start.sh`
- 停止服务：`bash scripts/stop.sh`
- 部署生产：`bash scripts/deploy.sh`
- 数据备份：`bash scripts/backup.sh`
- 前端开发：`cd frontend && npm start`

## 常见问题

1. 前端启动报 OpenSSL 相关错误
   - 解决方案：确保使用了 `export NODE_OPTIONS=--openssl-legacy-provider` 启动

2. API 连接失败
   - 检查后端服务是否正常运行（http://localhost:8000）
   - 确认 .env.development 中的 API 地址配置正确
   - 检查浏览器控制台是否有 CORS 错误

## 许可证

MIT License 

Copyright (c) 2024 Miyang Tech (Zhuhai Hengqin) Co., Ltd.