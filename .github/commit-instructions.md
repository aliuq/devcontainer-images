# Git Commit 提交规范

本项目要求 Git Commit Message 使用固定、可重复、可机器检查的结构。
本规范的目标是让人类和 AI 在相同输入下稳定输出相同骨架，避免结构漂移、语言顺序混乱、遗漏变更点或拆成多条提交说明。

## 核心原则

1. 无论暂存区包含多少文件，只能输出一条完整 Commit Message
2. 无论变更点有多少，输出结构必须保持一致
3. 正文必须先英文后中文，顺序不可交换
4. 正文必须解释为什么修改，而不是只罗列修改内容
5. 如果存在多个独立变更点，必须在同一条 Commit Message 中全部覆盖

## AI 固定输出契约

所有 AI 助手生成 Commit Message 时，必须严格遵守以下结构。

### 标准结构

直接输出纯文本，不要添加代码块，不要添加说明语，不要添加标签。

```text
<type>(<scope>): <subject>

<English body>

<中文 body>

[optional footer]
```

### 结构约束

- 第一行必须是 Header，格式只能是 `<type>(<scope>): <subject>` 或 `<type>: <subject>`
- Header 与英文 Body 之间必须且只能有一个空行
- 英文 Body 与中文 Body 之间必须且只能有一个空行
- 如果没有 Footer，输出必须在中文 Body 结束
- 如果有 Footer，中文 Body 与 Footer 之间必须且只能有一个空行
- 整体必须是单条 Commit Message，不能输出多个候选版本

### 固定语言顺序

- 第一段正文必须是英文
- 第二段正文必须是中文
- 英文与中文正文前都不得出现 `[English]`、`[中文]`、`English Body:`、`中文说明:` 等标签

### 固定正文形态

为保证输出稳定，默认使用以下形态。

- 英文 Body 为单个段落，1 到 3 句
- 中文 Body 为单个段落，1 到 3 句
- 即使存在多个独立变更点，仍然保持英文一个段落、中文一个段落
- 多个变更点应在段落内部串联表达，不要为每个点另起一段

## 强制检查清单

生成前，必须逐条自检。

### A. 顶层约束

- 只能输出一条 Commit Message
- 只能输出最终结果，不能输出分析过程
- 不能使用 Markdown 代码块包裹最终结果
- 不能附加“以下是提交信息”之类的说明语

### B. Header 约束

- `type` 必须从允许列表中选择
- `scope` 优先从推荐列表中选择，只有确实无法归类时才省略
- `subject` 必须使用英文祈使句，并以动词原形开头
- `subject` 首字母小写，专有名词除外
- `subject` 末尾不能有句号
- `subject` 不能使用过去式或进行时
- Header 总长度不得超过 72 个字符

### C. Body 约束

- 必须同时包含英文和中文两段
- 英文在前，中文在后
- 两段正文都必须解释动机、背景、影响或合并理由
- 两段正文都不能只描述文件改动清单
- 两段正文结尾都不能使用 `.` 或 `。`
- 如果暂存区包含多个独立变更点，两段正文都必须覆盖全部变更点

### D. Footer 约束

- Footer 仅在确有需要时出现
- 允许的 Footer 形式只有 `BREAKING CHANGE:`、`Closes #123`、`Fixes #123`
- 如果没有 Breaking Change 或 Issue 关联，不要为了凑格式而生成 Footer

## 生成顺序

AI 必须按以下固定顺序生成 Commit Message，不得跳步。

1. 枚举暂存区中的每一个文件
2. 判断这些文件属于单一主题还是多个独立变更点
3. 为所有变更选择一个最合适的 `type`
4. 根据主要修改路径选择 `scope`，如果范围过散则省略
5. 用英文祈使句写一个总括 `subject`
6. 写英文 Body，解释为什么做这些修改，并覆盖全部变更点
7. 写中文 Body，语义对应英文，并覆盖全部变更点
8. 如确有 Breaking Change 或 Issue，再补 Footer
9. 按强制检查清单逐项核对后，输出最终结果

## 类型枚举

`type` 只能从以下列表中选择，不得自造。

| type | 含义 | 示例 |
| :--- | :--- | :--- |
| `feat` | 新增功能 | `feat(blog): add comment section` |
| `fix` | 修复问题 | `fix(auth): handle token expiration` |
| `docs` | 文档变更 | `docs(guide): update installation steps` |
| `style` | 纯格式调整，不影响逻辑 | `style: align markdown list spacing` |
| `refactor` | 重构，既不新增功能也不修 Bug | `refactor(api): simplify user controller` |
| `perf` | 性能优化 | `perf(image): reduce lazy-load overhead` |
| `test` | 测试相关 | `test(unit): add login coverage` |
| `build` | 构建系统、镜像、依赖 | `build(deps): bump node from 20 to 22` |
| `ci` | CI 配置或流水线 | `ci(gh-action): fix release workflow` |
| `chore` | 杂项维护 | `chore: update editor settings` |
| `revert` | 回滚提交 | `revert: feat(auth): add login` |

## Scope 选择规则

优先根据修改路径选择 `scope`。

### 推荐 scope

- 文档类：`ai`、`database`、`docker`、`guide`、`resume`、`tech`、`vitepress`、`wsl`、`docs`
- 配置类：`eslint`、`tsconfig`、`vscode`、`config`
- 构建类：`build`、`ci`、`deps`
- 前端类：`ui`、`components`、`layout`
- 资源类：`assets`、`styles`

### 省略 scope 的条件

只有在以下场景才允许省略 `scope`。

- 变更横跨多个彼此独立的模块，无法选出主范围
- 本次提交本身就是仓库级别的统一调整

如果能归类，就不要省略 `scope`

## Subject 写法

`subject` 是对本次提交的英文总括，要求稳定、简短、可复用。

### 必须遵守

- 使用英文祈使句
- 用动词原形开头，例如 `add`、`fix`、`update`、`clarify`、`simplify`
- 描述做什么，不描述为什么
- 不带句号
- 不使用过去式，例如 `added`、`fixed`
- 不使用进行时，例如 `adding`、`fixing`

### 推荐长度

- 建议控制在 50 个字符以内
- 必须确保整个 Header 不超过 72 个字符

## Body 写法

Body 的目的不是列改动清单，而是解释这次提交为什么值得存在。

### 英文 Body 要求

- 1 到 3 句
- 重点写背景、动机、风险消除、认知成本降低、行为一致性或兼容性原因
- 如果有多个变更点，用一个段落串联说明，不要拆成多段

### 中文 Body 要求

- 1 到 3 句
- 语义上覆盖英文内容，但不要求逐字翻译
- 语气自然，不要变成说明书式逐条罗列

### 明确禁止

- 只写 `update file` 这类空泛内容
- 只描述改了哪些文件
- 英文写原因，中文只写结果
- 英文覆盖全部变更点，中文遗漏部分变更点

## 多功能点提交规则

如果暂存区中存在多个独立变更点，仍然只能输出一条 Commit Message。

### 处理原则

- Header 使用能够总括全部改动的 `type` 与 `subject`
- 英文 Body 必须在同一段中覆盖所有变更点的动机
- 中文 Body 也必须在同一段中覆盖所有变更点的动机
- 不能给每个功能点生成单独的提交信息
- 不能只覆盖其中一个点，遗漏其他点

### 推荐组织方式

1. 先写共同目标，例如减少歧义、统一格式、补足缺失约束
2. 再串联各个变更点各自解决的问题
3. 最后点明整体收益，例如降低误用、减少回归、提升可维护性

## 反模式

以下输出都视为不合规。

### 错误 1：输出多条提交信息

```text
feat(docs): add commit rules

Improve commit guidance so the workflow is easier to follow

完善提交规范，降低理解成本

chore(vscode): update settings

Keep editor defaults aligned across environments

统一编辑器默认设置
```

### 错误 2：正文顺序错误

```text
docs(ai): update commit instructions

更新提交规范以统一输出结构

Clarify the output format for AI generated commits
```

### 错误 3：正文写成标签式模板

```text
docs(ai): update commit instructions

English Body: Clarify the format for generated commits

中文 Body: 明确 AI 生成提交信息的格式
```

### 错误 4：正文只写做了什么，不写为什么

```text
docs(ai): update commit instructions

Rewrite the commit guide and add new examples

重写提交规范并增加新示例
```

### 错误 5：多功能点只覆盖部分变更

```text
docs: update guide and config docs

Clarify the guide so users can follow the setup more easily

澄清使用指南，降低上手难度
```

## 推荐模板

默认情况下，直接套用以下模板。

```text
<type>(<scope>): <subject>

<Explain why this change is needed, what confusion, risk, inconsistency, or maintenance cost it removes, and cover every staged change point when there are multiple topics>

<说明这次修改为什么有必要，解决了什么歧义、风险、不一致或维护成本；如果存在多个变更点，必须全部覆盖>
```

当 `scope` 无法合理归类时，使用以下模板。

```text
<type>: <subject>

<English body>

<中文 body>
```

## 合规示例

### 示例 1：单一文档修改

```text
docs(ai): standardize commit message output

Reduce output drift in AI generated commits by defining one fixed structure, one language order, and one final validation path so repeated prompts produce the same shape more reliably

通过规定唯一结构、固定语言顺序和统一的最终校验流程，减少 AI 生成提交信息时的格式漂移，让重复请求更稳定地产出同一骨架
```

### 示例 2：单一修复

```text
fix(ui): prevent navbar overlap on mobile

Remove a layout regression that hides navigation controls on small screens so the mobile flow remains navigable without requiring users to guess hidden actions

消除小屏设备上导航被遮挡的布局回归，避免用户在移动端流程中看不到关键操作而只能依赖猜测
```

### 示例 3：多功能点合并为一条提交

```text
docs: align wsl, docker, and guide instructions

Reduce setup friction by fixing inconsistent wording across the WSL and Docker docs while also filling prerequisite gaps in the getting-started guide so the full onboarding path reads as one coherent flow

通过修正文档中 WSL 与 Docker 说明的不一致表述，并补齐快速上手指南缺失的前置条件，降低整体接入成本，让完整上手路径保持连贯一致
```

## 最终要求

如果你是 AI 助手，在输出 Commit Message 前，必须确认以下三件事。

1. 输出是不是只有一条 Commit Message
2. 输出结构是不是固定为 Header、英文 Body、中文 Body
3. 暂存区里的每一个变更点是不是都在英文和中文正文中得到覆盖

只要其中任意一项不满足，就必须重写，直到满足为止
