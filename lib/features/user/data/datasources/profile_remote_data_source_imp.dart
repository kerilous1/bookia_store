
import 'package:bookia_store/core/network/api_constants.dart';
import 'package:bookia_store/features/Authentication/data/models/user_model.dart';

import 'package:bookia_store/features/user/domain/usecases/change_password_use_case.dart';

import 'package:bookia_store/features/user/domain/usecases/update_profile_use_case.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'profile_remote_data_source.dart';

class ProfileRemoteDataSourceImp implements ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSourceImp({required this.dio});

  @override
  Future<UserModel> getProfile() async {
    final response= await dio.get(ApiConstants.getProfile);
    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> updateProfile(UpdateProfileParams params) async {
    final Map<String,dynamic> mapData={
      'name':params.name,
      if(params.phone!=null)'phone':params.phone,
      if(params.address!=null)'address':params.address,
    };
    if(params.image!=null && params.image!.isNotEmpty){
      mapData['image']=await MultipartFile.fromFile(params.image!);
    }

    final formData=FormData.fromMap(mapData);

    final response=await dio.post(
      ApiConstants.updateProfile,
      data: formData,
    );

    return UserModel.fromJson(response.data);
  }

  @override
  Future<void> deleteProfile() async {
    await dio.post(ApiConstants.deleteProfile);
  }

  @override
  Future<void> updatePassword(ChangePasswordParams params) async {
    await dio.post(
      ApiConstants.updatePassword,
      data: {
        'current_password': params.currentPassword,
        'new_password': params.newPassword,
        'new_password_confirmation': params.confirmPassword,
      }
    );
  }

}