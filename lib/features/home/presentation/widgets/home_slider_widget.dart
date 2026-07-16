import 'package:bookia_store/core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_theme_helpers.dart';
import '../../domain/entities/slider_entity.dart';

class HomeSliderWidget extends StatefulWidget {
  final List<SliderEntity> sliders;
  const HomeSliderWidget({super.key, required this.sliders});

  @override
  State<HomeSliderWidget> createState() => _HomeSliderWidgetState();
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    if(widget.sliders.isEmpty)return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 185,
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: widget.sliders.length,
            onPageChanged: (index){
              setState(() {
                _currentPage = index;
              });
            },
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
                    widget.sliders[index].image,
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
        ),

        //page indicator dots
        if(widget.sliders.length > 1)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.sliders.length, (index){
                final isActive = index == _currentPage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: isActive ? AppGradients.primary : null,
                    color: isActive ? null : AppColors.border,
                  ),
                );
              }),
            ),
          ),
      ],
    );

  }
}
