#!/usr/bin/env bash
# 常清清个人站发布脚本
# 用法: bash publish.sh
# 作用: 构建 Hugo 站点 -> 推送源码到 main -> 推送构建产物到 gh-pages
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HUGO_BIN="${HUGO_BIN:-/c/Users/Administrator/tools/hugo/hugo.exe}"
REMOTE="https://github.com/cqq884457999-ctrl/cqq884457999-ctrl.github.io.git"
BUILD_DIR="$REPO_DIR/public"
SITE_URL="https://cqq884457999-ctrl.github.io/"

if [ -z "${GH_TOKEN:-}" ]; then
    echo "错误: 需要设置 GH_TOKEN 环境变量" >&2
    echo "  export GH_TOKEN=github_pat_xxx" >&2
    exit 1
fi

AUTH_REMOTE="https://x-access-token:${GH_TOKEN}@github.com/cqq884457999-ctrl/cqq884457999-ctrl.github.io.git"

echo "[1/4] 构建站点..."
"$HUGO_BIN" --source "$REPO_DIR" --gc --minify --quiet --destination "$BUILD_DIR"
touch "$BUILD_DIR/.nojekyll"

echo "[2/4] 推送源码到 main..."
cd "$REPO_DIR"
git add -A
if ! git diff --cached --quiet; then
    git -c user.name="常清清" -c user.email="changqingqing@yswg.com.cn" \
        commit -q -m "发布: $(date +%Y-%m-%d\ %H:%M)"
fi
git -c credential.helper= push -q "$AUTH_REMOTE" main

echo "[3/4] 推送构建产物到 gh-pages..."
rm -rf "$REPO_DIR/.build-tmp"
cp -r "$BUILD_DIR" "$REPO_DIR/.build-tmp"
cd "$REPO_DIR/.build-tmp"
git init -q
git checkout -q -b gh-pages
git add -A
git -c user.name="常清清" -c user.email="changqingqing@yswg.com.cn" \
    commit -q -m "构建产物 $(date +%Y-%m-%d\ %H:%M)"
git -c credential.helper= push -q --force "$AUTH_REMOTE" gh-pages
cd "$REPO_DIR"
rm -rf "$REPO_DIR/.build-tmp"

echo "[4/4] 完成。"
echo "站点地址: $SITE_URL"
echo "GitHub Pages 通常 1-2 分钟内生效。"
