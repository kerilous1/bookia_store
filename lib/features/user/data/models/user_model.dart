import '../../domain/entities/user_entity.dart';

class UserModel extends ProfileEntity {
  const UserModel({
    super.id,
    required super.name,
    required super.email,
    super.phone,
    super.address,
    super.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    return UserModel(
      id: data['id'],
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'],
      address: data['address'],
      image: data['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'image': image,
    };
  }
}