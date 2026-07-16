part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}
///initial state for profile
final class ProfileInitial extends ProfileState {}

///get profile state
class GetProfileLoading extends ProfileState {}

class GetProfileSuccess extends ProfileState {
  final ProfileEntity user;

  GetProfileSuccess(this.user);
}

class GetProfileError extends ProfileState {
  final String message;

  GetProfileError(this.message);
}
///update profile state
class UpdateProfileLoading extends ProfileState {}

class UpdateProfileSuccess extends ProfileState {
  final ProfileEntity user;
  UpdateProfileSuccess(this.user);
}

class UpdateProfileError extends ProfileState {
  final String message;
  UpdateProfileError(this.message);
}

///delete profile state
class DeleteProfileLoading extends ProfileState {}

class DeleteProfileSuccess extends ProfileState {}

class DeleteProfileError extends ProfileState {
  final String message;
  DeleteProfileError(this.message);
}

///update password state
class UpdatePasswordLoading extends ProfileState {}

class UpdatePasswordSuccess extends ProfileState {}

class UpdatePasswordError extends ProfileState {
  final String message;
  UpdatePasswordError(this.message);
}