#!/bin/bash
# Koodo Reader Fork 同步上游脚本
# 用法: bash sync-upstream.sh

set -e

echo "=== 同步 Koodo Reader 上游更新 ==="
echo ""

# 保存当前分支
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "当前分支: $CURRENT_BRANCH"

# 获取所有远程更新
echo "[1/4] 获取远程更新..."
git fetch upstream
git fetch origin

# 同步 dev 分支
echo "[2/5] 同步 dev 分支..."
git checkout dev

# 尝试 rebase 到 upstream/dev，保留我们的 README 修改
if ! git rebase upstream/dev; then
  echo ""
  echo "⚠️  rebase 冲突 detected。通常是因为上游也修改了 README。"
  echo "   请手动解决冲突，保留我们的 README fork 说明，然后继续:"
  echo "   git add README.md"
  echo "   git rebase --continue"
  echo "   git push origin dev"
  exit 1
fi

git push origin dev

# 确保 sync-upstream.sh 在两个分支都存在
echo "[3/5] 更新 sync-upstream.sh..."
if [ -f sync-upstream.sh ]; then
  git add sync-upstream.sh 2>/dev/null || true
fi

# 同步功能分支
echo "[4/5] 将 $CURRENT_BRANCH rebase 到最新 dev..."
git checkout "$CURRENT_BRANCH"
git rebase dev

# 推送到 origin
echo "[5/5] 推送到 origin..."
git push -f origin "$CURRENT_BRANCH"

echo ""
echo "=== 同步完成 ==="
echo ""
echo "你的 fork 现在包含上游最新代码 + Acorny 同步功能。"
