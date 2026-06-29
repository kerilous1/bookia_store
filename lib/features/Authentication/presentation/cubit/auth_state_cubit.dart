import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
part 'auth_state_state.dart';

class AuthCubit extends Cubit<AuthState> {
  //inject usecases
  final LoginUsecase loginUseCase;
  final RegisterUsecase registerUseCase;
  
  
  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
  }) :super(AuthStateInitial());
  
  //login function
  Future<void> login({
    required String email,
    required String password,
})async {
    emit(AuthStateLoading());
    final result=await loginUseCase(email: email, password: password);
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

    final result=await registerUseCase(
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
  
}
