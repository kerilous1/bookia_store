import 'package:bookia_store/features/home/domain/entities/category_entity.dart';
import 'package:bookia_store/features/home/domain/entities/product_entity.dart';
import 'package:bookia_store/features/home/domain/entities/slider_entity.dart';

abstract class HomeState {}
class HomeInitial extends HomeState {

}

class HomeLoding extends HomeState {}

class HomeLoaded extends HomeState {
  final List<SliderEntity> sliders;
  final List<CategoryEntity> categories;
  final List<ProductEntity> bestSellers;
  final List<ProductEntity> newArrivals;
  HomeLoaded({
    required this.sliders,
    required this.categories,
    required this.bestSellers,
    required this.newArrivals,
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

