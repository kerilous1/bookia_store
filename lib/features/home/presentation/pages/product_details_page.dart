import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_theme_helpers.dart';
import '../../../cart/presentation/cubit/cart_state_cubit.dart';
import '../../domain/entities/product_entity.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductEntity product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool _isFavorite = false;
  bool _isExpanded = false;
  bool _isAddedToCart = false;

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartStateCubit>();
    final product = widget.product;
    final cleanDescription = product.description.stripHtmlTags;
    final isFavorite = cartCubit.isInSaved(product.id);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                backgroundColor: AppColors.surface,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface.withOpacity(0.8),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border, width: 1),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.textPrimary,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: () =>
                          context.read<CartStateCubit>().toggleSaved(product),
                      child: Icon(
                        _isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: _isFavorite
                            ? AppColors.hotPink
                            : AppColors.textPrimary,
                        size: 20,
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: AppGradients.backgroundOverlay,
                        ),
                      ),
                      Positioned(
                        top: 80,
                        child: Container(
                          width: 200,
                          height: 250,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.3),
                                blurRadius: 60,
                                spreadRadius: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        child: Hero(
                          tag: 'product_${product.id}',
                          child: Container(
                            height: 280,
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: AppShadows.elevated,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                product.image,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: AppColors.surfaceLight,
                                    child: const Center(
                                      child: Icon(
                                        Icons.menu_book_outlined,
                                        color: AppColors.textMuted,
                                        size: 60,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (product.category != null &&
                          product.category!.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.borderFocus.withOpacity(0.5),
                            ),
                          ),
                          child: Text(
                            product.category!,
                            style: const TextStyle(
                              color: AppColors.primaryLight,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      const SizedBox(height: 14),

                      //author name
                      Text(
                        product.name,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 16),

                      //product price&discount
                      Row(
                        children: [
                          Text(
                            '\$${product.priceAfterDiscount}',
                            style: TextStyle(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w900,
                              fontSize: 28,
                            ),
                          ),
                          const SizedBox(width: 12),
                          if (product.discount > 0) ...[
                            Text(
                              '\$${product.price}',
                              style: TextStyle(
                                color: AppColors.textMuted,
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: 12),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                gradient: AppGradients.creative,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '-${product.discount}%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),

                      //description product
                      const Text(
                        'Description',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),

                      //expandable description
                      AnimatedCrossFade(
                        firstChild: Text(
                          cleanDescription.isEmpty
                              ? 'No description available for this product'
                              : cleanDescription,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                        secondChild: Text(
                          cleanDescription.isEmpty
                              ? 'No description available for this book.'
                              : cleanDescription,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                        crossFadeState: _isExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 350),
                      ),
                      if (cleanDescription.length > 100) ...[
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => setState(() {
                            _isExpanded = !_isExpanded;
                          }),
                          child: Text(
                            _isExpanded ? 'Read Less' : 'Read More..',
                            style: TextStyle(
                              color: AppColors.primaryLight,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),

          //floating button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.surface.withOpacity(0.95),
                border: const Border(
                  top: BorderSide(color: AppColors.border, width: 1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.borderFocus),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Stock',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${product.stock}',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),

                  //add to cart button
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final cartCubit = context.watch<CartStateCubit>();
                        final quantity = cartCubit.getQuantity(product.id);
                        final isAddedToCart = quantity > 0;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: _isAddedToCart
                                ? null
                                : AppGradients.primary,
                            color: _isAddedToCart ? AppColors.success : null,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: _isAddedToCart
                                ? []
                                : AppShadows.glowPurple,
                          ),
                          child: isAddedToCart
                              ? Row(
                                  mainAxisAlignment: .spaceBetween,
                                  children: [
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                              left: Radius.circular(16),
                                            ),
                                        onTap: () {
                                          cartCubit.decreaseQuantity(product);
                                          if (cartCubit.getQuantity(
                                                product.id,
                                              ) ==
                                              0) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).clearSnackBars();
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  '${product.name} removed from cart',
                                                ),
                                                backgroundColor:
                                                    AppColors.error,
                                                duration: const Duration(
                                                  milliseconds: 600,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: Container(
                                          width: 60,
                                          height: double.infinity,
                                          alignment: .center,
                                          child: const Icon(
                                            Icons.remove_circle_rounded,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),

                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$quantity',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const Text(
                                          'in Cart',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                              right: Radius.circular(16),
                                            ),
                                        onTap: () {
                                          if (quantity >= product.stock ||
                                              quantity >= 5) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).clearSnackBars();
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Maximum stock reached!',
                                                ),
                                                backgroundColor:
                                                    AppColors.warning,
                                                duration: Duration(
                                                  milliseconds: 600,
                                                ),
                                              ),
                                            );
                                            return;
                                          }
                                          cartCubit.increaseQuantity(product);
                                        },
                                        child: Container(
                                          width: 60,
                                          height: double.infinity,
                                          alignment: .center,
                                          child: const Icon(
                                            Icons.add_circle_rounded,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  onPressed: () {
                                    cartCubit.increaseQuantity(product);
                                    ScaffoldMessenger.of(
                                      context,
                                    ).clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${product.name} added to cart!',
                                        ),
                                        backgroundColor: AppColors.success,
                                        duration: const Duration(
                                          milliseconds: 800,
                                        ),
                                      ),
                                    );
                                  },

                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.shopping_bag_outlined,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Add to Cart',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension Htmlextensions on String {
  String get stripHtmlTags => replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '').trim();
}
