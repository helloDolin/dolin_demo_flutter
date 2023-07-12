# dolin_demo_flutter

## 麻雀虽小，五脏俱全
支持主题切换、国际化，完善的 http 请求，完善的日志系统


## 目的
Flutter 学习、总结、提高

若有刚好需要的功能，拿之即用 😄😄😄


## 截图
![image](https://raw.githubusercontent.com/helloDolin/dolin_demo_flutter/main/screenshot/light.png)
![image](https://raw.githubusercontent.com/helloDolin/dolin_demo_flutter/main/screenshot/dark.png)
![image](https://raw.githubusercontent.com/helloDolin/dolin_demo_flutter/main/screenshot/english.png)

### ps:
以上截图使用 python 脚本拼接，源码在 screenshot 下 merge_img.py

## 简介
* 项目主要使用 GetX 进行状态管理、路由跳转、依赖注入
* 使用 GetX cli 创建核心页面
* app目录简介：（apis、data、modules 均按照 首页、动漫、联系、我的划分使之更清晰）
    * apis 接口请求封装
    * common_widgets 公用组件
    * constants 常量（图片地址、icon、主题、颜色）
    * data 模型
    * https http 请求
    * modules 业务模块
    * routes GetX 自动生成
    * service 各种服务
    * util 各种工具
    * 知识点汇总（快捷键、美团大佬分享的 Flutter 实战、面试题、VSCode 使用设置）
    

## 使用版本（尽量使用最新 stable sdk） flutter --version：
Flutter 3.7.10 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 4b12645012 (3 days ago) • 2023-04-03 17:46:48 -0700
Engine • revision ec975089ac
Tools • Dart 2.19.6 • DevTools 2.20.1

### 2023年07月12日 升级
Flutter 3.10.5 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 796c8ef792 (4 weeks ago) • 2023-06-13 15:51:02 -0700
Engine • revision 45f6e00911
Tools • Dart 3.0.5 • DevTools 2.23.1

## flutter 性能优化
https://juejin.cn/post/7145730792948252686  from:58

## 使用到的接口定义文档
https://github.com/iiiiiii1/douban-imdb-api