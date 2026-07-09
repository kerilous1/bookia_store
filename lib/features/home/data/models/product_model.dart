import 'dart:convert';

import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.discount,
    required super.priceAfterDiscount,
    required super.stock,
    required super.bestSeller,
    required super.image,
    super.category
  });

  factory ProductModel.fromJson(Map<String,dynamic> product){
    return ProductModel(
        id: int.tryParse(product['id']?.toString()?? '0')?? 0,
        name: product['name']?? '',
        description: product['description']?? '',
        price: product['price']?.toString() ?? '0',
        discount: int.tryParse(product['discount']?.toString() ?? '0' )?? 0,
        priceAfterDiscount: num.tryParse(product['price_after_discount']?.toString() ?? '0') ?? 0,
        stock: int.tryParse(product['stock']?.toString() ?? '0') ?? 0,
        bestSeller: int.tryParse(product['best_seller']?.toString() ?? '0') ?? 0,
        image: product['image']?? '',
        category: product['category'] ,
    );
  }

}