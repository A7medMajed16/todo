part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileFailure extends ProfileState {
  final String message;

  const ProfileFailure(this.message);
}

final class ProfileSuccess extends ProfileState {
  final ProfileModel profileModel;

  const ProfileSuccess(this.profileModel);
}
