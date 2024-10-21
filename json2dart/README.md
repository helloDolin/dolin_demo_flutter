# Chrome 插件目录结构
json2dart/
|-- manifest.json
|-- background.js
|-- popup.html
|-- popup.js
|-- style.css

# manifest.json
manifest.json 是 Chrome 插件的配置文件。定义插件的基础信息和所需的权限：

# background.js
background.js 可以用来进行初始化或其他后台任务。如果不需要后台任务，可以保持空文件。

# popup.js
处理 JSON 转 Dart 模型的逻辑，并将结果显示在 pre 标签中：


