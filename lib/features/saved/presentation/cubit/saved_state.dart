import '../../../home/domain/entities/product_entity.dart';

abstract class SavedState {}

class SavedInitial extends SavedState {}

class SavedLoading extends SavedState {}

class SavedLoaded extends SavedState {
  final List<ProductEntity> products;
  SavedLoaded(this.products);

}

class SavedError extends SavedState {
  final String message;
  SavedError(this.message);

}
