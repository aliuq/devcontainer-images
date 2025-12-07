# DevContainer Images

[![DevContainer](https://img.shields.io/github/actions/workflow/status/aliuq/devcontainer-images/build.yml?label=Build)](./.github/workflows/build.yml)
[![DevContainer](https://img.shields.io/github/actions/workflow/status/aliuq/devcontainer-images/build-app.yml?label=Build%20App)](./.github/workflows/build-app.yml)
[![Pulls](https://img.shields.io/docker/pulls/aliuq/devcontainer?label=Docker%20Pulls)](https://hub.docker.com/r/aliuq/devcontainer)

一套预配置的 DevContainer 镜像集合，基于官方 [devcontainers/images](https://github.com/devcontainers/images) 构建，集成了常用的开发工具和配置

## 使用方式

1. `ghcr.io/aliuq/devcontainer:<tag>`: GitHub Container Registry
2. `aliuq/devcontainer:<tag>`: Docker Hub
3. `registry.cn-hangzhou.aliyuncs.com/aliuq/devcontainer:<tag>`: 阿里云容器镜像服务

快速运行

```bash
# GitHub Container Registry
docker run -it --rm ghcr.io/aliuq/devcontainer:base /bin/zsh

# Docker Hub
docker run -it --rm aliuq/devcontainer:base /bin/zsh

# 阿里云 (推荐国内用户)
docker run -it --rm registry.cn-hangzhou.aliyuncs.com/aliuq/devcontainer:base /bin/zsh
```

## 镜像列表

| 标签 | 描述 | 基础镜像 | 大小 |
|------|------|---------|------|
| [`base`](./src/base) | Ubuntu 基础镜像,功能完整 | `buildpack-deps:noble` | ![Size](https://img.shields.io/docker/image-size/aliuq/devcontainer/base?label=) |
| [`alpine`](./src/base-alpine) | Alpine Linux 轻量级镜像,体积小 | `alpine:3.22` | ![Size](https://img.shields.io/docker/image-size/aliuq/devcontainer/alpine?label=) |
| [`debian`](./src/base-debian) | Debian 稳定版镜像,兼容性好 | `buildpack-deps:trixie` | ![Size](https://img.shields.io/docker/image-size/aliuq/devcontainer/debian?label=) |
| [`me`](./src/me) | 个人定制镜像,包含常用配置 | `ghcr.io/aliuq/devcontainer:base` | ![Size](https://img.shields.io/docker/image-size/aliuq/devcontainer/me?label=) |

## 工具列表

在 [aliuq/devcontainer-features](https://github.com/aliuq/devcontainer-features) 中以可选 feature 形式提供, 支持按需安装:

- [`Zsh`](https://github.com/devcontainers/features/tree/main/src/common-utils): Shell 环境, 集成了 [Oh-My-Zsh](https://github.com/ohmyzsh/ohmyzsh)
- [`Git`](https://github.com/devcontainers/features/tree/main/src/git): 版本控制工具
- [`Eza`](https://github.com/eza-community/eza): 现代化的 `ls` 命令替代品,具有更好的输出格式和颜色
- [`Fzf`](https://github.com/junegunn/fzf): 强大的命令行模糊查找工具,支持快速搜索和导航
- [`Zoxide`](https://github.com/ajeetdsouza/zoxide): 智能 `cd` 命令,记住常用目录并快速跳转
- [`Mise`](https://github.com/jdx/mise): 多语言工具版本管理器,统一管理 Node.js/Python/Ruby 等运行环境
- [`Starship`](https://github.com/starship/starship): 快速、可定制的跨平台 Shell 提示符
- [`Httpie`](https://github.com/httpie/cli): 用户友好的 HTTP 客户端,简化 API 调试
- [`Yazi`](https://github.com/sxyazi/yazi): 快速的终端文件管理器,支持预览和批量操作
- [`Pnpm Completion`](https://pnpm.io/zh/completion): Pnpm 命令自动补全

## 快速开始

### 使用预构建镜像

在项目根目录创建 `.devcontainer/devcontainer.json`:

```json
{
  "name": "My Project",
  "image": "ghcr.io/aliuq/devcontainer:base",
  "customizations": {
    "vscode": {
      "extensions": [
        "github.copilot-chat",
        "streetsidesoftware.code-spell-checker",
        "davidanson.vscode-markdownlint",
        "mads-hartmann.bash-ide-vscode",
        "editorconfig.editorconfig",
        "github.vscode-pull-request-github",
        "github.vscode-github-actions",
        "pkief.material-icon-theme",
        "zhuangtongfa.material-theme"
      ],
      "settings": {
        "workbench.iconTheme": "material-icon-theme",
        "workbench.colorTheme": "One Dark Pro Darker",
        "workbench.preferredDarkColorTheme": "One Dark Pro Darker"
      }
    }
  },
  "features": {
    "ghcr.io/aliuq/devcontainer-features/common:0": {
      "installStarship": true,
      "installHttpie": "true",
      "installYazi": "true",
      "misePackages": "shfmt@latest,node@lts,yarn@1,pnpm@latest,bun@latest",
      "zshPlugins": "bun",
      "pnpmCompletion": "true",
    }
  }
}
```

> [!NOTE]
> 如果在国内访问 GitHub 速度较慢,可以使用阿里云镜像
> `registry.cn-hangzhou.aliyuncs.com/aliuq/devcontainer:base`

### 本地构建

适用于需要自定义镜像的场景:

```bash
# 1. 克隆仓库
git clone https://github.com/aliuq/devcontainer-images.git
cd devcontainer-images

# 2. 构建基础镜像
devcontainer build --image-name base:local --workspace-folder src/base

# 3. 运行测试
docker run -it --rm base:local /bin/zsh

# 其他构建选项:
# 不使用缓存重新构建
devcontainer build --image-name base:local --workspace-folder src/base --no-cache

# 查看详细构建日志
BUILDKIT_PROGRESS=plain devcontainer build --image-name base:local --workspace-folder src/base

# 使用 vscode 用户测试 (模拟实际使用环境)
docker run -it --rm -u vscode base:local /bin/zsh
```

## 自定义配置

### 添加开发语言环境

使用官方 Features 添加所需的开发环境:

```json
{
  "image": "ghcr.io/aliuq/devcontainer:base",
  "features": {
    "ghcr.io/devcontainers/features/node:1": {
      "version": "lts"
    },
    "ghcr.io/devcontainers/features/python:1": {
      "version": "3.11"
    },
    "ghcr.io/devcontainers/features/docker-in-docker:2": {}
  }
}
```

### 容器生命周期钩子

在容器不同阶段执行自定义脚本:

```json
{
  "image": "ghcr.io/aliuq/devcontainer:base",
  "onCreateCommand": "echo 'Container created!'",
  "postCreateCommand": "npm install",
  "postStartCommand": "git config --global core.editor 'code --wait'",
  "postAttachCommand": "echo 'Welcome to DevContainer!'"
}
```

### 环境变量和端口转发

```json
{
  "image": "ghcr.io/aliuq/devcontainer:base",
  "containerEnv": {
    "NODE_ENV": "development",
    "API_URL": "http://localhost:3000"
  },
  "forwardPorts": [3000, 5173],
  "portsAttributes": {
    "3000": {
      "label": "Backend",
      "onAutoForward": "notify"
    }
  }
}
```

## 开发说明

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

## 相关链接

- [DevContainers 官方文档](https://containers.dev/)
- [DevContainer Images](https://github.com/devcontainers/images)
- [DevContainer Features](https://github.com/devcontainers/features)
- [我的 DevContainer Features](https://github.com/aliuq/devcontainer-features)
- [VS Code Remote - Containers](https://code.visualstudio.com/docs/remote/containers)
