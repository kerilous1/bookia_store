import 'package:bookia_store/features/Authentication/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../Authentication/domain/entities/user_entity.dart';
import '../../domain/usecases/change_password_use_case.dart';
import '../../domain/usecases/update_profile_use_case.dart';

abstract class ProfileRemoteDataSource {
  //to get profile
  Future<UserModel> getProfile();
  //to update profile
  Future<UserModel> updateProfile(UpdateProfileParams params);
  //to delete profile
  Future<void> deleteProfile();
  //to update password
  Future<void> updatePassword(ChangePasswordParams params);
}