import 'package:bookia_store/features/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {

  const UserModel({
    super.id,
    required super.name,
    required super.email,
    super.phone,
    super.address,
    super.image,
});

  //factory constructor to convert json to dart object
  factory UserModel.fromJson(Map<String,dynamic> json) {
    final data=json['data'];

    return UserModel(
      id: data['id']??0,
      name: data['name']??'',
      email: data['email']??'',
      phone: data['phone']??'',
      address: data['address']??'',
      image: data['image'],
    );
  }

  //convert dart object to map json
  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'name':name,
      'email':email,
      'phone':phone,
      'address':address,
      'image':image,
    };
  }

}