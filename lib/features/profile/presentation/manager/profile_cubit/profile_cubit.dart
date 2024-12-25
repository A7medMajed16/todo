import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/features/profile/data/models/profile_model.dart';
import 'package:todo/features/profile/data/repos/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepo) : super(ProfileInitial());

  final ProfileRepo _profileRepo;
  Future<void> getProfileData() async {
    emit(ProfileLoading());
    var result = await _profileRepo.getProfileData();
    result.fold(
      (failure) =>
          !isClosed ? emit(ProfileFailure(failure.errorMessage)) : null,
      (profileData) => !isClosed ? emit(ProfileSuccess(profileData)) : null,
    );
  }
}
