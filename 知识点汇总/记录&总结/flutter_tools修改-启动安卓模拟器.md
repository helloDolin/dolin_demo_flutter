# flutter_tools 修改，启动安卓模拟器
1. /Users/bd/dev/flutter_sdk/3.10.0/packages/flutter_tools/gradle/flutter.gradle
```dart
    /** Sets the compileSdkVersion used by default in Flutter app projects. */
    static int compileSdkVersion = 34

    /** Sets the minSdkVersion used by default in Flutter app projects. */
    static int minSdkVersion = 20

    /** Sets the targetSdkVersion used by default in Flutter app projects. */
    static int targetSdkVersion = 34
```

2. /Users/bd/dev/flutter_sdk/3.10.0/packages/flutter_tools/templates/module/android/host_app_common/app.tmpl/build.gradle.tmpl
compileSdkVersion 
minSdkVersion
targetSdkVersion 
修改
```dart
// defaultConfig 下添加 multiDexEnabled true
   defaultConfig {
        applicationId "{{androidIdentifier}}.host"
        minSdkVersion 20
        targetSdkVersion 34
        versionCode 1
        versionName "1.0"
        multiDexEnabled true
    }
// dependencies 下添加 implementation "androidx.multidex:multidex:2.0.1"
dependencies {
    implementation project(':flutter')
    implementation fileTree(dir: 'libs', include: ['*.jar'])
    implementation 'androidx.appcompat:appcompat:1.0.2'
    implementation 'androidx.constraintlayout:constraintlayout:1.1.3'
    implementation "androidx.multidex:multidex:2.0.1"
}
```
3. /Users/bd/dev/flutter_sdk/3.10.0/packages/flutter_tools/templates/module/android/host_app_common/app.tmpl/src/main/AndroidManifest.xml.tmpl
```xml
<application 下添加
android:name="androidx.multidex.MultiDexApplication"
```

# 安装 java sdk
brew install java
brew install openjdk

# 可以直接用 sdk 下 bin 执行命令
eg：/Users/bd/dev/flutter_sdk/3.13.7/bin/flutter clean