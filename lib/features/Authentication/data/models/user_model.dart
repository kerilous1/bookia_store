import 'package:bookia_store/features/Authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {

  UserModel({
    required super.name,
    required super.email,
    required super.token
  });

  //convert json to model
  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
        name: json['data']['user']['name']??'',
        email: json['data']['user']['email']??'',
        token: json['data']['token']??'',
    );
  }

  //convert model to json
  Map<String,dynamic>toJson(){
    return{
      'data':{
        'user':{
          'name':name,
          'email':email,
        },
        'token':token,
      }
    };
  }


}