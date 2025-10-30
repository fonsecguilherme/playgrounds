import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:vgv_app/bloc/user_bloc.dart';
import 'package:vgv_app/bloc/user_event.dart';
import 'package:vgv_app/bloc/user_state.dart';
import 'package:vgv_app/home_page.dart';
import 'package:vgv_app/model/user_model.dart';

class MockUserBloc extends MockBloc<UserEvent, UserState> implements UserBloc {}

late UserBloc _userBloc;

void main() {
  setUp(() {
    _userBloc = MockUserBloc();

    when(() => _userBloc.state).thenReturn(UserInitial());
    whenListen(_userBloc, Stream<UserState>.fromIterable([UserInitial()]));
  });

  testWidgets('Should fin inital widget', (tester) async {
    await _createWidget(tester);

    expect(find.text('Welcome!'), findsOneWidget);
  });

  testWidgets('Should find loading widget', (tester) async {
    whenListen(
      _userBloc,
      Stream<UserState>.fromIterable([UserLoading()]),
      initialState: UserInitial(),
    );

    await _createWidget(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should find error widget', (tester) async {
    whenListen(
      _userBloc,
      Stream<UserState>.fromIterable([UserError('Failed to fetch user data')]),
      initialState: UserInitial(),
    );

    await _createWidget(tester);

    expect(find.text('Failed to fetch user data'), findsOneWidget);
  });

  testWidgets('Should find loaded state', (tester) async {
    final user1 = UserModel(
      login: 'login',
      avatarUrl: 'avatarUrl',
      htmlUrl: 'htmlUrl',
      type: 'type',
    );
    final user2 = UserModel(
      login: 'login',
      avatarUrl: 'avatarUrl',
      htmlUrl: 'htmlUrl',
      type: 'type',
    );

    whenListen(
      _userBloc,
      Stream<UserState>.fromIterable([
        UserLoaded(users: [user1, user2]),
      ]),
      initialState: UserInitial(),
    );

    await mockNetworkImages(() async => _createWidget(tester));

    expect(find.byKey(Key('UserLoadedKey')), findsOneWidget);
  });
}

Future<void> _createWidget(WidgetTester tester) async {
  await tester.pumpWidget(
    BlocProvider(
      create: (context) => _userBloc,
      child: MaterialApp(home: const HomePage()),
    ),
  );
  await tester.pump();
}
