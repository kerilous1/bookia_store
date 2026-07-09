import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../home/domain/entities/product_entity.dart';

part 'cart_state_state.dart';

class CartStateCubit extends Cubit<CartStateState> {
  CartStateCubit() : super(CartStateInitial());
  final Map<int, ProductEntity> _cartProducts = {};
  final Map<int,int> _quantity = {};
  final Map<int, ProductEntity> _savedProducts = {};

  //check is in cart& is saved
  bool isInCart(int productId) => _cartProducts.containsKey(productId);
  int getQuantity(int productId) => _quantity[productId] ?? 0;
  bool isInSaved(int productId) => _savedProducts.containsKey(productId);

  //togle cart
  void toggleCart(ProductEntity product) {
    if (_cartProducts.containsKey(product.id)) {
      _cartProducts.remove(product.id);
      _quantity.remove(product.id);
    } else {
      _cartProducts[product.id] = product;
      _quantity[product.id] = 1;
    }
    _emitUpdate();
  }

  //increase quantity
  void increaseQuantity(ProductEntity product) {
    if(!_cartProducts.containsKey(product.id)){
      _cartProducts[product.id]=product;
      _quantity[product.id]=1;
    }else{
      _quantity[product.id]=(_quantity[product.id] ?? 0)+1;
    }
    _emitUpdate();
  }

  //decrease quantity
  void decreaseQuantity(ProductEntity product) {
    if(!_cartProducts.containsKey(product.id))return;
    final currentQuantity=_quantity[product.id] ?? 1;
    if(currentQuantity>1){
      _quantity[product.id]=currentQuantity-1;
    }else{
      _cartProducts.remove(product.id);
      _quantity.remove(product.id);
    }
    _emitUpdate();
  }

  //toggle saved
  void toggleSaved(ProductEntity product) {
    if (_savedProducts.containsKey(product.id)) {
      _savedProducts.remove(product.id);
    } else {
      _savedProducts[product.id] = product;
    }
    _emitUpdate();
  }

  //calculate total
  void _emitUpdate() {
    num totalPrice = 0;
    for (var product in _cartProducts.values) {
      final quantity = _quantity[product.id] ?? 1;
      totalPrice += product.priceAfterDiscount*quantity;
    }
    emit(
      CartUpdateState(
        cartProducts: _cartProducts.values.toList(),
        savedProducts: _savedProducts.values.toList(),
        totalPrice: totalPrice,
        quantity:Map.from(_quantity),
      ),
    );
  }
}
