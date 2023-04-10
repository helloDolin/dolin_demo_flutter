输入命令：
cmd + shift + p 

```json
{
    // IDE 颜色主题
    "workbench.colorTheme": "Default Light+",
    "dart.flutterSdkPath": "/Users/liaoshaolin/dev/flutter_sdk/3.3.10",
    "workbench.iconTheme": "material-icon-theme",
    "files.autoSaveDelay": 3000,
    "dart.runPubGetOnPubspecChanges": "never",
    // off 为： 提示补全代码，只能按 Tab 完成（防止按 Enter 自动补全括号的烦恼）
    "editor.acceptSuggestionOnEnter": "on",
    // 关闭自动补全括号
    "editor.acceptSuggestionOnCommitCharacter": false,
    // 可在源码上打断点
    "debug.allowBreakpointsEverywhere": true,
    "dart.debugExternalLibraries": true,
    "dart.debugSdkLibraries": false,
    "explorer.confirmDelete": false,
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
        "source.fixAll": true // 自动修复
    },
     // 折叠隐藏文件
    "explorer.fileNesting.enabled": true,
    "explorer.fileNesting.patterns": {
        "pubspec.yaml": "pubspec.lock,pubspec_overrides.yaml,.packages,.flutter-plugins,.flutter-plugins-dependencies,.metadata",
        // "*.dart": "${capture}.g.dart"
    }
     "[python]": {
        "editor.formatOnType": true
    },

}
```