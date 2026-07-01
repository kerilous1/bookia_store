import 'package:bookia_store/core/network/api_constants.dart';
import 'package:dio/dio.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  //implement login function
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

  //implement register function
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
        'password_confirmation':confirmPassword,
      }
    );
    return UserModel.fromJson(response.data);
  }

  //implement verify email function
  @override
    Future<void> verifyEmail({
    required String email,
    required String otp
    }) async {
      await Future.delayed(const Duration(seconds: 3));
      if (otp == '123456') {
        return;
      } else {
        throw Exception('Invalid OTP, try 123456');
      }
    }

  //implement resend verify code function
  @override
  Future<void> resendVerifyCode() async {
    await _dio.get(
        ApiConstants.resendVerifyCode
    );
  }

}