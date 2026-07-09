import 'package:bookia_store/core/errors/failures.dart';
import 'package:bookia_store/features/home/domain/entities/category_entity.dart';
import 'package:bookia_store/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetCategoriesUsecase {
  final HomeRepository repository;
  GetCategoriesUsecase(this.repository);

  Future<Either<Failure,List<CategoryEntity>>> call() async {
    return await repository.getCategories();
  }
}