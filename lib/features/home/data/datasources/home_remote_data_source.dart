import 'package:bookia_store/features/home/data/models/slider_model.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';

abstract class HomeRemoteDataSource {

  Future<List<SliderModel>> getSliders();// to get slider images
  Future<List<CategoryModel>> getCategories();// to get categories
  Future<List<ProductModel>> getBestSellers();// to get best sellers
  Future<List<ProductModel>> getNewArrivals();// to get new arrivals
  Future<List<ProductModel>> searchProducts(String keyword);// to search products
  
}