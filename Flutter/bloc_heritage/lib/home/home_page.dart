// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_heritage/home/cubit/home_cubit.dart';
import 'package:bloc_heritage/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeCubit get cubit => context.read<HomeCubit>();

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          switch (state) {
            case InitialHomeState():
              return BodyHomeWidget(
                title: state.appbarTitle!,
                cubit: cubit,
                appbarType: state.type.name,
              );
            case LoadingHomeState():
              return BodyHomeWidget(
                title: state.appbarTitle!,
                cubit: cubit,
                appbarType: state.type.name,
              );

            case SuccessHomeState():
              return BodyHomeWidget(
                title: state.appbarTitle!,
                cubit: cubit,
                appbarType: state.type.name,
              );

            case ErrorHomeState():
              return BodyHomeWidget(
                title: state.appbarTitle!,
                cubit: cubit,
                appbarType: state.type.name,
              );
          }
        },
      );
}

class BodyHomeWidget extends StatelessWidget {
  final String title;
  final HomeCubit cubit;
  final String appbarType;

  const BodyHomeWidget({
    super.key,
    required this.title,
    required this.cubit,
    required this.appbarType,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(appbarType),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () => cubit.fetchData(),
                    label: Icon(Icons.add),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => cubit.errorData(),
                    label: Icon(Icons.error),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
