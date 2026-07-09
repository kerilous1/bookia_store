import 'package:bookia_store/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:bookia_store/features/home/domain/usecases/get_sliders_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_best_sellers_usecase.dart';
import '../../domain/usecases/get_new_arrivals_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetSlidersUsecase getSlidersUsecase;
  final GetCategoriesUsecase getCategoriesUsecase;
  final GetNewArrivalsUsecase getNewArrivalsUsecase;
  final GetBestSellersUsecase getBestSellersUsecase;

  HomeCubit({
    required this.getSlidersUsecase,
    required this.getCategoriesUsecase,
    required this.getNewArrivalsUsecase,
    required this.getBestSellersUsecase,
}):super(HomeInitial());

  Future<void> getHomeData() async {
    emit(HomeLoding());

    final sliders= getSlidersUsecase();
    final categories= getCategoriesUsecase();
    final newArrivals= getNewArrivalsUsecase();
    final bestSellers= getBestSellersUsecase();

    final sliderResult=await sliders;
    final categoriesResult=await categories;
    final newArrivalsResult=await newArrivals;
    final bestSellersResult=await bestSellers;

    //check if the result is left or right and emit the result
    if(sliderResult.isLeft()){
      emit(HomeError(
          sliderResult.fold((l)=>l.message, (r)=>''))
      );
      return;
    }
    if(categoriesResult.isLeft()){
      emit(HomeError(
          categoriesResult.fold((l)=>l.message,(r)=>''))
      );
      return;
    }
    if(bestSellersResult.isLeft()){
      emit(HomeError(
          bestSellersResult.fold((l)=>l.message,(r)=>''))
      );
      return;
    }
    if(newArrivalsResult.isLeft()){
      emit(HomeError(
          newArrivalsResult.fold((l)=>l.message,(r)=>''))
      );
      return;
    }

    emit(HomeLoaded(
        sliders: sliderResult.getOrElse(()=>[]),
        categories: categoriesResult.getOrElse(()=>[]),
        bestSellers: bestSellersResult.getOrElse(()=>[]),
        newArrivals: newArrivalsResult.getOrElse(()=>[])
    ));
  }


}