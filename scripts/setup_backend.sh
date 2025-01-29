#!/bin/bash

echo "开始设置后端环境..."

# 创建 requirements.txt
cat > requirements.txt << EOL
fastapi==0.68.0
uvicorn==0.15.0
sqlalchemy==1.4.23
python-jose==3.3.0
passlib==1.7.4
python-multipart==0.0.5
lancedb==0.1.0
python-dotenv==0.19.0
alembic==1.7.1
pytest==6.2.5
gunicorn==20.1.0
EOL

# 安装依赖
pip install -r requirements.txt

# 创建后端配置文件
cat > .env.example << EOL
DATABASE_URL=sqlite:///./app.db
SECRET_KEY=your-secret-key
CORS_ORIGINS=http://localhost:3000
LOG_LEVEL=INFO
EOL

# 创建主应用文件
cat > app/main.py << EOL
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(title="AI Base Framework")

# 配置 CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
async def root():
    return {"message": "Welcome to AI Base Framework API"}
EOL

# 创建数据库配置
cat > app/core/config.py << EOL
from pydantic import BaseSettings
from typing import List

class Settings(BaseSettings):
    DATABASE_URL: str
    SECRET_KEY: str
    CORS_ORIGINS: List[str]
    LOG_LEVEL: str

    class Config:
        env_file = ".env"

settings = Settings()
EOL

# 创建数据库连接
cat > app/core/database.py << EOL
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from app.core.config import settings

engine = create_engine(settings.DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
EOL

echo "后端环境设置完成！" 