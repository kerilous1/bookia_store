import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:bookia_store/features/home/data/models/product_model.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../home/domain/entities/product_entity.dart';
import '../../domain/repositories/cart_repository.dart';

part 'cart_state_state.dart';

class CartStateCubit extends Cubit<CartStateState> {
  final CartRepository cartRepository;

  CartStateCubit({required this.cartRepository}) : super(CartStateInitial()){
    getCartFromHive();
  }

  final Map<int, ProductEntity> _cartProducts = {};
  final Map<int, int> _quantity = {};
  final Box _cartBox = Hive.box('cart_box');


  void getCartFromHive() {
    _cartProducts.clear();
    _quantity.clear();

    for (var key in _cartBox.keys) {
      final itemMap = _cartBox.get(key);
      if (itemMap != null) {
        final productMap = Map<String, dynamic>.from(itemMap['product']);
        final int qty = itemMap['quantity'] ?? 1;

        final product = ProductModel.fromJson(productMap);
        _cartProducts[product.id] = product;
        _quantity[product.id] = qty;
      }
    }
    _emitUpdate();
  }

  void _saveToHive(ProductEntity product) {
    final qty = _quantity[product.id] ?? 1;
    _cartBox.put(product.id, {
      'product': _productToMap(product),
      'quantity': qty,
    });
  }



  bool isInCart(int productId) => _cartProducts.containsKey(productId);
  int getQuantity(int productId) => _quantity[productId] ?? 0;

  void toggleCart(ProductEntity product) {
    if (_cartProducts.containsKey(product.id)) {
      removeProduct(product);
    } else {
      increaseQuantity(product);
    }
  }

  void increaseQuantity(ProductEntity product) {
    _cartProducts[product.id] = product;
    _quantity[product.id] = (_quantity[product.id] ?? 0) + 1;
    _saveToHive(product);
    _emitUpdate();
  }

  void decreaseQuantity(ProductEntity product) {
    if (!_cartProducts.containsKey(product.id)) return;
    final currentQty = _quantity[product.id] ?? 1;
    if (currentQty > 1) {
      _quantity[product.id] = currentQty - 1;
      _saveToHive(product);
      _emitUpdate();
    } else {
      removeProduct(product);
    }
  }

  // Future<void> getCartFromServer() async {
  //   final result = await cartRepository.getCart();
  //   result.fold(
  //         (failure) => print('Error loading cart: ${failure.message}'),
  //         (products) {
  //       _cartProducts.clear();
  //       _quantity.clear();
  //       for (var prod in products) {
  //         _cartProducts[prod.id] = prod;
  //         _quantity[prod.id] = 1;
  //       }
  //       _emitUpdate();
  //     },
  //   );
  // }



  // void removeProduct(ProductEntity product) async {
  //   if (!_cartProducts.containsKey(product.id)) return;
  //
  //   final oldQty = _quantity[product.id] ?? 1;
  //
  //   _cartProducts.remove(product.id);
  //   _quantity.remove(product.id);
  //   _emitUpdate();
  //
  //   final result = await cartRepository.removeFromCart(product.id);
  //
  //   result.fold(
  //         (failure) {
  //       print('Failed to remove from server: ${failure.message}');
  //       _cartProducts[product.id] = product;
  //       _quantity[product.id] = oldQty;
  //       _emitUpdate();
  //     },
  //         (success) => null,
  //   );
  // }

  // void increaseQuantity(ProductEntity product) async {
  //   final bool isNewItem = !_cartProducts.containsKey(product.id);
  //   final int oldQty = _quantity[product.id] ?? 0;
  //   final int newQty = oldQty + 1;
  //
  //   _cartProducts[product.id] = product;
  //   _quantity[product.id] = newQty;
  //   _emitUpdate();
  //
  //   final result = await cartRepository.addToCart(product.id);
  //
  //   result.fold(
  //         (failure) {
  //       print('Failed to add/update on server: ${failure.message}');
  //       if (isNewItem) {
  //         _cartProducts.remove(product.id);
  //         _quantity.remove(product.id);
  //       } else {
  //         _quantity[product.id] = oldQty;
  //       }
  //       _emitUpdate();
  //     },
  //         (success) => null,
  //   );
  // }

  // void decreaseQuantity(ProductEntity product) async {
  //   if (!_cartProducts.containsKey(product.id)) return;
  //
  //   final int oldQty = _quantity[product.id] ?? 1;
  //   final int newQty = oldQty - 1;
  //
  //   if (newQty <= 0) {
  //     removeProduct(product);
  //     return;
  //   }
  //
  //   _quantity[product.id] = newQty;
  //   _emitUpdate();
  //
  //   final result = await cartRepository.addToCart(product.id);
  //
  //   result.fold(
  //         (failure) {
  //       print('Failed to decrease on server: ${failure.message}');
  //       _quantity[product.id] = oldQty;
  //       _emitUpdate();
  //     },
  //         (success) => null,
  //   );
  // }

  void removeProduct(ProductEntity product) {
    _cartProducts.remove(product.id);
    _quantity.remove(product.id);
    _cartBox.delete(product.id);
    _emitUpdate();
  }

  void clearCart() {
    _cartProducts.clear();
    _quantity.clear();
    _emitUpdate();
  }

  void _emitUpdate() {
    num totalPrice = 0;
    for (var product in _cartProducts.values) {
      final quantity = _quantity[product.id] ?? 1;
      totalPrice += product.priceAfterDiscount * quantity;
    }
    emit(
      CartUpdateState(
        cartProducts: _cartProducts.values.toList(),
        totalPrice: totalPrice,
        quantity: Map.from(_quantity),
      ),
    );
  }


  Map<String, dynamic> _productToMap(ProductEntity p) => {
    'id': p.id, 'name': p.name, 'price': p.price, 'priceAfterDiscount': p.priceAfterDiscount,
    'discount': p.discount, 'image': p.image, 'category': p.category ?? '',
    'stock': p.stock, 'description': p.description,
  };

}