class ProductEntity {
  final int id;
  final String name;
  final String description;
  final String price;
  final int discount;
  final num priceAfterDiscount;
  final int stock;
  final int bestSeller;
  final String image;
  final String? category;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.priceAfterDiscount,
    required this.stock,
    required this.bestSeller,
    required this.image,
    this.category,
});


}