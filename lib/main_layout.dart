import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/utils/app_colors.dart';
import 'core/widgets/CustomBottomNavigation.dart';
import 'features/cart/presentation/cubit/cart_state_cubit.dart';
import 'features/home/presentation/pages/home_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomePage(),
      BlocBuilder<CartStateCubit, CartStateState>(
        builder: (context, state) {
          int count = 0;
          if (state is CartUpdateState) {
            count = state.cartProducts.length;
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.favorite_rounded,
                  color: AppColors.hotPink,
                  size: 64,
                ),
                SizedBox(height: 16),
                Text(
                  'Saved Books:$count',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),

      //cart builder
      BlocBuilder<CartStateCubit, CartStateState>(
        builder: (context, state) {
          int count = 0;
          num totalPrice = 0;
          if (state is CartUpdateState) {
            count = state.cartProducts.length;
            totalPrice = state.totalPrice;
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shopping_bag_rounded,
                  color: AppColors.accent,
                  size: 64,
                ),
                const SizedBox(height: 16),
                Text(
                  "Cart Items: $count",
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Total: \$$totalPrice",
                  style: const TextStyle(
                    color: AppColors.primaryLight,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          );
        },
      ),

      const Center(
        child: Text(
          "Profile Page",
          style: TextStyle(color: AppColors.textPrimary, fontSize: 18),
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: AppColors.background,
      body: pages[currentIndex],
      bottomNavigationBar: CustomBottomNavigation(
        indexSelected: currentIndex,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
