# mac 安装 apk
环境变量配置,eg:
export PATH="/Users/bd/Library/Android/sdk/platform-tools:$PATH"

安装 eg：
adb install /Users/bd/Downloads/Postern_v3.1.3_apkpure.com.apk

# jenv
jenv add /Library/Java/JavaVirtualMachines/jdk-19.0.2.jdk/Contents/Home
jenv versions
jenv global 19.0
java --version

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