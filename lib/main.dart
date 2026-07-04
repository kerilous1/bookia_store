import 'package:bookia_store/features/Authentication/data/datasources/auth_local_data_source_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/services/service_locator.dart';
import 'features/Authentication/data/datasources/auth_local_data_source.dart';
import 'features/Authentication/data/datasources/auth_remote_data_source_impl.dart';
import 'features/Authentication/data/repositories/auth_repository_impl.dart';
import 'features/Authentication/domain/usecases/login_usecase.dart';
import 'features/Authentication/domain/usecases/register_usecase.dart';
import 'features/Authentication/presentation/cubit/auth_state_cubit.dart';
import 'features/Authentication/presentation/pages/login_page.dart';
import 'main_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  final String? token=await sl<AuthLocalDataSource>().getToken();
  runApp(MyApp(isLoggedIn: token!=null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookia Store',
      home: BlocProvider(
        create: (context) =>sl<AuthCubit>(),
        child: isLoggedIn ? const MainLayout() : const LoginPage(),
      ),
    );
  }
}

