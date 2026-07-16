import 'package:bookia_store/core/errors/failures.dart';
import 'package:bookia_store/features/Authentication/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../entities/user_entity.dart';
import '../usecases/change_password_use_case.dart';
import '../usecases/update_profile_use_case.dart';

abstract class ProfileRepository {

  //show profile
  Future<Either<Failure,ProfileEntity>> getProfile();

  //update profile
  Future<Either<Failure,ProfileEntity>> updateProfile(UpdateProfileParams params);

  //delete profile
  Future<Either<Failure,Unit>> deleteProfile();

  //update password
  Future<Either<Failure,Unit>> updatePassword(ChangePasswordParams params);
}

