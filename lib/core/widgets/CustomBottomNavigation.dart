import 'package:flutter/material.dart';
import '../utils/app_colors.dart'; // تأكد من المسار

class CustomBottomNavigation extends StatelessWidget {
  final int indexSelected;
  final Function(int) onItemSelected;

  const CustomBottomNavigation({
    super.key,
    required this.indexSelected,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    // قائمة الـ 4 شاشات الأساسية كما في الديزاين
    final List<Map<String, dynamic>> navItems = [
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.bookmark_border_rounded, 'label': 'Saved'},
      {'icon': Icons.shopping_cart_outlined, 'label': 'Cart'},
      {'icon': Icons.person_outline_rounded, 'label': 'Profile'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white, // خلفية البار
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length, (index) {
          bool isSelected = indexSelected == index;
          return GestureDetector(
            onTap: () => onItemSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                // لون الخلفية عند الاختيار - عدله ليكون لون تطبيقك الأساسي
                color: isSelected
                    ? AppColors.primaryBlue.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    navItems[index]['icon'],
                    color: isSelected ? AppColors.primaryBlue : Colors.grey,
                    size: 24,
                  ),
                  if (isSelected) ...[
                    const SizedBox(width: 8),
                    Text(
                      navItems[index]['label'],
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}