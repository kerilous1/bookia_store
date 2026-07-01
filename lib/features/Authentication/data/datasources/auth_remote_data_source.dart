import '../models/user_model.dart';

abstract class AuthRemoteDataSource {

  //login function
  Future<UserModel> login({
    required String email,
    required String password,
  });

  //register function
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  });

  //verify email function
  Future<void> verifyEmail({
    required String email,
    required String otp,
});
  //resend verify code function
  Future<void> resendVerifyCode();

}