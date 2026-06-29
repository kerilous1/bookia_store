import 'package:bookia_store/features/Authentication/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';

abstract class AuthRepository {
  //login function
  Future<Either<Failure,UserEntity>> login({
    required String email,
    required String password,
  });

  //register function
  Future<Either<Failure,UserEntity>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  });

}