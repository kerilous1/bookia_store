import 'package:dio/dio.dart';
import '../../../../core/network/api_constants.dart';

abstract class CartRemoteDataSource {
  Future<Response> getCart();
  Future<Response> addToCart({required int productId});
  Future<Response> removeFromCart({required int cartItemId});
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final Dio dio;
  CartRemoteDataSourceImpl({required this.dio});

  @override
  Future<Response> getCart() async {
    return await dio.get(ApiConstants.showWishlist);
  }

  @override
  Future<Response> addToCart({required int productId}) async {
    return await dio.post(
      ApiConstants.addWishlist,
      data: {'product_id': productId},
    );
  }


  @override
  Future<Response> removeFromCart({required int cartItemId}) async {
    return await dio.post(
      ApiConstants.removeWishlist,
      data: {'cart_item_id': cartItemId},
    );
  }
}