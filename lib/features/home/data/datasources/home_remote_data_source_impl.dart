import 'dart:convert';

import 'package:bookia_store/core/network/api_constants.dart';
import 'package:bookia_store/features/home/data/models/category_model.dart';

import 'package:bookia_store/features/home/data/models/product_model.dart';

import 'package:bookia_store/features/home/data/models/slider_model.dart';
import 'package:dio/dio.dart';

import 'home_remote_data_source.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio _dio;

  HomeRemoteDataSourceImpl(this._dio);

  //convert slider json to slider model
  @override
  Future<List<SliderModel>> getSliders() async {
    final response = await _dio.get(ApiConstants.sliders);

    final List<dynamic> data = response.data['data']['sliders'];

    return data.map(
            (json) => SliderModel.fromJeson(json as Map<String, dynamic>)
    ).toList();
  }

  //convert category json to category model
  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _dio.get(ApiConstants.categories);

    final List<dynamic> data = response.data['data']['categories'];

    return data.map(
            (json) => CategoryModel.fromJeson(json as Map<String, dynamic>)
    ).toList();
  }

  //convert product json to product model
  @override
  Future<List<ProductModel>> getBestSellers() async {
    final response = await _dio.get(ApiConstants.bestSellers);

    final List<dynamic> data = response.data['data']['products'];

    return data.map(
            (json) => ProductModel.fromJson(json as Map<String, dynamic>)
    ).toList();
  }

  //convert product json to product model
  @override
  Future<List<ProductModel>> getNewArrivals() async {
    final response = await _dio.get(ApiConstants.newArrivals);

    final List<dynamic> data = response.data['data']['products'];

    return data.map(
            (json) => ProductModel.fromJson(json)
    ).toList();
  }
}
