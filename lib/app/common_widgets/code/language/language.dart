abstract class Language {
  final String name;

  const Language(this.name);

  bool containsKeywords(String word);

  bool containsInTypes(String word);

  List<String> get keywords;

  List<String> get inTypes;
}
