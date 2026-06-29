import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/Authentication/data/datasources/auth_remote_data_source_impl.dart';
import 'features/Authentication/data/repositories/auth_repository_impl.dart';
import 'features/Authentication/domain/usecases/login_usecase.dart';
import 'features/Authentication/domain/usecases/register_usecase.dart';
import 'features/Authentication/presentation/cubit/auth_state_cubit.dart';
import 'features/Authentication/presentation/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookia Store',
      home: BlocProvider(
        create: (context) {
          final dio = Dio();

          //data lear
          final remoteDataSource = AuthRemoteDataSourceImpl(dio);
          final authRepository = AuthRepositoryImpl(remoteDataSource);

          //domain lear
          final loginUseCase = LoginUsecase(authRepository);
          final registerUseCase = RegisterUsecase(authRepository);

          //
          return AuthCubit(
            loginUseCase: loginUseCase,
            registerUseCase: registerUseCase,
          );
        },
        child: const LoginPage(),
      ),
    );
  }
}

