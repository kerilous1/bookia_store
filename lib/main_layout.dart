import 'package:flutter/material.dart';
import 'core/utils/app_colors.dart';
import 'core/widgets/CustomBottomNavigation.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const Center(
      child: Text(
        "Home Page",
        style: TextStyle(color: AppColors.textPrimary, fontSize: 18),
      ),
    ),
    const Center(
      child: Text(
        "Saved Page",
        style: TextStyle(color: AppColors.textPrimary, fontSize: 18),
      ),
    ),
    const Center(
      child: Text(
        "Cart Page",
        style: TextStyle(color: AppColors.textPrimary, fontSize: 18),
      ),
    ),
    const Center(
      child: Text(
        "Profile Page",
        style: TextStyle(color: AppColors.textPrimary, fontSize: 18),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
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