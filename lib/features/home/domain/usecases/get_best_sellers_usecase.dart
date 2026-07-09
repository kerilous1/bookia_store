import 'package:bookia_store/core/errors/failures.dart';
import 'package:bookia_store/features/home/domain/entities/product_entity.dart';
import 'package:bookia_store/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetBestSellersUsecase {
  final HomeRepository repository;
  GetBestSellersUsecase(this.repository);

  Future<Either<Failure,List<ProductEntity>>> call() async {
    return await repository.getBestSellers();
  }
}