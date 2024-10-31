import 'package:bloc/bloc.dart';
import 'package:bloc_blu_testing2/bl/home/home_page_imp.dart';

import '../../repository/github_repository.dart';

//! 1 opção
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageState.initial());

  final repository = GithubRepostory();

  Future<void> fetchData() async {
    emit(HomePageState.loading());

    try {
      final result = await repository.getUsers();
      print(result);

      if (result.isNotEmpty) {
        emit(HomePageState.sucess(users: result));
      }
    } catch (e) {
      emit(HomePageState.error(error: HomePageErrorType.fetchData));
    }
  }
}

// class HomePageCubit extends Cubit<HomePageState> {
//   HomePageCubit()
//       : super(const HomePageState(
//           status: HomePageStatus.initial,
//         ));

//   final repository = GithubRepostory();

//   Future<void> fetchData() async {
//     emit(state.copyWith(status: HomePageStatus.loading));

//     try {
//       final result = await repository.getUsers();
//       // log('$result');

//       if (result.isNotEmpty) {
//         emit(state.copyWith(
//           status: HomePageStatus.success,
//           users: result,
//         ));
//       }
//     } catch (e, stacktrace) {
//       log('error: $e');
//       log('ST: $stacktrace');
//       emit(state.copyWith(
//         status: HomePageStatus.failure,
//         error: HomePageErrorType.fetchData,
//       ));
//       // emit(state.copyWith(status: HomePageStatus.initial));
//     }
//   }
// }

// class HomePageCubit extends Cubit<HomePageState> {
//   HomePageCubit()
//       : super(const HomePageState(
//           status: HomePageStatus.initial,
//         ));

//   final repository = ViaCepRepository();

//   Future<void> fetchData() async {
//     emit(state.copyWith(status: HomePageStatus.loading));

//     final result = await repository.fetchAddress();
//     print(result);

//     if (result != null) {
//       emit(state.copyWith(
//         status: HomePageStatus.success,
//         address: result,
//       ));
//     } else {
//       throw Exception('Deu ruim galera');
//     }
//   }
// }
