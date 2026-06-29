import 'package:bookia_store/features/Authentication/domain/entities/user_entity.dart';
import 'package:bookia_store/features/Authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';

class LoginUsecase {
  final AuthRepository authRepository;
  LoginUsecase(this.authRepository);

  //implement login function
  Future<Either<Failure,UserEntity>> call({
    required String email,
    required String password,
  }) async {
    return await authRepository.login(
        email: email,
        password: password
    );
  }
}