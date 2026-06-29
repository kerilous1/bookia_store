import 'package:bookia_store/features/Authentication/data/datasources/auth_remote_data_source_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource);

  //implement login function
  @override
  Future<Either<Failure,UserEntity>>login({
    required String email,
  required String password,
}) async {

    try{
      final user=await _authRemoteDataSource.login(
          email: email,
          password: password
      );
      return Right(user);
    }catch(e){
      if(e is DioException) {
        final response=e.response?.data;
        if(response!=null&&response['errors']!=null){
          final firstError=response['errors'].values.first[0];
          return Left(ServerFailure(firstError.toString()));
        }
        return Left(ServerFailure(e.response?.data['message']??'Something went wrong'));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  //implement register function
  @override
  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword
  }) async {
    try{
      final user=await _authRemoteDataSource.register(
          name: name,
          email: email,
          password: password,
          confirmPassword: confirmPassword
      );
      return Right(user);
    }catch(e){
      if(e is DioException) {
        final response=e.response?.data;
        if(response!=null&&response['errors']!=null){
          final firstError=response['errors'].values.first[0];
          return Left(ServerFailure(firstError.toString()));
        }
        return Left(ServerFailure(e.response?.data['message']??'Something went wrong'));
      }
      return Left(ServerFailure(e.toString()));
    }

  }

}