import 'package:bloc_heritage/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialHomeState(appbarTitle: 'Estado inicial'));

  Future<void> fetchData() async {
    emit(LoadingHomeState(appbarTitle: 'Carregando...'));

    await Future.delayed(Duration(seconds: 3));

    emit(SuccessHomeState(appbarTitle: 'Deu bom papai'));
  }

  Future<void> errorData() async {
    emit(LoadingHomeState(appbarTitle: 'Carregando...'));

    await Future.delayed(Duration(seconds: 3));

    emit(ErrorHomeState(appbarTitle: 'Deu Ruim papai'));
  }
}
