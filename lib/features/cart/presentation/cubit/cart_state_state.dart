part of 'cart_state_cubit.dart';

@immutable
sealed class CartStateState {}

class CartStateInitial extends CartStateState {}

class CartUpdateState extends CartStateState{
   final List<ProductEntity> cartProducts;
   final Map<int,int> quantity;
   final List<ProductEntity> savedProducts;
   final num totalPrice;
   CartUpdateState({
     required this.cartProducts,
     required this.savedProducts,
     required this.totalPrice,
     required this.quantity
});


}
