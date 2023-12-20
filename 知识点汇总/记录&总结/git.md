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

# 删除最近一个提交节点
git reset --hard HEAD^  # 删除最近的提交并丢弃更改
git push origin HEAD --force  # 强制推送更改到远程仓库

# 合并多个提交为一个：
// n 为节点个数
git reset --soft HEAD~n
git commit -m "fix：支付成功后，再次请求详情接口"

// 推送到远程分支
git push origin 分支名 --force
git push origin develop --force

git push origin shaolin/predict_trends --force
git push origin shaolin/prop --force

# 冲突
<<< 当前更改
====
>>>> 传入的更改

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