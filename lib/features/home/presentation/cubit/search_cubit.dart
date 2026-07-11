import 'package:bookia_store/features/home/domain/usecases/search_products_usecase.dart';
import 'package:bookia_store/features/home/presentation/cubit/search-state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchProductsUsecase searchProductsUsecase;

  SearchCubit( this.searchProductsUsecase):super(SearchInitial());

  Future<void> searchBooks(String keyword)async{
    if(keyword.trim().isEmpty){
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading());
    final result=await searchProductsUsecase(keyword);

    if(isClosed)return;

    result.fold(
        (failure)=>emit(SearchError(failure.message)),
        (products)=>emit(SearchLoaded(products)),
    );
  }
}