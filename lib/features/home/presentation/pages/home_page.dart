import 'package:bookia_store/core/utils/app_colors.dart';
import 'package:bookia_store/core/utils/app_theme_helpers.dart';
import 'package:bookia_store/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia_store/features/home/presentation/cubit/home_state.dart';
import 'package:bookia_store/features/home/presentation/widgets/home_slider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/service_locator.dart';
import '../widgets/categories_section.dart';
import '../widgets/products_section.dart';
import 'home_shimmer_loading.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> sl<HomeCubit>()..getHomeData(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: ShaderMask(
            shaderCallback: (bounds) => AppGradients.primary.createShader(bounds),
            child: const Text(
              'BOOKIA STORE',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                color: Colors.white
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search_rounded, color: AppColors.textPrimary, size: 26),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary, size: 26),
            ),
            const SizedBox(width: 8),
          ],
        ),
        
        body:  BlocBuilder<HomeCubit,HomeState>(
          builder: (context,state){
            if(state is HomeLoding){
              return const HomeShimmerLoading();
            }else if(state is HomeError){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline_rounded,color:AppColors.error,size: 50,),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: const TextStyle(color: AppColors.textSecondary,fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        gradient: AppGradients.primary,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: AppShadows.glowPurple,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent
                        ),
                          onPressed: ()=>context.read<HomeCubit>().getHomeData(),
                          child: const Text(
                            'Retry',style: TextStyle(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.bold
                          ),)
                      ),
                    )
                  ],
                ),
              );
            }else if(state is HomeLoaded){
              return RefreshIndicator(
                color: AppColors.accent,
                  backgroundColor: AppColors.surface,
                  onRefresh: () async {
                  await context.read<HomeCubit>().getHomeData();
                  },
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeSliderWidget(sliders: state.sliders),
                        const SizedBox(height: 28),

                        CategoriesSection(categories: state.categories),
                        const SizedBox(height: 28),

                        ProductsSection(
                          title: 'Best Sellers',
                          products: state.bestSellers,
                          onSeeAll: (){},
                        ),
                        const SizedBox(height: 28),

                        ProductsSection(
                          title: 'New Arrivals',
                          products: state.newArrivals,
                          onSeeAll: (){},
                        ),
                        const SizedBox(height: 28),

                      ],
                    ),
                  ),
              );
            }
            return const SizedBox.shrink();
          }
        ),
      ),
    );
    
  }
}
