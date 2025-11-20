# me

基于 <https://github.com/aliuq/devcontainer-images/tree/master/src/base> 的 devcontainer 镜像，添加了一些常用工具和配置

## QA

### 如果 `remoteUser` 不是 `root`，`postCreateCommand` 等生命周期中出现命令找不到问题

重新添加 `ghcr.io/aliuq/devcontainer-features/common:0` 特性，以修正权限问题

```json
{
 "features": {
    "ghcr.io/aliuq/devcontainer-features/common:0": {}
  }
}
```

### pnpm shell 补全无法生效问题

默认是在 root 用户下执行的，需要执行补全版本，或者手动执行 `/usr/local/share/pnpm-shell-completion.sh` 脚本

```json
{
 "postCreateCommand": {
    "setup pnpm-shell-completion": "/usr/local/share/pnpm-shell-completion.sh"
  }
}
```
