import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_theme_helpers.dart';
import '../../../home/presentation/pages/product_details_page.dart';
import '../../../home/presentation/widgets/product_card.dart';
import '../cubit/search-state.dart';
import '../cubit/search_cubit.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  //debounce search
  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<SearchCubit>().searchBooks(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
        ),
        // 🌟 حقل البحث المدمج في البار العلوي
        title: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Container(
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Search for books... ',
                hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                suffixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary, size: 18),
                  onPressed: () {
                    _searchController.clear();
                    context.read<SearchCubit>().searchBooks('');
                  },
                ),
              ),
              onChanged: _onSearchChanged,
              onSubmitted: (query) {
                context.read<SearchCubit>().searchBooks(query);
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchInitial) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_rounded, color: AppColors.textMuted, size: 80),
                  SizedBox(height: 16),
                  Text(
                    'What are you looking for?',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                  ),
                ],
              ),
            );
          } else if (state is SearchLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryLight));
          } else if (state is SearchError) {
            return Center(child: Text(state.message, style: const TextStyle(color: AppColors.error)));
          } else if (state is SearchLoaded) {
            if (state.products.isEmpty) {
              return const Center(
                child: Text(
                  'No books found matching your search 🤷‍♂️',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                ),
              );
            }

            // show products
            return GridView.builder(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.56,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: state.products[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(product: state.products[index]),
                      ),
                    );
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}