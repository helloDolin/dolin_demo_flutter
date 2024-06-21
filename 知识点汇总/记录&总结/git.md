# pip3 install gitpython
```python
// python 查看 git 状态
def git_is_clean():
    repo = git.Repo(flutter_path)
    res = repo.git.status()
    isClean = (res.find('nothing to commit, working tree clean') != -1)
    return isClean
```

# .gitconfig
[user]
	name = Dolin
	email = 366688603@qq.com
[core]
	excludesfile = /Users/bd/.gitignore_global
[difftool "sourcetree"]
	cmd = opendiff \"$LOCAL\" \"$REMOTE\"
	path = 
[mergetool "sourcetree"]
	cmd = /Applications/Sourcetree.app/Contents/Resources/opendiff-w.sh \"$LOCAL\" \"$REMOTE\" -ancestor \"$BASE\" -merge \"$MERGED\"
	trustExitCode = true
[commit]
	# 提交信息模板 
	template = /Users/bd/.stCommitMsg
[filter "lfs"]
	clean = git-lfs clean -- %f
	smudge = git-lfs smudge -- %f
	process = git-lfs filter-process
	required = true

# 删除 git 管理
rm -rf .git

# stash
git stash list

git stash drop stash@{n} // n 为 stash 的索引
git stash drop // 删除最近的
## 应用最近的 stash
git stash apply

## 应用并删除最近的
git stash pop

## 应用特定的 stash
git stash apply stash@{n}

## 清空所有 stash
git stash clear

# 撤回 rebase
```git
git rebase --abort
```
## 撤回前
flutter_aiera git:(shaolin/overtimeRecovery) git status
On branch shaolin/overtimeRecovery
Your branch is up to date with 'origin/shaolin/overtimeRecovery'.

Last commands done (5 commands done):
   pick c61b5de feat:UI 微调
   pick c3ffd49 fix:寄售置顶已失效、已使用时不可点击
  (see more in file .git/rebase-merge/done)
Next commands to do (4 remaining commands):
   pick c61b5de feat:UI 微调
   pick bd2c83f fix:后端返回道具数量为 0 时，按钮不可点击
  (use "git rebase --edit-todo" to view and edit)
You are currently editing a commit while rebasing branch 'shaolin/overtimeRecovery' on '229d77e'.
  (use "git commit --amend" to amend the current commit)
  (use "git rebase --continue" once you are satisfied with your changes)

## 撤回后
flutter_aiera git:(shaolin/overtimeRecovery) git rebase --abort
➜  flutter_aiera git:(shaolin/overtimeRecovery) git status
On branch shaolin/material_fate
Your branch is up to date with 'origin/shaolin/material_fate'.

nothing to commit, working tree clean

# cherry-pick
git cherry-pick 80d02674068ba712c0583f76a0824325785de0b7

# 删除最近一个提交节点
git reset --hard HEAD^  # 删除最近的提交并丢弃更改
git push origin HEAD --force  # 强制推送更改到远程仓库

# 合并多个提交为一个：
// n 为节点个数
git reset --soft HEAD~3
git commit -m "feat:多域名切换"
git push origin HEAD --force

// 推送到远程分支
git push origin 分支名 --force
git push origin develop --force

git push origin shaolin/newbie_draw --force
git push origin shaolin/prop --force

# 冲突
<<< 当前更改
====
>>>> 传入的更改

他人、我的都是针对当前分支来，eg：拉取比人的分支有冲突，那么当前分支就是自己的分支，他人就是他人的

# 从版本控制中移除某个文件但保留在工作目录中
git rm --cached model.dart
git commit -m "Remove secret.txt from tracking"

# 恢复追踪
git add secret.txt
git commit -m "Re-add secret.txt to tracking"


# git 配置

git config --global user.name ''
git config --global user.email ''

git config user.email
git config user.name

git config user.name 'helloDolin'
git config user.email '366688603@qq.com'

# 提交规范
属性	     描述
feat		新功能
fix			修改bug
docs		文档修改
style		格式修改
refactor	重构
perf		性能提升
test		测试
build		构建系统
ci			对CI配置文件修改
chore		修改构建流程、或者增加依赖库、工具
revert		回滚版本

# 日志相关
## 格式化输出
git log --author="Dolin Liao" --pretty=format:"%h - %an, %ar : %s"

## 指定日期
git log --author="Dolin Liao" --since="3 month ago"

## 查询并导出
git log --author="Dolin Liao" --pretty=format:"%h - %an, %ar : %s" > dolin_commits.txt

## 查看提交数量统计
git shortlog -s -n
git shortlog -s -n --author="Dolin Liao"
-s: 简化输出 (Summarize Output)
-n: 按提交次数排序 (Sort by number of commits)
