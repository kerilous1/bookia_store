
import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {

  CategoryModel({
    required super.id,
    required super.name,
    super.productsCount
  });

  factory CategoryModel.fromJeson(Map<String,dynamic> json){
    return CategoryModel(
        id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
        name: json['name']??'',
        productsCount: json['products_count']??0,
    );
  }
}