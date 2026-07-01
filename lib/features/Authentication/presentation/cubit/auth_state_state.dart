part of 'auth_state_cubit.dart';

@immutable
sealed class AuthState{}

//initial state
final class AuthStateInitial extends AuthState {}

//loading state
final class AuthStateLoading extends AuthState{}

//success state
final class AuthStateSuccess extends AuthState{
  final UserEntity user;
  AuthStateSuccess(this.user);
}

//error state
final class AuthStateError extends AuthState{
  final String message;
  AuthStateError(this.message);
}

//verify success state
class AuthStateVerifySuccess extends AuthState {}

//resend success state
class AuthStateResendSuccess extends AuthState {}
