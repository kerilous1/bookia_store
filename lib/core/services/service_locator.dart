import 'package:bookia_store/features/Authentication/domain/usecases/login_usecase.dart';
import 'package:bookia_store/features/Authentication/presentation/cubit/auth_state_cubit.dart';
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
}