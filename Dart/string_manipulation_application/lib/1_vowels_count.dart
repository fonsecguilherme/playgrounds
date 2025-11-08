int vowelsCount(String word) {
  final vowels = ['a', 'e', 'i', 'o', 'u'];
  final splitWord = word.toLowerCase().split('');
  Set<String> result = {};

  for (var letter in splitWord) {
    if (vowels.contains(letter)) {
      result.add(letter);
    }
  }

  return result.length;
}
