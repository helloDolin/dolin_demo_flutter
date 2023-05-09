import 'language.dart';

class DartLanguage extends Language {
  const DartLanguage() : super('Dart');

  static const List<String> _kDartKeywords = [
    'abstract',
    'as',
    'assert',
    'async',
    'await',
    'break',
    'case',
    'catch',
    'class',
    'const',
    'continue',
    'default',
    'deferred',
    'do',
    'dynamic',
    'else',
    'enum',
    'export',
    'external',
    'extends',
    'factory',
    'false',
    'final',
    'finally',
    'for',
    'get',
    'if',
    'implements',
    'import',
    'in',
    'is',
    'library',
    'new',
    'null',
    'operator',
    'part',
    'rethrow',
    'return',
    'set',
    'static',
    'super',
    'switch',
    'sync',
    'this',
    'throw',
    'true',
    'try',
    'typedef',
    'var',
    'void',
    'while',
    'with',
    'yield'
  ];

  static const List<String> _kDartInTypes = ['int', 'double', 'num', 'bool'];

  @override
  List<String> get keywords => _kDartKeywords;

  @override
  List<String> get inTypes => <String>['int', 'double', 'num', 'bool'];

  @override
  bool containsInTypes(String word) => _kDartKeywords.contains(word);

  @override
  bool containsKeywords(String word) => _kDartInTypes.contains(word);
}
