import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../home/domain/entities/product_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, List<ProductEntity>>> getCart();

  Future<Either<Failure, String>> addToCart(int productId);

  Future<Either<Failure, String>> removeFromCart(int productId);
}