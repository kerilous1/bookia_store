import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/utils/app_colors.dart';
import 'core/widgets/CustomBottomNavigation.dart';
import 'features/cart/presentation/cubit/cart_state_cubit.dart';
import 'features/cart/presentation/pages/cart_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/saved/presentation/pages/saved_page.dart';
import 'features/user/presentation/pages/profile_page.dart';

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

      //saved builder
      SavedPage(),

      //cart builder
      const CartPage(),

      //profile builder
      ProfilePage(),
    ];
    //get cart count for badge
    final cartState = context.watch<CartStateCubit>().state;
    int cartCount = 0;
    if(cartState is CartUpdateState){
      cartCount = cartState.cartProducts.length;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: pages[currentIndex],
      bottomNavigationBar: CustomBottomNavigation(
        indexSelected: currentIndex,
        cartItemCount: cartCount,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
