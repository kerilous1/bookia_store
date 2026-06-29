import 'package:bookia_store/features/Authentication/domain/usecases/login_usecase.dart';
import 'package:bookia_store/features/Authentication/presentation/cubit/auth_state_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/Authentication/data/datasources/auth_remote_data_source.dart';
import '../../features/Authentication/data/datasources/auth_remote_data_source_impl.dart';
import '../../features/Authentication/data/repositories/auth_repository_impl.dart';
import '../../features/Authentication/domain/repositories/auth_repository.dart';
import '../../features/Authentication/domain/usecases/register_usecase.dart';

final sl=GetIt.instance;

void initServiceLocator(){
  //just for one time
  sl.registerLazySingleton<Dio>(()=>Dio());

  //data source
  sl.registerLazySingleton<AuthRemoteDataSource>(()=>AuthRemoteDataSourceImpl(sl()));

  //Repository
  sl.registerLazySingleton<AuthRepository>(()=>AuthRepositoryImpl(sl()));

  //use cases
  sl.registerLazySingleton(()=>LoginUsecase(sl()));
  sl.registerLazySingleton(()=>RegisterUsecase(sl()));

  //cubit
  sl.registerFactory<AuthCubit>(
      ()=>AuthCubit(
          loginUseCase: sl(),
          registerUseCase: sl()
      )
  );
}