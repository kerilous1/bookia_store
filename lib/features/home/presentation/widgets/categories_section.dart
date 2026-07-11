import 'package:bookia_store/core/utils/app_theme_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/category_entity.dart';

class CategoriesSection extends StatelessWidget {
  final List<CategoryEntity> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;

  const CategoriesSection({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected
  });

  @override
  Widget build(BuildContext context) {
    if(categories.isEmpty)return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Categories',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 14),

        SizedBox(
          height: 45,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 20),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context,index){

              final category=categories[index];
              final isSelected=index==selectedIndex;

              return GestureDetector(
                onTap: ()=>onCategorySelected(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 10),
                  decoration: BoxDecoration(
                    gradient: isSelected? AppGradients.primary : AppGradients.glass,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: isSelected ? Colors.transparent : AppColors.border,width: 1.2
                    ),
                    boxShadow: isSelected ? AppShadows.glowPurple : null,
                  ),
                  child: Center(
                    child: Text(
                      category.name,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
