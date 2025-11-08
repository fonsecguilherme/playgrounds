String capitalizeWords(String s) {
  final splitPhrase = s.split(' ');

  List<String> newPhrase = [];

  print(splitPhrase);

  for (var word in splitPhrase) {
    final newWord = word.replaceRange(0, 1, word[0].toUpperCase());

    newPhrase.add('$newWord ');
  }

  return newPhrase.join();
}