abstract class Language {
  const Language(this.name);
  final String name;

  bool containsKeywords(String word);

  bool containsInTypes(String word);

  List<String> get keywords;

  List<String> get inTypes;
}
