import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(
            color: AppColors.border,
            width: 0.8,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, -8),
          ),
          BoxShadow(
            color: AppColors.primary.withOpacity(0.05),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(navItems.length, (index) {
            bool isSelected = indexSelected == index;
            return GestureDetector(
              onTap: () => onItemSelected(index),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(
                  horizontal: isSelected ? 18 : 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(
                          colors: [
                            Color(0x337C3AED),
                            Color(0x22DB2777),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(16),
                  border: isSelected
                      ? Border.all(
                          color: AppColors.primary.withOpacity(0.3),
                          width: 1,
                        )
                      : null,
                ),
                child: Row(
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: isSelected
                            ? [
                                const Color(0xFF7C3AED),
                                const Color(0xFFDB2777),
                              ]
                            : [AppColors.textMuted, AppColors.textMuted],
                      ).createShader(bounds),
                      child: Icon(
                        navItems[index]['icon'],
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 8),
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            Color(0xFF7C3AED),
                            Color(0xFFDB2777),
                          ],
                        ).createShader(bounds),
                        child: Text(
                          navItems[index]['label'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}