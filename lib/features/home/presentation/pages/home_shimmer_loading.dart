import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/app_colors.dart';

class HomeShimmerLoading extends StatelessWidget {
  const HomeShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColors.surfaceLight,
      highlightColor: AppColors.primaryBlue,
      period: const Duration(milliseconds: 800),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //panner slider
            Container(
              height: 185,
              margin: const EdgeInsets.symmetric(horizontal:20,vertical: 8 ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:BorderRadius.circular(22),
              ),
            ),
            const SizedBox(height: 28),

            //categories section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: _TitleShimmer(width: 130),
            ),
            const SizedBox(height: 14),

            SizedBox(
              height: 44,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 20),
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (_,__)=>Container(
                  width: 90,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),

            //best sellers section
            const _ProductsSectionShimmer(),
            const SizedBox(height: 28),

            //new arrivals section
            const _ProductsSectionShimmer(),
            const SizedBox(height: 28),

          ],
        ),
      ),
    );
  }
}

//shimmer title widget
class _TitleShimmer extends StatelessWidget {
  
  final double width;
  const _TitleShimmer({required this.width});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: width,
          height: 22,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        Container(
          width: 50,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}

//shimmer products section
class _ProductsSectionShimmer extends StatelessWidget {

  const _ProductsSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: _TitleShimmer(width: 150),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 285,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 20),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (_,__)=>Container(
              width: 270,
              margin: const EdgeInsets.only(right: 20,bottom: 10,top: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 180,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(18))
                    ),
                  ),

                  //product name&price
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 60,
                              height: 18,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),

                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

