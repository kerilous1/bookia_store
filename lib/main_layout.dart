import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/utils/app_colors.dart';
import 'core/widgets/CustomBottomNavigation.dart';
import 'features/cart/presentation/cubit/cart_state_cubit.dart';
import 'features/cart/presentation/pages/cart_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/saved/presentation/pages/saved_page.dart';

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
