# AI 应用基础框架 PRD

## 1. 项目概述
这是一个基础的 AI 应用框架，使用 FastAPI + React (Ant Design) 构建，提供基础的用户认证和数据展示功能，可以作为其他 AI 应用的起点。

## 2. 技术栈
### 2.1 后端
- FastAPI：Web 框架
- SQLite：关系型数据库
- LanceDB：向量数据库
- SQLAlchemy：ORM
- JWT：用户认证

### 2.2 前端
- React：前端框架
- Ant Design：UI 组件库
- React Router：路由管理
- Axios：HTTP 请求

## 3. 页面设计
### 3.1 公共页面
#### 3.1.1 欢迎页面 (/)
- 系统名称和简介
- 登录/注册入口
- 简单的产品特性展示

#### 3.1.2 登录页面 (/login)
- 用户名/密码登录表单
- 记住登录状态选项
- 注册页面链接
- 错误提示

#### 3.1.3 注册页面 (/register)
- 用户注册表单（用户名、密码、确认密码）
- 表单验证
- 登录页面链接
- 错误提示

### 3.2 认证后页面
#### 3.2.1 仪表盘页面 (/dashboard)
- 顶部导航栏（包含用户信息和退出按钮）
- 用户基本信息展示
- 简单的数据统计卡片
- 示例数据列表

## 4. 数据库设计
### 4.1 SQLite 表结构
#### 4.1.1 用户表 (users)
- id: Integer (主键)
- username: String (唯一)
- password_hash: String
- email: String
- created_at: DateTime
- last_login: DateTime

#### 4.1.2 用户统计表 (user_stats)
- id: Integer (主键)
- user_id: Integer (外键)
- login_count: Integer
- last_active: DateTime

### 4.2 LanceDB 存储
#### 4.2.1 用户特征向量表
- user_id: Integer
- feature_vector: Vector
- updated_at: DateTime

## 5. API 设计
### 5.1 认证相关
- POST /api/auth/register：用户注册
- POST /api/auth/login：用户登录
- POST /api/auth/logout：用户登出
- GET /api/auth/me：获取当前用户信息

### 5.2 数据相关
- GET /api/stats/user：获取用户统计数据
- GET /api/vector/similar：获取相似用户示例

## 6. 安全要求
- 密码加密存储
- JWT token 认证
- 路由权限控制
- 表单验证

## 7. 部署要求
- 支持开发环境一键启动
- 前后端分离部署
- 环境变量配置
- 日志记录

### 7.1 开发环境配置文件
#### 7.1.1 后端配置
- requirements.txt：Python 依赖
- .env.example：环境变量示例
- .gitignore：Git 忽略文件
- README.md：项目说明文档

#### 7.1.2 前端配置
- package.json：npm 依赖和脚本
- .env.development：开发环境配置
- .env.production：生产环境配置

### 7.2 Docker 支持
#### 7.2.1 开发环境
- docker-compose.yml：定义服务编排
- Dockerfile.dev：开发环境镜像构建
- .dockerignore：Docker 忽略文件

#### 7.2.2 生产环境
- Dockerfile：生产环境镜像构建
- docker-compose.prod.yml：生产环境服务编排
- nginx.conf：Nginx 配置文件

### 7.3 部署脚本
#### 7.3.1 开发环境
- start.sh：启动开发环境
- stop.sh：停止开发环境
- init.sh：初始化项目（安装依赖等）

#### 7.3.2 生产环境
- deploy.sh：部署脚本
- backup.sh：数据备份脚本

### 7.4 环境变量配置
#### 7.4.1 后端环境变量
- DATABASE_URL：数据库连接字符串
- SECRET_KEY：JWT 密钥
- CORS_ORIGINS：允许的跨域来源
- LOG_LEVEL：日志级别

#### 7.4.2 前端环境变量
- REACT_APP_API_URL：后端 API 地址
- REACT_APP_ENV：环境标识

### 7.5 日志配置
- 访问日志
- 错误日志
- 应用日志
- 性能监控

### 7.6 CI/CD 配置
- GitHub Actions 工作流配置
- 自动化测试
- 自动化部署
- 版本发布

## 8. 后续扩展建议
- 添加更多的 AI 功能模块
- 扩展数据分析功能
- 添加更多的数据可视化
- 集成更多的第三方服务

## 9. 开发优先级
1. 项目基础框架搭建
2. 用户认证功能
3. 基础数据库操作
4. 仪表盘页面开发
5. 数据展示功能
6. 向量数据库集成

## 10. 项目依赖清单
### 10.1 后端依赖
- fastapi==0.68.0
- uvicorn==0.15.0
- sqlalchemy==1.4.23
- python-jose==3.3.0
- passlib==1.7.4
- python-multipart==0.0.5
- lancedb==0.1.0
- python-dotenv==0.19.0
- alembic==1.7.1
- pytest==6.2.5
- black==21.7b0
- isort==5.9.3
- flake8==3.9.2

### 10.2 前端依赖
- react==17.0.2
- antd==4.16.13
- axios==0.21.1
- react-router-dom==5.3.0
- @ant-design/icons==4.6.3
- moment==2.29.1
- typescript==4.4.2
- eslint==7.32.0
- prettier==2.3.2
- jest==27.1.0

## 11. 文件结构 
project/
├── backend/
│ ├── app/
│ │ ├── api/
│ │ ├── core/
│ │ ├── db/
│ │ ├── models/
│ │ └── schemas/
│ ├── tests/
│ ├── alembic/
│ ├── requirements.txt
│ └── .env
├── frontend/
│ ├── src/
│ │ ├── components/
│ │ ├── pages/
│ │ ├── services/
│ │ └── utils/
│ ├── public/
│ └── package.json
├── docker/
│ ├── nginx/
│ └── scripts/
├── scripts/
└── README.md

## 12. 详细目录结构
### 12.1 后端详细结构
```
backend/
├── app/
│   ├── api/
│   │   ├── __init__.py
│   │   ├── auth.py          # 认证相关路由
│   │   ├── users.py         # 用户相关路由
│   │   └── vector.py        # 向量计算相关路由
│   ├── core/
│   │   ├── __init__.py
│   │   ├── config.py        # 配置类
│   │   ├── security.py      # 安全相关工具
│   │   └── database.py      # 数据库连接
│   ├── models/
│   │   ├── __init__.py
│   │   └── user.py          # 用户模型
│   └── schemas/
│       ├── __init__.py
│       └── user.py          # 用户数据模式
```

### 12.2 前端详细结构
```
frontend/
├── src/
│   ├── components/
│   │   ├── Layout/          # 布局组件
│   │   ├── Auth/           # 认证相关组件
│   │   └── Common/         # 通用组件
│   ├── pages/
│   │   ├── Home/           # 首页
│   │   ├── Login/          # 登录页
│   │   ├── Register/       # 注册页
│   │   └── Dashboard/      # 仪表盘
│   ├── services/
│   │   ├── api.ts          # API 调用
│   │   └── auth.ts         # 认证相关
│   └── utils/
│       ├── request.ts       # Axios 配置
│       └── storage.ts       # 本地存储
```

## 13. 配置文件模板
### 13.1 后端 .env.example
```
DATABASE_URL=sqlite:///./app.db
SECRET_KEY=your-secret-key
CORS_ORIGINS=http://localhost:3000
LOG_LEVEL=INFO
```

### 13.2 Docker Compose
```yaml
version: '3.8'
services:
  backend:
    build: ./backend
    ports:
      - "8000:8000"
    volumes:
      - ./backend:/app
  
  frontend:
    build: ./frontend
    ports:
      - "3000:3000"
    volumes:
      - ./frontend:/app
```

### 13.3 启动脚本
```bash
# init.sh
#!/bin/bash
# 安装后端依赖
cd backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# 安装前端依赖
cd ../frontend
npm install

# start.sh
#!/bin/bash
# 启动后端
cd backend
source venv/bin/activate
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000 &

# 启动前端
cd ../frontend
npm start
```
