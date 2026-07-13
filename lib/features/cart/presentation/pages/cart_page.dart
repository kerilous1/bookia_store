import 'package:bookia_store/features/cart/presentation/cubit/cart_state_cubit.dart';
import 'package:bookia_store/features/cart/presentation/widget/product_Card.dart';
import 'package:bookia_store/features/home/domain/entities/product_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_theme_helpers.dart';
import 'checkout_dialog.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Cart',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: BlocBuilder<CartStateCubit, CartStateState>(
        builder: (context, state) {
          final CartCubit = context.read<CartStateCubit>();

          List<ProductEntity> cartProducts = [];

          Map<int, int> quantityPerProduct = {};
          num totalPrice = 0;

          //check if state is CartUpdateState
          if (state is CartUpdateState) {
            cartProducts = state.cartProducts;
            quantityPerProduct = state.quantity;
            totalPrice = state.totalPrice;
          }

          //check if the cart is empty
          if (cartProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border, width: 1),
                    ),
                    child: const Icon(
                      Icons.shopping_basket_outlined,
                      color: AppColors.textMuted,
                      size: 64,
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Your cart is empty !',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    'Looks like you haven\'t added any books yet.',
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            );
          }

          return Stack(
            children: [
              ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 120),
                physics: const BouncingScrollPhysics(),
                itemCount: cartProducts.length,
                itemBuilder: (context, index) {
                  final product = cartProducts[index];
                  final qty = quantityPerProduct[product.id]?? 1;

                  return ProductCard(
                    product: product,
                    quantity: qty,
                    cartCubit: CartCubit,
                  );
                },
              ),

              //total price
              Positioned(
                bottom: 5,
                left: 15,
                right: 15,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(20),
                    border: const Border(
                      top: BorderSide(color: AppColors.borderFocus, width: 1),
                      left: BorderSide(color: AppColors.borderFocus, width: 1),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.surface.withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Total Price',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: AppColors.accent,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),

                      Container(
                        height: 50,
                        width: 160,
                        decoration: BoxDecoration(
                          gradient: AppGradients.primary,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: AppShadows.glowPurple,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () {
                            showCheckoutDialog(context);
                          },
                          child: const Text(
                            'Checkout',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
