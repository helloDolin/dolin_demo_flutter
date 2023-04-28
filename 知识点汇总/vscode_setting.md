// 可单独对项目进行 setting
// shift + control + p

{
    // IDE 颜色主题
    "workbench.colorTheme": "Default Light+",
    // "dart.flutterSdkPath": "C:\\dev\\3.7.11",
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
        "source.organizeImports": true, // 组织 import
        "source.fixAll": true // 自动修复
    },
    "editor.wordWrap": "on",
    "json.format.enable": true,
    "window.zoomLevel": 1,
    // 折叠文件
    "explorer.fileNesting.enabled": true,
    "explorer.fileNesting.patterns": {
        "pubspec.yaml": "pubspec.lock,pubspec_overrides.yaml,.packages,.flutter-plugins,.flutter-plugins-dependencies,.metadata,hs_err_pid20052.log,hs_err_pid19516.log,hs_err_pid16240.log,flutter_native_splash.yaml,common_tips.md,analysis_options.yaml,README.md,.gitignore",
        // "*.dart": "${capture}.g.dart"
    },
    // 排除文件
    "files.exclude": {
        ".dart_tool": true,
        "android": true,
        "ios": true,
        "linux": true,
        "macos": true,
        "test": true,
        "web": true,
        "windows": true,
        "build": true
    }
}
