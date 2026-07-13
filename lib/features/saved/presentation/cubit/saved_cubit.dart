import 'package:bookia_store/features/saved/presentation/cubit/saved_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../home/data/models/product_model.dart';
import '../../../home/domain/entities/product_entity.dart';

class SavedCubit extends Cubit<SavedState> {
  SavedCubit(): super(SavedInitial()){
    getSavedFromHive();
  }

  final Map<int,ProductEntity> _savedProducts={};
  final Box _wishlistBox = Hive.box('wishlist_box');


  //get saved from hive
  void getSavedFromHive() {
    _savedProducts.clear();
    for (var key in _wishlistBox.keys) {
      final itemMap = _wishlistBox.get(key);
      if (itemMap != null) {
        final productMap = Map<String, dynamic>.from(itemMap);
        final product = ProductModel.fromJson(productMap);
        _savedProducts[product.id] = product;
      }
    }
    emit(SavedLoaded(_savedProducts.values.toList()));
  }

  //check is in saved
  bool isSaved(int productId)=>_savedProducts.containsKey(productId);

void toggleSaved(ProductEntity product) {
  if (_savedProducts.containsKey(product.id)) {
    _savedProducts.remove(product.id);
    _wishlistBox.delete(product.id); // 🗑️ حذف من Hive
  } else {
    _savedProducts[product.id] = product;
    _wishlistBox.put(product.id, _productToMap(product)); // 💾 حفظ في Hive
  }
  emit(SavedLoaded(_savedProducts.values.toList()));
}

  Map<String, dynamic> _productToMap(ProductEntity p) => {
    'id': p.id,
    'name': p.name,
    'price': p.price,
    'priceAfterDiscount': p.priceAfterDiscount,
    'discount': p.discount,
    'image': p.image,
    'category': p.category ?? '',
    'stock': p.stock,
    'description': p.description,
  };

  //TODO: Implement get saved products
}