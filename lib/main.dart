import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/service_locator.dart';
import 'features/Authentication/data/datasources/auth_remote_data_source_impl.dart';
import 'features/Authentication/data/repositories/auth_repository_impl.dart';
import 'features/Authentication/domain/usecases/login_usecase.dart';
import 'features/Authentication/domain/usecases/register_usecase.dart';
import 'features/Authentication/presentation/cubit/auth_state_cubit.dart';
import 'features/Authentication/presentation/pages/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();
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
        create: (context) =>sl<AuthCubit>(),
        child: const LoginPage(),
      ),
    );
  }
}

