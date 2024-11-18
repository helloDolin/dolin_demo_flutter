# 全新 mac iOS 环境搭建：
1. brew 安装：https://brew.sh/
2. cocoapods 安装 https://cocoapods.org/
（
安装前先升级 ruby
brew install rbenv
rbenv install 3.1.0  # 安装最新版本的 Ruby
rbenv global 3.1.0   # 设置默认 Ruby 版本
rbenv versions # 查看系统中所有 ruby 版本即当前使用的版本
）
使用 rbenv 管理 ruby 版本

# 查看最新 ruby 信息
官网：
https://www.ruby-lang.org/zh_cn/
https://www.ruby-lang.org/en/downloads/

# 查看安装进度
sudo gem install cocoapods -v 
pod install --verbose
