bool anyUserUnder18(Iterable<User> users) {
  // TODO: Implement the anyUserUnder18 function.
  return users.any((element) => element.age <= 18);
}

bool everyUserOver13(Iterable<User> users) {
  // TODO: Implement the everyUserOver13 function.
  return users.every((element) => element.age > 13);
}

class User {
  final String name;
  final int age;

  User(
    this.name,
    this.age,
  );
}

// The following code is used to provide feedback on your solution.
// There is no need to read or modify it.
void main() {
  final users = [
    User('Alice', 21),
    User('Bob', 17),
    User('Claire', 52),
    User('David', 14),
  ];

  try {
    final out = anyUserUnder18(users);
    if (!out) {
      print('Looks like `anyUserUnder18` is wrong. Keep trying!');
      return;
    }
  } on UnimplementedError {
    print(
      'Tried running `anyUserUnder18`, but received an error. '
      'Did you implement the function?',
    );
    return;
  } catch (e) {
    print('Tried running `anyUserUnder18`, but received an exception: $e');
    return;
  }

  try {
    // with only one user older than 18, should be false
    final out = anyUserUnder18([User('Alice', 21)]);
    if (out) {
      print(
          'Looks like `anyUserUnder18` is wrong. What if all users are over 18?');
      return;
    }
  } on UnimplementedError {
    print(
      'Tried running `anyUserUnder18`, but received an error. '
      'Did you implement the function?',
    );
    return;
  } catch (e) {
    print(
      'Tried running `anyUserUnder18([User("Alice", 21)])`, '
      'but received an exception: $e',
    );
    return;
  }

  try {
    final out = everyUserOver13(users);
    if (!out) {
      print(
        'Looks like `everyUserOver13` is wrong. '
        'There are no users under 13!',
      );
      return;
    }
  } on UnimplementedError {
    print(
      'Tried running `everyUserOver13`, but received an error. '
      'Did you implement the function?',
    );
    return;
  } catch (e) {
    print(
      'Tried running `everyUserOver13`, '
      'but received an exception: $e',
    );
    return;
  }

  try {
    final out = everyUserOver13([User('Dan', 12)]);
    if (out) {
      print(
        'Looks like `everyUserOver13` is wrong. '
        'There is at least one user under 13!',
      );
      return;
    }
  } on UnimplementedError {
    print(
      'Tried running `everyUserOver13`, but received an error. '
      'Did you implement the function?',
    );
    return;
  } catch (e) {
    print(
      'Tried running `everyUserOver13([User(\'Dan\', 12)])`, '
      'but received an exception: $e',
    );
    return;
  }

  print('Success. All tests passed!');
}
