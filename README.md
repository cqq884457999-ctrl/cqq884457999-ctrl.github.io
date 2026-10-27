# 常清清的个人笔记站

Hugo + Stack 主题，托管在 GitHub Pages，零成本。

**线上地址**：https://cqq884457999-ctrl.github.io/

## 分支结构

| 分支 | 内容 |
|---|---|
| `main` | 站点源码（配置、文章 Markdown、主题） |
| `gh-pages` | 构建产物（GitHub Pages 实际发布的文件） |

**不要手动改 `gh-pages`**，它每次发布都会被覆盖。

## 怎么写一篇文章

新建 `content/post/<英文短名>/index.md`：

```markdown
---
title: "文章标题"
description: "一句话摘要，会显示在列表页"
slug: "url-friendly-name"
date: 2026-10-27
lastmod: 2026-10-27
categories:
    - 亚马逊运营
tags:
    - 选品
    - 广告
draft: false
---

正文从这里开始。

## 二级标题

段落内容。
```

配图放在同一个目录，正文里这样引用：

```markdown
![图片说明](cover.png)
```

## 怎么发布

```bash
export GH_TOKEN=github_pat_xxx
bash publish.sh
```

推送后 1–2 分钟线上生效。

## 本地预览

```bash
/c/Users/Administrator/tools/hugo/hugo.exe server --buildDrafts
```

打开 http://localhost:1313/

## 目录说明

- `hugo.toml` — 站点配置（标题、副标题、菜单、侧栏挂件）
- `content/post/` — 文章
- `config/_default/markup.toml` — Markdown 渲染规则
- `layouts/_partials/head/custom-font.html` — 空文件，用于屏蔽主题默认的 Google Fonts（国内加载不了）
- `assets/scss/custom.scss` — 中文字体栈与正文排版微调
- `i18n/zh-cn.toml` — 界面中文文案
- `themes/hugo-theme-stack` — 主题（git submodule）

## 国内访问说明

站点托管在 GitHub Pages，国内可访问但速度不稳定。若要提速，需自备域名并备案后接入国内 CDN。
