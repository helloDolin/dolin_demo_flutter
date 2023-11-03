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


# 合并多个提交为一个：
// n 为节点个数
git reset --soft HEAD~n
git commit -m "新的提交信息"

// 推送到远程分支
git push origin 分支名 --force
git push origin develop --force
git push origin shaolin/shell_market --force

# git 配置

git config --global user.name ''
git config --global user.email ''

git config user.email
git config user.name

git config user.name 'helloDolin'
git config user.email '366688603@qq.com'