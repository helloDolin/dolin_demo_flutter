document.getElementById('convertButton').addEventListener('click', () => {
    const jsonText = document.getElementById('jsonInput').value.trim();

    try {
        const jsonObject = JSON.parse(jsonText);
        const dartCode = convertJsonToDart(jsonObject, 'Model');
        document.getElementById('output').textContent = dartCode;
    } catch (error) {
        document.getElementById('output').textContent = 'Invalid JSON format.';
    }
});

document.getElementById('copyButton').addEventListener('click', () => {
    const output = document.getElementById('output').textContent;
    if (output) {
        navigator.clipboard.writeText(output).then(() => {
            alert('Dart code copied to clipboard!');
        }, () => {
            alert('Failed to copy the code.');
        });
    }
});

function convertJsonToDart(jsonObject, className) {
    let dartCode = `class ${className} {\n`;

    Object.keys(jsonObject).forEach(key => {
        const value = jsonObject[key];
        const type = inferDartType(value, capitalize(key));
        dartCode += `  final ${type}? ${key};\n`;
    });

    dartCode += `\n  ${className}({\n`;
    Object.keys(jsonObject).forEach(key => {
        dartCode += `    this.${key},\n`;
    });
    dartCode += `  });\n\n`;

    dartCode += `  factory ${className}.fromJson(Map<String, dynamic> json) => ${className}(\n`;
    Object.keys(jsonObject).forEach(key => {
        const value = jsonObject[key];
        const type = inferDartType(value, capitalize(key));
        dartCode += `    ${key}: json['${key}'] as ${type}?,\n`;
    });
    dartCode += `  );\n\n`;

    dartCode += `  Map<String, dynamic> toJson() => {\n`;
    Object.keys(jsonObject).forEach(key => {
        dartCode += `    '${key}': ${key},\n`;
    });
    dartCode += `  };\n`;

    dartCode += `}\n\n`;

    // Handle nested objects
    Object.keys(jsonObject).forEach(key => {
        const value = jsonObject[key];
        if (typeof value === 'object' && !Array.isArray(value) && value !== null) {
            dartCode += convertJsonToDart(value, capitalize(key));
        } else if (Array.isArray(value) && value.length > 0 && typeof value[0] === 'object') {
            dartCode += convertJsonToDart(value[0], capitalize(key));
        }
    });

    return dartCode;
}

function inferDartType(value, className) {
    if (typeof value === 'string') return 'String';
    if (typeof value === 'number') return Number.isInteger(value) ? 'int' : 'double';
    if (typeof value === 'boolean') return 'bool';
    if (Array.isArray(value)) {
        if (value.length > 0) {
            return `List<${inferDartType(value[0], className)}>`;
        }
        return 'List<dynamic>';
    }
    if (typeof value === 'object' && value !== null) {
        return className;  // Assume this is a nested object, create a new class for it.
    }
    return 'dynamic';
}

function capitalize(str) {
    return str
        .split('_') // 以下划线分割字符串
        .map(word => word.charAt(0).toUpperCase() + word.slice(1)) // 每个单词首字母大写
        .join(''); // 将所有单词拼接成一个字符串
}

