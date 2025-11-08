bool isPalindrome(String s) {
  final List<String> specialCharacters = [
    ',',
    '.',
    '!',
    '?',
    '\'',
    '"',
    ':',
    ' ',
  ];
  final cleanList = <String>[];

  final splitList = s.toLowerCase().split('');

  for (var char in splitList) {
    if (!specialCharacters.contains(char)) {
      cleanList.add(char);
    }
  }

  print(splitList);
  print(cleanList);

  return splitList == cleanList;
}