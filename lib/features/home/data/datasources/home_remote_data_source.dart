import 'package:bookia_store/features/home/data/models/slider_model.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';

abstract class HomeRemoteDataSource {

  Future<List<SliderModel>> getSliders();
  Future<List<CategoryModel>> getCategories();
  Future<List<ProductModel>> getBestSellers();
  Future<List<ProductModel>> getNewArrivals();
  
}