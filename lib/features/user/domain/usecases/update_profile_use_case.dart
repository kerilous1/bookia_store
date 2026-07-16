
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../Authentication/domain/entities/user_entity.dart';
import '../entities/user_entity.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<Failure, ProfileEntity>> call(UpdateProfileParams params) async {
    return await repository.updateProfile(params);
  }
}

class UpdateProfileParams{
  final String name;
  final String? phone;
  final String? address;
  final String? image;

  UpdateProfileParams({
    required this.name,
    this.phone,
    this.address,
    this.image,
  });
}