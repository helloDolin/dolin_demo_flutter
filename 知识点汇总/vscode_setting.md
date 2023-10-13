// 可单独对项目进行 setting

// shift + control + p

{
    "workbench.colorTheme": "Default Light+",
    "workbench.iconTheme": "material-icon-theme",
    "files.autoSaveDelay": 3000,
    "dart.runPubGetOnPubspecChanges": "never",
    "editor.acceptSuggestionOnEnter": "on",
    "editor.acceptSuggestionOnCommitCharacter": false,
    // "editor.formatOnSave": true,
    "editor.wordWrap": "on",
    "json.format.enable": true,
    "dart.flutterSdkPath": "/Users/liaoshaolin/dev/flutter_sdk/3.7.8",
    "[python]": {
        "editor.defaultFormatter": "ms-python.black-formatter",
        "editor.formatOnSave": true
    },
    // "python.formatting.provider": "none",
    "[json]": {
        "editor.quickSuggestions": {
            "strings": true
        },
        "editor.suggest.insertMode": "replace",
        "editor.formatOnSave": true,
    },
    "[dart]": {
        "editor.tabSize": 2,
        "editor.insertSpaces": true,
        "editor.detectIndentation": false,
        "editor.suggest.insertMode": "replace",
        "editor.defaultFormatter": "Dart-Code.dart-code",
        "editor.inlayHints.enabled": "offUnlessPressed",
        "editor.formatOnSave": true,
        "editor.codeActionsOnSave": {
            "source.organizeImports": true, 
            "source.fixAll": true 
        },
    },
    "[html]": {
        "editor.suggest.insertMode": "replace",
        // "editor.formatOnType": true
    },
    "hediet.vscode-drawio.resizeImages": null,
    "yaml.schemas": {
        "file:///Users/liaoshaolin/.vscode/extensions/docsmsft.docs-yaml-1.0.1/dist/toc.schema.json": "/toc\\.yml/i"
    },
    // 折叠隐藏文件
    "explorer.fileNesting.enabled": true,
    "explorer.fileNesting.patterns": {
        "pubspec.yaml": "pubspec.lock,pubspec_overrides.yaml,.packages,.flutter-plugins,.flutter-plugins-dependencies,.metadata",
        // "*.dart": "${capture}.g.dart"
    },
    "explorer.confirmDelete": false,
    // 调试三方库
    "dart.debugExternalPackageLibraries": true,
    "dart.debugSdkLibraries": true,
    // 当前活跃括号高亮
    "editor.bracketPairColorization.enabled": true,
    "editor.guides.bracketPairs": "active",
    // 排除文件
    "files.exclude": {
        ".gitignore": true,
        // "analysis_options.yaml": true,
        "test.iml": true,
        // "README.md": true,
        ".idea": true,
        ".dart_tool": true,
        "android": true,
        // ".android": true,
        // ".vscode": true,
        "fonts": true,
        "gradle": true,
        ".gitmodules": true,
        "build.gradle": true,
        "flutter_jtcenter_android.iml": true,
        "flutter_jtcenter.iml": true,
        "gradlew": true,
        "gradlew.bat": true,
        "settings.gradle": true,
        // "ios": true,
        "linux": true,
        // "macos": true,
        "test": true,
        "web": true,
        "windows": true,
        "build": true
    },
    "bracket-pair-colorizer-2.depreciation-notice": true,
    "editor.rulers": [
        80
    ],
    "Codegeex.Privacy": true,
    "Codegeex.EnableExtension": true,
    "Codegeex.DisabledFor": {
        "dart": true
    },
}