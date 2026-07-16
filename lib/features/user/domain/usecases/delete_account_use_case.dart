import 'package:bookia_store/core/errors/failures.dart';
import 'package:bookia_store/features/user/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteAccountUseCase {
  final ProfileRepository repository;

  DeleteAccountUseCase(this.repository);

  Future<Either<Failure,Unit>> call()async {
    return await repository.deleteProfile();
  }
}