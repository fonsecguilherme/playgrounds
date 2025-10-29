import 'package:bloc/bloc.dart';
import 'package:vgv_app/bloc/user_event.dart';
import 'package:vgv_app/bloc/user_state.dart';
import 'package:vgv_app/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<FetchUserEvent>(_onFetchUserEvent);
  }

  final reposiory = UserRepository();

  Future<void> _onFetchUserEvent(
    FetchUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final users = await reposiory.fetchUsers();

      emit(UserLoaded(users: users));
    } catch (e) {
      emit(UserError('Failed to fetch user data'));
    }
  }
}
