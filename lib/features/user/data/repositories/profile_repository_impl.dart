

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/usecases/change_password_use_case.dart';
import '../../domain/usecases/update_profile_use_case.dart';
import '../datasources/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final userModel = await remoteDataSource.getProfile();
      return Right(userModel);
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    }catch(e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile(
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
