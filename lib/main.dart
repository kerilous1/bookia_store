import 'package:bookia_store/core/utils/notification_helper.dart';
import 'package:bookia_store/features/saved/presentation/cubit/saved_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/services/service_locator.dart';
import 'core/utils/app_colors.dart';
import 'features/Authentication/data/datasources/auth_local_data_source.dart';
import 'features/Authentication/presentation/cubit/auth_state_cubit.dart';
import 'features/Authentication/presentation/pages/login_page.dart';
import 'features/cart/presentation/cubit/cart_state_cubit.dart';
import 'features/user/presentation/cubit/profile_cubit.dart';
import 'main_layout.dart';


void main() async {
  print('1. ensureInitialized');
  WidgetsFlutterBinding.ensureInitialized();

  print('2. NotificationHelper.init');
  try {
    await NotificationHelper.init();
  } catch (e) {
    print('Notification error: $e');
  }

  print('3. Hive.initFlutter');
  await Hive.initFlutter();
  
  print('4. Hive.openBox cart_box');
  await Hive.openBox('cart_box');
  
  print('5. Hive.openBox wishlist_box');
  await Hive.openBox('wishlist_box');

  // ── Set system UI overlay to match dark luxury theme ──
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.surface,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  print('6. initServiceLocator');
  await initServiceLocator();
  
  print('7. getToken');
  String? token;
  try {
    token = await sl<AuthLocalDataSource>().getToken();
  } catch (e) {
    // Ignore error or delete token if corrupted
    print('Error reading token: $e');
  }
  
  print('8. runApp');
  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>sl<AuthCubit>()),
        BlocProvider(create: (context)=>sl<CartStateCubit>()),
        BlocProvider(create: (context)=>sl<SavedCubit>()),
        BlocProvider(create: (context) => sl<ProfileCubit>()),
      ],
      child: MaterialApp(
        title: 'Bookia Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: const ColorScheme.dark(
            primary: AppColors.primary,
            secondary: AppColors.accent,
            surface: AppColors.surface,
            error: AppColors.error,
          ),
          fontFamily: 'Roboto',
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          snackBarTheme: SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: AppColors.surface,
            contentTextStyle: const TextStyle(color: Colors.white),
          ),
        ),
        home: BlocProvider(
          create: (context) => sl<AuthCubit>(),
          child: isLoggedIn ? const MainLayout() : const LoginPage(),
        ),
      ),
    );
  }
}
