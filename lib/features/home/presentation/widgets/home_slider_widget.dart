import 'package:bookia_store/core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_theme_helpers.dart';
import '../../domain/entities/slider_entity.dart';

class HomeSliderWidget extends StatelessWidget {
  final List<SliderEntity> sliders;
  const HomeSliderWidget({super.key, required this.sliders});

  @override
  Widget build(BuildContext context) {
    if(sliders.isEmpty)return const SizedBox.shrink();
    
    return SizedBox(
      height: 185,
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: sliders.length,
        itemBuilder: (context,index){
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: AppColors.borderFocus.withOpacity(0.5),width: 1),
              boxShadow: AppShadows.elevated,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                sliders[index].image,
                fit: BoxFit.cover,
                errorBuilder: (context,error,stackTrace){
                  return Container(
                    color: AppColors.surface,
                    child: const Center(
                      child: Icon(Icons.image_not_supported_outlined,color: AppColors.textMuted,size: 40,),
                    ),
                  );
                },
              ),
            ) ,
          );
        },
      ),
    );

  }
}
