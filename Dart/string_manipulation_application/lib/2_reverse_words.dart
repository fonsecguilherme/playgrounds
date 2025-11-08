String reverseWords(String s) {
  String reversePhrase = '';

  List<String> reversedWords = [];

  final splitPhrase = s.split(' ');

  for (var word in splitPhrase) {
    reversePhrase = word.split('').reversed.join();

    reversedWords.add(reversePhrase);
  }
  return reversedWords.join(' ');
}