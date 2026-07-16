import 'package:bloc/bloc.dart';
import 'package:bookia_store/features/user/domain/usecases/update_profile_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../Authentication/domain/entities/user_entity.dart';
import '../../domain/usecases/change_password_use_case.dart';
import '../../domain/usecases/delete_account_use_case.dart';
import '../../domain/usecases/get_profile_use_case.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  final ChangePasswordUseCase updatePasswordUseCase;

  ProfileCubit({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.deleteAccountUseCase,
    required this.updatePasswordUseCase,
  }) : super(ProfileInitial());

  UserEntity? curntUser;

  Future<void> getProfile() async {
    emit(GetProfileLoading());
    final result = await getProfileUseCase();

    result.fold((failure) => emit(GetProfileError(failure.message)), (user) {
      curntUser = user;
      emit(GetProfileSuccess(user));
    });
  }

  Future<void> updateProfile(UpdateProfileParams params) async {
    emit(UpdateProfileLoading());

    final result= await updateProfileUseCase(params);

    result.fold(
        (failure)=> emit(UpdateProfileError(failure.message)),
        (user){
          curntUser=user;
          emit(UpdateProfileSuccess(user));
        }
    );
  }

  Future<void> deleteProfile() async {
    emit(DeleteProfileLoading());
    final result =await deleteAccountUseCase();

    result.fold((failure)=>emit(DeleteProfileError(failure.message)),
        (unit)=>emit(DeleteProfileSuccess())
    );
  }

  Future<void> updatePassword(ChangePasswordParams params) async {
    emit(UpdatePasswordLoading());

    final result= await updatePasswordUseCase(params);

    result.fold(
        (failure)=> emit(UpdatePasswordError(failure.message)),
        (unit)=>emit(UpdatePasswordSuccess())
    );
  }
}
