# DevContainer Images

一套预配置的 DevContainer 镜像集合，基于官方 [devcontainers/images](https://github.com/devcontainers/images) 构建，集成了常用的开发工具和配置。

## 📦 镜像列表

### base

**基础镜像** - 基于 Ubuntu (noble) 构建，包含基础开发环境。

- 📍 位置: `src/base`
- 🐳 镜像: `ghcr.io/aliuq/devcontainer:base`
- 📖 参考: [devcontainers/base-ubuntu](https://github.com/devcontainers/images/tree/main/src/base-ubuntu)

**预装工具:**

- Zsh + Oh My Zsh
- Git (最新版本)
- Eza (现代化的 ls 替代品)
- Fzf (模糊搜索工具)
- Zoxide (智能目录跳转)
- Mise (运行时版本管理工具)
- Zsh 插件集合

### base-alpine

**Alpine 基础镜像** - 基于 Alpine Linux 构建的轻量级镜像。

- 📍 位置: `src/base-alpine`
- 📖 参考: [devcontainers/base-alpine](https://github.com/devcontainers/images/tree/main/src/base-alpine)

**预装工具:**

- Zsh + Oh My Zsh
- Eza, Fzf, Zoxide, Mise
- Zsh 插件集合

### base-debian

**Debian 基础镜像** - 基于 Debian 构建的稳定版本镜像。

- 📍 位置: `src/base-debian`
- 📖 参考: [devcontainers/base-debian](https://github.com/devcontainers/images/tree/main/src/base-debian)

**预装工具:**

- Zsh + Oh My Zsh
- Eza, Fzf, Zoxide, Mise
- Zsh 插件集合

### me

**个人定制镜像** - 基于 base 镜像构建，添加了更多开发工具和配置。

- 📍 位置: `src/me`
- 🐳 镜像: `ghcr.io/aliuq/devcontainer:me`
- 📖 基于: `ghcr.io/aliuq/devcontainer:base`

**额外预装工具:**

- **容器工具:** Docker-in-Docker, Docker Compose, Python3
- **开发工具:**
  - shfmt (Shell 格式化)
  - jq (JSON 处理)
- **Web 开发:**
  - Node.js (LTS 版本)
  - Bun, Yarn, pnpm
- **Python 开发:**
  - uv (Python 包管理器)
- **HTTP 工具:**
  - HTTPie (现代化的 HTTP 客户端)
- **GitHub CLI**
- **SSH 服务**

**VS Code 扩展:**

- GitHub Copilot & Copilot Chat
- Code Spell Checker
- Markdown Lint
- Bash IDE
- EditorConfig
- GitHub Pull Requests & Actions
- Material Icon Theme
- One Dark Pro Theme

## 🚀 快速开始

### 使用预构建镜像

在你的项目中创建 `.devcontainer/devcontainer.json`:

```json
{
  "name": "My Project",
  "image": "ghcr.io/aliuq/devcontainer:base", // or `aliuq/devcontainer:base`
  "customizations": {
    "vscode": {
      "extensions": [
        // 添加你需要的扩展
      ]
    }
  }
}
```

### 本地构建

克隆仓库并构建镜像:

```bash
# 克隆仓库
git clone https://github.com/aliuq/devcontainer-images.git
cd devcontainer-images

# 构建基础镜像
devcontainer build --image-name base:local --workspace-folder src/base
# 不使用缓存
devcontainer build --image-name base:local --workspace-folder src/base --no-cache
# 查看详细构建日志
BUILDKIT_PROGRESS=plain devcontainer build --image-name base:local --workspace-folder src/base
# 运行测试
docker run -it --rm base:local /bin/zsh
# 使用 vscode 用户进行测试
docker run -it --rm -u vscode base:local /bin/zsh
```

## 🛠️ 自定义配置

### 添加额外的 DevContainer Features

在 `devcontainer.json` 中添加更多 features:

```json
{
  "image": "ghcr.io/aliuq/devcontainer:base",
  "features": {
    "ghcr.io/devcontainers/features/node:1": {},
    "ghcr.io/devcontainers/features/python:1": {}
  }
}
```

### 使用自定义脚本

```json
{
  "image": "ghcr.io/aliuq/devcontainer:base",
  "postCreateCommand": "npm install && npm run setup"
}
```

## 📝 开发说明

### 项目结构

```text
devcontainer-images/
├── src/
│   ├── base/              # 基础镜像 (Ubuntu)
│   ├── base-alpine/       # Alpine 镜像
│   ├── base-debian/       # Debian 镜像
│   └── me/                # 个人定制镜像
├── .github/
│   └── workflows/         # CI/CD 工作流
└── README.md
```

## 🔗 相关链接

- [DevContainers 官方文档](https://containers.dev/)
- [DevContainer Images](https://github.com/devcontainers/images)
- [DevContainer Features](https://github.com/devcontainers/features)
- [我的 DevContainer Features](https://github.com/aliuq/devcontainer-features)
- [VS Code Remote - Containers](https://code.visualstudio.com/docs/remote/containers)
