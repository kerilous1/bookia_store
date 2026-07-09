import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_theme_helpers.dart';
import '../../../cart/presentation/cubit/cart_state_cubit.dart';
import '../../domain/entities/product_entity.dart';

class ProductCard extends StatefulWidget {
  final ProductEntity product;
  final VoidCallback onTap;
  final VoidCallback? onAddToCart;

  const ProductCard({super.key,
    required this.product,
    required this.onTap,
    this.onAddToCart
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

  late final product=widget.product;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border,width: 1),
          boxShadow: AppShadows.soft,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //book cover
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.network(
                    widget.product.image,
                    height: 170,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context,error,stackTrace){
                      return  Container(
                        color: AppColors.surface,
                        height: 180,
                        child: const Icon(Icons.error,color:AppColors.textMuted,size: 40,),
                      );
                    },
                  ),
                ),
                if(widget.product.discount>0)
                  Positioned(
                    top: 10,
                    left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                        decoration: BoxDecoration(
                          gradient: AppGradients.creative,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.hotPink.withOpacity(0.4),
                              blurRadius: 8,
                              spreadRadius: 1,
                            )
                          ]
                        ),
                        child: Text(
                          '${widget.product.discount}% off',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ),
              ],
            ),

            //book details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${widget.product.priceAfterDiscount}',
                            style: const TextStyle(
                              color: AppColors.accent,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if(widget.product.discount>0)
                            Text(
                              '\$${widget.product.price}',
                              style:  const TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 11,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),

                      BlocBuilder<CartStateCubit, CartStateState>(
                        builder:(context, state) {
                          final cartCubit = context.read<CartStateCubit>();
                          final isAdded = cartCubit.isInCart(product.id);

                          return GestureDetector(
                            onTap: (){
                              if (!isAdded) {
                                cartCubit.increaseQuantity(product);

                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${product.name} added to cart!',
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                    backgroundColor: AppColors.success,
                                    duration: const Duration(milliseconds: 600),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).clearSnackBars();

                                final snackBarController = ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Already in your cart! ',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                    ),
                                    backgroundColor: AppColors.primaryDark,
                                    duration: const Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      side: const BorderSide(color: AppColors.primaryLight, width: 1),
                                    ),
                                    action: SnackBarAction(
                                      label: 'Go to Cart',
                                      textColor: AppColors.accent,
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                        // TODO Navigate to cart screen
                                      },
                                    ),
                                  ),
                                );

                                Future.delayed(const Duration(milliseconds: 1500), () {
                                  snackBarController.close();
                                });
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: isAdded ? null :AppGradients.primary,
                                color: isAdded? AppColors.success:null ,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: isAdded ?[]:AppShadows.glowPurple,
                              ),
                              child: Icon(
                                isAdded ? Icons.check_rounded:Icons.add_shopping_cart_outlined,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          );
                        }
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

  }
}
