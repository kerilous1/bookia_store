import 'package:bookia_store/core/errors/failures.dart';
import 'package:bookia_store/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/product_entity.dart';

class SearchProductsUsecase {
  final HomeRepository repository;

  SearchProductsUsecase(this.repository);

  Future<Either<Failure,List<ProductEntity>>> call(String keyword) async{
    return await repository.searchProducts(keyword);
  }
}