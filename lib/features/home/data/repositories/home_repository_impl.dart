import 'package:bookia_store/features/home/data/datasources/home_remote_data_source.dart';
import 'package:bookia_store/features/home/data/models/category_model.dart';
import 'package:bookia_store/features/home/domain/entities/category_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/entities/slider_entity.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;
  HomeRepositoryImpl(this._remoteDataSource);

  //get sliders from remote data source
  @override
  Future<Either<Failure, List<SliderEntity>>> getSliders() async {
    try {
      final sliders = await _remoteDataSource.getSliders();
      return Right(sliders);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  //get categories from remote data source
  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await _remoteDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  //get best sellers from remote data source
  @override
  Future<Either<Failure, List<ProductEntity>>> getBestSellers() async {
    try {
      final bestSellers = await _remoteDataSource.getBestSellers();
      return Right(bestSellers);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  //get new arrivals from remote data source
  @override
  Future<Either<Failure, List<ProductEntity>>> getNewArrivals() async {
    try {
      final newArrivals = await _remoteDataSource.getNewArrivals();
      return Right(newArrivals);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  //search products from remote data source
  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String keyword) async {
    try{
      final products=await _remoteDataSource.searchProducts(keyword);
      return Right(products);
    }catch(e){
      return Left(ServerFailure(e.toString()));
    }
  }
}
