import 'package:bookia_store/core/network/api_constants.dart';
import 'package:dio/dio.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<UserModel> login({
    required String email,
    required String password
  }) async {
    final response =await _dio.post(
      ApiConstants.login,
      data: {
        'email':email,
        'password':password,
      }
    );

    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword
  }) async {
    final response=await _dio.post(
      ApiConstants.register,
      data: {
        'name':name,
        'email':email,
        'password':password,
        'confirm_password':confirmPassword,
      }
    );
    return UserModel.fromJson(response.data);
  }

}