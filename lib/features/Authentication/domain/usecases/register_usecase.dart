import 'package:bookia_store/features/Authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';
import '../../../../core/errors/failures.dart';

class RegisterUsecase {
  final AuthRepository authRepository;

  RegisterUsecase(this.authRepository);

  //implement register function
  Future<Either<Failure,UserEntity>> call({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
}) async {
    return await authRepository.register(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}