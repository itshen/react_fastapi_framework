#!/bin/bash

echo "开始设置前端环境..."

# 创建 package.json
cat > package.json << EOL
{
  "name": "ai-base-framework-frontend",
  "version": "1.0.0",
  "private": true,
  "dependencies": {
    "react": "17.0.2",
    "react-dom": "17.0.2",
    "antd": "4.16.13",
    "axios": "0.21.1",
    "react-router-dom": "5.3.0",
    "@ant-design/icons": "4.6.3",
    "typescript": "4.4.2",
    "@types/react": "17.0.20",
    "@types/react-dom": "17.0.9",
    "@types/react-router-dom": "5.1.8",
    "react-scripts": "4.0.3"
  },
  "scripts": {
    "start": "export NODE_OPTIONS=--openssl-legacy-provider && react-scripts start",
    "build": "export NODE_OPTIONS=--openssl-legacy-provider && react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  },
  "eslintConfig": {
    "extends": [
      "react-app",
      "react-app/jest"
    ]
  },
  "browserslist": {
    "production": [
      ">0.2%",
      "not dead",
      "not op_mini all"
    ],
    "development": [
      "last 1 chrome version",
      "last 1 firefox version",
      "last 1 safari version"
    ]
  }
}
EOL

# 创建 TypeScript 配置
cat > tsconfig.json << EOL
{
  "compilerOptions": {
    "target": "es5",
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "noFallthroughCasesInSwitch": true,
    "module": "esnext",
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "baseUrl": "src"
  },
  "include": ["src"]
}
EOL

# 创建环境配置文件
cat > .env.development << EOL
REACT_APP_API_URL=http://localhost:8000
REACT_APP_ENV=development
EOL

cat > .env.production << EOL
REACT_APP_API_URL=/api
REACT_APP_ENV=production
EOL

# 创建公共文件
mkdir -p public
cat > public/index.html << EOL
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="theme-color" content="#000000" />
    <meta name="description" content="AI Base Framework" />
    <title>AI Base Framework</title>
  </head>
  <body>
    <noscript>You need to enable JavaScript to run this app.</noscript>
    <div id="root"></div>
  </body>
</html>
EOL

cat > public/manifest.json << EOL
{
  "short_name": "AI Framework",
  "name": "AI Base Framework",
  "start_url": ".",
  "display": "standalone",
  "theme_color": "#000000",
  "background_color": "#ffffff"
}
EOL

# 创建 API 请求工具
mkdir -p src/utils
cat > src/utils/request.ts << EOL
import axios from 'axios';

const request = axios.create({
  baseURL: process.env.REACT_APP_API_URL,
  timeout: 10000,
});

request.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token');
    if (token) {
      config.headers.Authorization = \`Bearer \${token}\`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

request.interceptors.response.use(
  (response) => response.data,
  (error) => {
    return Promise.reject(error);
  }
);

export default request;
EOL

# 创建主应用文件
cat > src/App.tsx << EOL
import React, { useEffect, useState } from 'react';
import { BrowserRouter as Router } from 'react-router-dom';
import { Layout, Card, Alert, Space } from 'antd';
import request from './utils/request';

const { Content } = Layout;

const App: React.FC = () => {
  const [backendStatus, setBackendStatus] = useState<'loading' | 'online' | 'offline'>('loading');
  const [apiMessage, setApiMessage] = useState<string>('');

  useEffect(() => {
    const checkBackend = async () => {
      try {
        const response = await request.get('/');
        setBackendStatus('online');
        setApiMessage(response.message);
      } catch (error) {
        setBackendStatus('offline');
        console.error('Backend check failed:', error);
      }
    };

    checkBackend();
    // 每 30 秒检查一次后端状态
    const interval = setInterval(checkBackend, 30000);
    return () => clearInterval(interval);
  }, []);

  return (
    <Router>
      <Layout style={{ minHeight: '100vh' }}>
        <Content style={{ padding: '50px' }}>
          <Space direction="vertical" size="large" style={{ width: '100%' }}>
            <Card title="系统状态">
              <Space direction="vertical" style={{ width: '100%' }}>
                <Alert
                  message="前端服务"
                  description="运行于 http://localhost:3000"
                  type="success"
                  showIcon
                />
                <Alert
                  message="后端服务"
                  description={\`\${backendStatus === 'online' 
                    ? 'API 运行于 http://localhost:8000' 
                    : backendStatus === 'loading' 
                    ? '正在连接后端...' 
                    : '后端服务未响应'}\`}
                  type={backendStatus === 'online' ? 'success' : backendStatus === 'loading' ? 'info' : 'error'}
                  showIcon
                />
                {backendStatus === 'online' && (
                  <Alert
                    message="API 响应"
                    description={apiMessage}
                    type="success"
                    showIcon
                  />
                )}
              </Space>
            </Card>
            
            <Card title="API 文档">
              <p>可以访问以下地址查看完整的 API 文档：</p>
              <ul>
                <li><a href="http://localhost:8000/docs" target="_blank" rel="noopener noreferrer">Swagger UI</a></li>
                <li><a href="http://localhost:8000/redoc" target="_blank" rel="noopener noreferrer">ReDoc</a></li>
              </ul>
            </Card>
          </Space>
        </Content>
      </Layout>
    </Router>
  );
};

export default App;
EOL

# 创建入口文件
cat > src/index.tsx << EOL
import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';
import 'antd/dist/antd.css';

ReactDOM.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
  document.getElementById('root')
);
EOL

# 安装依赖
npm install

echo "前端环境设置完成！" 