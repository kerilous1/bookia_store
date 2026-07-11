import 'package:bookia_store/core/errors/failures.dart';
import 'package:bookia_store/features/home/data/models/slider_model.dart';
import 'package:bookia_store/features/home/domain/entities/slider_entity.dart';
import 'package:dartz/dartz.dart';

import '../entities/category_entity.dart';
import '../entities/product_entity.dart';

abstract class HomeRepository {


  Future<Either<Failure,List<SliderEntity>>> getSliders();// to get slider images
  Future<Either<Failure,List<CategoryEntity>>> getCategories();// to get categories
  Future<Either<Failure,List<ProductEntity>>> getBestSellers();// to get best sellers
  Future<Either<Failure,List<ProductEntity>>> getNewArrivals();// to get new arrivals
  Future<Either<Failure,List<ProductEntity>>> searchProducts(String keyword);// to search products


}