import 'package:bookia_store/features/Authentication/domain/usecases/login_usecase.dart';
import 'package:bookia_store/features/Authentication/presentation/cubit/auth_state_cubit.dart';
import 'package:bookia_store/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:bookia_store/features/cart/presentation/cubit/cart_state_cubit.dart';
import 'package:bookia_store/features/home/data/datasources/home_remote_data_source.dart';
import 'package:bookia_store/features/home/data/repositories/home_repository_impl.dart';
import 'package:bookia_store/features/home/domain/repositories/home_repository.dart';
import 'package:bookia_store/features/home/domain/usecases/get_best_sellers_usecase.dart';
import 'package:bookia_store/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:bookia_store/features/home/domain/usecases/get_new_arrivals_usecase.dart';
import 'package:bookia_store/features/home/domain/usecases/get_sliders_usecase.dart';
import 'package:bookia_store/features/home/domain/usecases/search_products_usecase.dart';
import 'package:bookia_store/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia_store/features/home/presentation/cubit/search_cubit.dart';
import 'package:bookia_store/features/user/data/datasources/profile_remote_data_source.dart';
import 'package:bookia_store/features/user/data/datasources/profile_remote_data_source_imp.dart';
import 'package:bookia_store/features/user/data/repositories/profile_repository_impl.dart';
import 'package:bookia_store/features/user/domain/repositories/profile_repository.dart';
import 'package:bookia_store/features/user/domain/usecases/delete_account_use_case.dart';
import 'package:bookia_store/features/user/domain/usecases/get_profile_use_case.dart';
import 'package:bookia_store/features/user/domain/usecases/update_profile_use_case.dart';
import 'package:bookia_store/features/user/presentation/cubit/profile_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../features/Authentication/data/datasources/auth_local_data_source.dart';
import '../../features/Authentication/data/datasources/auth_local_data_source_impl.dart';
import '../../features/Authentication/data/datasources/auth_remote_data_source.dart';
import '../../features/Authentication/data/datasources/auth_remote_data_source_impl.dart';
import '../../features/Authentication/data/repositories/auth_repository_impl.dart';
import '../../features/Authentication/domain/repositories/auth_repository.dart';
import '../../features/Authentication/domain/usecases/register_usecase.dart';
import '../../features/Authentication/domain/usecases/resend_verify_code_usecase.dart';
import '../../features/Authentication/domain/usecases/verify_email_usecase.dart';
import '../../features/cart/data/cart_repository_impl.dart';
import '../../features/cart/domain/repositories/cart_repository.dart';
import '../../features/home/data/datasources/home_remote_data_source_impl.dart';
import '../../features/saved/presentation/cubit/saved_cubit.dart';
import '../network/api_constants.dart';
final sl=GetIt.instance;

Future<void> initServiceLocator()async {

  sl.registerLazySingleton<FlutterSecureStorage>(()=>const FlutterSecureStorage());

  //just for one time
  sl.registerLazySingleton<Dio>(
          (){
        final dio=Dio(
          BaseOptions(
              baseUrl: ApiConstants.baseurl
          ),
        );
        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options,handler) async {
              final token=await sl<AuthLocalDataSource>().getToken();
              if(token!=null){
                options.headers['Authorization']='Bearer $token';
              }
              return handler.next(options);
            },
          ),
        );
        return dio;
      }
  );


//Auth Feature

  //data source
  sl.registerLazySingleton<AuthRemoteDataSource>(()=>AuthRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(()=>AuthLocalDataSourceImpl(sl()));

  //Repository
  sl.registerLazySingleton<AuthRepository>(
      ()=>AuthRepositoryImpl(
          authRemoteDataSource: sl(),
          authLocalDataSource: sl(),
      )
  );

  //use cases
  sl.registerLazySingleton(()=>LoginUsecase(sl()));
  sl.registerLazySingleton(()=>RegisterUsecase(sl()));
  sl.registerLazySingleton(()=>VerifyEmailUsecase(sl()));
  sl.registerLazySingleton(()=>ResendVerifyCodeUseCase(sl()));

  //cubit
  sl.registerFactory<AuthCubit>(
      ()=>AuthCubit(
          loginUseCase: sl(),
          registerUseCase: sl(),
          verifyEmailUsecase: sl(),
        resendVerifyCodeUseCase: sl(),
        authRepository: sl(),
      )
  );


//Home Feature

  //data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
      ()=>HomeRemoteDataSourceImpl(sl()),
  );

  //repositories
  sl.registerLazySingleton<HomeRepository>(
      ()=>HomeRepositoryImpl(sl()),
  );

  //use cases
  sl.registerLazySingleton(()=>GetSlidersUsecase(sl()));//slider usecase
  sl.registerLazySingleton(()=>GetCategoriesUsecase(sl()));//category usecase
  sl.registerLazySingleton(()=>GetBestSellersUsecase(sl()));//best sellers usecase
  sl.registerLazySingleton(()=>GetNewArrivalsUsecase(sl()));//new arrivals usecase
  sl.registerLazySingleton(()=>SearchProductsUsecase(sl()));//search usecase

  // home cubits
  sl.registerFactory(
      ()=>HomeCubit(
          getSlidersUsecase: sl(),
          getCategoriesUsecase: sl(),
          getNewArrivalsUsecase: sl(),
          getBestSellersUsecase: sl(),
      )
  );
  //search cubit
  sl.registerFactory(
      ()=>SearchCubit(sl())
  );

//cart & saved feature
sl.registerLazySingleton<CartRemoteDataSource>(()=>CartRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton(() => CartStateCubit(cartRepository: sl()));

//saved feature
sl.registerLazySingleton(
    ()=>SavedCubit()
);

///profile feature
  //cbit
  sl.registerFactory(()=>ProfileCubit(
    getProfileUseCase: sl(),
    updateProfileUseCase: sl(),
    deleteAccountUseCase: sl(),
    updatePasswordUseCase: sl(),
  ));

  //use cases
  sl.registerLazySingleton(()=>GetProfileUseCase(sl()));
  sl.registerLazySingleton(()=>UpdateProfileUseCase(sl()));
  sl.registerLazySingleton(()=>DeleteAccountUseCase(sl()));
  sl.registerLazySingleton(()=>UpdateProfileUseCase(sl()));

  //repositories
  sl.registerLazySingleton<ProfileRepository>(
      ()=>ProfileRepositoryImpl(sl()),
  );

  //Data source
  sl.registerLazySingleton<ProfileRemoteDataSource>(
      ()=>ProfileRemoteDataSourceImp(dio: sl()),
  );



}