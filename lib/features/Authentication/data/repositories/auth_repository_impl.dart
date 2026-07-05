import 'package:bookia_store/features/Authentication/data/datasources/auth_local_data_source.dart';
import 'package:bookia_store/features/Authentication/data/datasources/auth_remote_data_source_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource
});

  //implement login function
  @override
  Future<Either<Failure,UserEntity>>login({
    required String email,
  required String password,
}) async {

    try{
      final user=await authRemoteDataSource.login(
          email: email,
          password: password
      );

      await authLocalDataSource.saveToken(user.token);
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
      final user=await authRemoteDataSource.register(
          name: name,
          email: email,
          password: password,
          confirmPassword: confirmPassword
      );

      await authLocalDataSource.saveToken(user.token);
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

  //implement verify email function
  @override
  Future<Either<Failure,Unit>> verifyEmail({
    required String email,
    required String otp,
}) async {
    try{
      await authRemoteDataSource.verifyEmail(
          email: email,
          otp: otp
      );

      return Right(unit);
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

  //implement resend verify code function
  @override
  Future<Either<Failure, Unit>> resendVerifyCode() async {
    try {
      await authRemoteDataSource.resendVerifyCode();
      return const Right(unit);
    } catch (e) {
      if (e is DioException) {
        final response = e.response?.data;
        if (response != null && response['errors'] != null) {
          final firstError = response['errors'].values.first[0];
          return Left(ServerFailure(firstError.toString()));
        }
        return Left(ServerFailure(e.response?.data['message'] ?? 'Something went wrong'));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  //implement logout function
  @override
  Future<Either<Failure, Unit>> logout() async {
    try{
      await authLocalDataSource.deleteToken();
      return const Right(unit);
    }catch (e){
      return Left(ServerFailure(e.toString()));
    }
  }


}