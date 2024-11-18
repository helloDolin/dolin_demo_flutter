# 版本号
安卓 + 号前为 version name + 后 为 version number，有时候会校验 version number
version: 1.1.0+1101 # +号面逻辑：version 去掉点缀build号，eg：1.1.0 那么 + 后为 110

# mac 安装 apk
环境变量配置,eg:
export PATH="/Users/bd/Library/Android/sdk/platform-tools:$PATH"

安装 eg：
adb install /Users/bd/Downloads/Postern_v3.1.3_apkpure.com.apk
使用 Android Debug Bridge（ADB）来安装一个 APK 文件到 Android 设备上，是一个用于 Android 设备调试和开发的命令行工具

# 信任 JDK 路径：
sudo xattr -r -d com.apple.quarantine /Users/bd/dev/jdk/openjdk-21.0.1

# jenv
安装 jenv： 
brew install jenv
然后，确保 jenv 正常工作。将以下内容添加到你的 ~/.zshrc
export PATH="$HOME/.jenv/bin:$PATH"
当前 shell 中重新加载 jenv 配置
eval "$(jenv init -)"

安装 jdk17 ：
brew install openjdk@17

手动下载：
https://www.oracle.com/java/technologies/downloads/#jdk21-mac

解压到指定目录
tar -xvzf jdk-21_macos-aarch64_bin.tar.gz -C /path/to/your/desired/directory


清除 Gradle 缓存：
sudo rm -rf ~/.gradle/caches/

jenv 添加 jdk
jenv add /Users/bd/dev/jdk/21.0.1
sudo jenv add /Users/bd/dev/jdk/openjdk@21/21.0.3
jenv add /opt/homebrew/opt/openjdk@17 (brew 方式安装的位置)
jenv add /Users/bd/dev/jdk/jdk-19.0.2.jdk/Contents/Home
jenv add /Users/bd/dev/jdk/jdk-21.0.5.jdk/Contents/Home

一直提示 ln: /Users/bd/.jenv/versions/oracle64-19.0.2: No such file or directory
解决：eval "$(jenv init -)"

jenv versions
jenv global 17.0
java --version

卸载：
brew uninstall jenv
rm -rf .jenv
注释掉 zshrc 关于 jenv 的东西
输入 jenv
zsh: command not found: jenv
即代表成功

## 查看 java 可执行文件位置
which java


# 给脚本添加执行权限
chmod +x script.sh
或
chmod 777 script.sh

7：读、写和执行权限
6：读和写权限
5：读和执行权限
4：只读权限
3：写和执行权限
2：写权限
1：执行权限
0：无权限


# flutter 模块依赖
build.gradle 下
implementation 'com.example.flutter_module:flutter_release:1703057505_shaolin_prop'

# 包名修改
android/app/build.gradle
defaultConfig {
    applicationId "com.aiear.xxx"
}

# 获取公钥、MD5

keytool -list -rfc -keystore key.jks -alias poker -storepass bdpoker

https://www.pgyer.com/8xnmLh

# brew 安装 jdk
安装 jdk 21

方式一，brew 安装
brew install openjdk@21   

方式二，手动，比如 brew 安装出来的是 21.0.5，但是我需要 21.0.1 
https://jdk.java.net/archive/
去这里下载对应的版本

修改环境变量
export JAVA_HOME=/Users/bd/dev/jdk/jdk-21.0.1.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH

export JAVA_HOME=/Users/bd/dev/jdk/jdk-21.0.5.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH

# 解决 poker 打包问题
1. 复制打包机上的 jdk 包到 jdk 目录下，然后加入到 jenv
jenv add /Users/bd/dev/jdk/jdk-19.0.2.jdk/Contents/Home
2. jenv global 19
✅ 解决


# hotdog
在 package 目录 执行 jenv local 17.0.13
cat .java-version
jenv add /Users/bd/dev/jdk/jdk-21.0.1.jdk/Contents/Home
jenv add /opt/homebrew/Cellar/openjdk@21/21.0.5/libexec/openjdk.jdk/Contents/Home
❌ 未解决


