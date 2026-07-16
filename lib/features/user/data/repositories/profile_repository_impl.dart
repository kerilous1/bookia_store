import 'package:bookia_store/core/errors/failures.dart';
import 'package:bookia_store/features/Authentication/domain/entities/user_entity.dart';
import 'package:bookia_store/features/user/data/datasources/profile_remote_data_source.dart';
import 'package:bookia_store/features/user/domain/repositories/profile_repository.dart';
import 'package:bookia_store/features/user/domain/usecases/change_password_use_case.dart';
import 'package:bookia_store/features/user/domain/usecases/update_profile_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> getProfile() async {
    try {
      final userModel = await remoteDataSource.getProfile();
      return Right(userModel);
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
    cast(e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateProfile(
    UpdateProfileParams params,
  ) async {
    try {
      final updatedUserModel = await remoteDataSource.updateProfile(params);
      return Right(updatedUserModel);
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProfile() async {
    try {
      await remoteDataSource.deleteProfile();
      return const Right(unit);
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePassword(
    ChangePasswordParams params,
  ) async {
    try {
      await remoteDataSource.updatePassword(params);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

}
