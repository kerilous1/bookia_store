import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/errors/failures.dart';
import '../../home/data/models/product_model.dart';
import '../../home/domain/entities/product_entity.dart';
import '../domain/repositories/cart_repository.dart';
import 'datasources/cart_remote_data_source.dart';


class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getCart() async {
    try {
      final response = await remoteDataSource.getCart();
      print('🛒 RAW SERVER CART RESPONSE: ${response.data}');

      final dataMap = response.data['data'];
      if (dataMap == null) return const Right([]);

      final List<dynamic> items = dataMap['data'] ?? [];

      final products = items.map((json) => ProductModel.fromJson(json as Map<String, dynamic>)).toList();
      return Right(products);

    } catch (e) {
      if (e is DioException) return Left(ServerFailure(e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> addToCart(int productId) async {
    try {
      final response = await remoteDataSource.addToCart(productId: productId);
      return Right(response.data['message'] ?? 'Added successfully');
    } catch (e) {
      if (e is DioException) return Left(ServerFailure(e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, String>> removeFromCart(int productId) async {
    try {
      final response = await remoteDataSource.removeFromCart(cartItemId: productId);
      return Right(response.data['message'] ?? 'Removed successfully');
    } catch (e) {
      if (e is DioException) return Left(ServerFailure(e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }
}