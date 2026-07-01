import 'package:bookia_store/features/Authentication/domain/repositories/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/resend_verify_code_usecase.dart';
import '../../domain/usecases/verify_email_usecase.dart';
part 'auth_state_state.dart';

class AuthCubit extends Cubit<AuthState> {
  //inject usecases
  final LoginUsecase loginUseCase;
  final RegisterUsecase registerUseCase;
  final VerifyEmailUsecase verifyEmailUsecase;
  final ResendVerifyCodeUseCase resendVerifyCodeUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.verifyEmailUsecase,
    required this.resendVerifyCodeUseCase,
  }) : super(AuthStateInitial());

  //login function
  Future<void> login({required String email, required String password}) async {
    emit(AuthStateLoading());
    final result = await loginUseCase(email: email, password: password);
    result.fold(
      (failure) {
        emit(AuthStateError(failure.message));
      },
      (userEntity) {
        emit(AuthStateSuccess(userEntity));
      },
    );
  }

  //register function
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(AuthStateLoading());

    final result = await registerUseCase(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    result.fold(
      (failure) {
        emit(AuthStateError(failure.message));
      },
      (userEntity) {
        emit(AuthStateSuccess(userEntity));
      },
    );
  }

  //verify email function
  Future<void> verifyEmail({required String email, required String otp}) async {
    emit(AuthStateLoading());
    final result = await verifyEmailUsecase(email: email, otp: otp);
    result.fold(
      (failure) {
        emit(AuthStateError(failure.message));
      },
      (_) {
        emit(AuthStateVerifySuccess());
      },
    );
  }

  //resend verify code function
  Future<void> resendVerifyCode() async {
    emit(AuthStateLoading());
    final result = await resendVerifyCodeUseCase();
    result.fold(
          (failure) => emit(AuthStateError(failure.message)),
          (_) => emit(AuthStateResendSuccess()),
    );
  }
}
