import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class ResendVerifyCodeUseCase {
  final AuthRepository repository;

  ResendVerifyCodeUseCase(this.repository);

  Future<Either<Failure, Unit>> call() async {
    return await repository.resendVerifyCode();
  }
}