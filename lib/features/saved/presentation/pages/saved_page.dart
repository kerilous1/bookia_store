import 'package:bookia_store/features/saved/presentation/cubit/saved_cubit.dart';
import 'package:bookia_store/features/saved/presentation/cubit/saved_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../home/domain/entities/product_entity.dart';
import '../widget/saved_card.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Saved Books',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: BlocBuilder<SavedCubit,SavedState>(
        builder: (context,state){
          final savedCubit=context.read<SavedCubit>();

          List<ProductEntity> savedProducts=[];

          if(state is SavedLoaded){
            savedProducts=state.products;
          }

          if(savedProducts.isEmpty){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border,width: 1),
                    ),
                    child: const Icon(
                      Icons.favorite_outline,
                      color: AppColors.textMuted,
                      size: 64,
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Your saved books are empty !',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
            physics: const BouncingScrollPhysics(),
            itemCount: savedProducts.length,
            itemBuilder: (context,index){
              final product=savedProducts[index];
              return SavedCard(
                product: product,
                savedCubit: savedCubit,
              );
            },
          );
        },
      )
    );
  }
}
