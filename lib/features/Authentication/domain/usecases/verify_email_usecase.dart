import 'package:bookia_store/core/errors/failures.dart';
import 'package:bookia_store/features/Authentication/domain/entities/user_entity.dart';
import 'package:bookia_store/features/Authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class VerifyEmailUsecase {
  final AuthRepository repository;
  VerifyEmailUsecase(this.repository);

  Future<Either<Failure,Unit>> call({
    required String email,
    required String otp,
}) async {
    return await repository.verifyEmail(email: email, otp: otp);
  }
}