main() {
  print(weekdayOrder());
}

List<String> weekdayOrder() {
  List<String> weekDays = [
    'Segunda',
    'Terça',
    'Quarta',
    'Quinta',
    'Sexta',
    'Sábado',
    'Domingo',
  ];
  DateTime now = DateTime.now();

  int today = now.weekday;

  List<String> newList = [];

  for (int i = today - 1; i < weekDays.length; i++) {
    newList.add(weekDays[i]);
  }

  for (int i = 0; i < today - 1; i++) {
    newList.add(weekDays[i]);
  }

  return newList;
}
