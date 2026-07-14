import 'package:bookia_store/features/cart/presentation/cubit/cart_state_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../home/domain/entities/product_entity.dart';
import '../../../home/presentation/pages/product_details_page.dart';
import '../cubit/saved_cubit.dart';

class SavedCard extends StatelessWidget {
  final ProductEntity product;
  final SavedCubit savedCubit;
  const SavedCard({super.key, required this.product, required this.savedCubit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsPage(product: product),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.primarySurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.image,
                width: 80,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 75,
                  height: 100,
                  color: AppColors.surfaceLight,
                  child: const Icon(
                    Icons.menu_book_outlined,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () => savedCubit.toggleSaved(product),
                        child: const Icon(
                          Icons.favorite_rounded,
                          color: AppColors.hotPink,
                          size: 23,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.priceAfterDiscount}',
                        style: const TextStyle(
                          color: AppColors.accent,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),

                      Builder(
                        builder: (context) {
                          final cartCubit = context.watch<CartStateCubit>();
                          final currentQuantity = cartCubit.getQuantity(product.id);
                          final isAddedToCart = currentQuantity > 0;

                          return ElevatedButton.icon(

                            style: ElevatedButton.styleFrom(
                              backgroundColor: isAddedToCart
                                  ? AppColors.success
                              : AppColors.primarySurface,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              if(currentQuantity>=1){
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('You already have $currentQuantity in your cart !'),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: AppColors.warning,
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                                return;
                              }
                              cartCubit.increaseQuantity(product);
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${product.name} added to cart'),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: AppColors.success,
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },

                            icon: Icon(
                              isAddedToCart ?
                              Icons.shopping_cart_outlined
                              : Icons.shopping_cart_outlined,
                              color: AppColors.primaryDark,
                              size: 18,
                            ),
                            label: Text(
                              isAddedToCart ? 'In Cart "$currentQuantity"' : 'Add to Cart',
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
