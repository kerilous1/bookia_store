class UserEntity {
  final int? id;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final String? image;

  const UserEntity({
    this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.image,
  });

}