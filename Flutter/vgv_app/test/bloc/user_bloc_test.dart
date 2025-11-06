import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vgv_app/bloc/user_bloc.dart';
import 'package:vgv_app/bloc/user_event.dart';
import 'package:vgv_app/bloc/user_state.dart';
import 'package:vgv_app/model/user_model.dart';
import 'package:vgv_app/user_repository.dart';

class MockUserRepository extends Mock implements UserRepository {}

late UserRepository _userRepository;

void main() {
  setUp(() {
    _userRepository = MockUserRepository();
  });

  //TODO: faltando incluir a chamada do repository
  blocTest<UserBloc, UserState>(
    'emits [MyState] when MyEvent is added.',
    build: () => UserBloc(repository: _userRepository),
    act: (bloc) => bloc.add(FetchUserEvent()),
    expect: () => <UserState>[
      UserLoading(),
      UserLoaded(
        users: [
          UserModel(
            login: 'login',
            avatarUrl: 'avatarUrl',
            htmlUrl: 'htmlUrl',
            type: 'type',
          ),
          UserModel(
            login: 'login2',
            avatarUrl: 'avatarUrl2',
            htmlUrl: 'htmlUrl2',
            type: 'type2',
          ),
        ],
      ),
    ],
  );
}
