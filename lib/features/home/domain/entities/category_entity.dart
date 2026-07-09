class CategoryEntity {
  final int id;
  final String name;
  final int? productsCount;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.productsCount,
});

}