
import 'package:bookia_store/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../repositories/profile_repository.dart';

class ChangePasswordUseCase {
  final ProfileRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<Either<Failure,Unit>> call(ChangePasswordParams params) async{
    return await repository.updatePassword(params);
  }
}

class ChangePasswordParams{
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordParams({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}