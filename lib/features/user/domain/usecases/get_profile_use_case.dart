import 'package:bookia_store/core/errors/failures.dart';
import 'package:bookia_store/features/Authentication/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository repository;
  GetProfileUseCase(this.repository);

  Future<Either<Failure,UserEntity>> call() async {
    return await repository.getProfile();
  }


}