part of 'signup_cubit.dart';

sealed class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupUpdate extends SignupState {}

final class SignupFailure extends SignupState {
  final String errorMessage;
  const SignupFailure({required this.errorMessage});
}

final class SignupSuccess extends SignupState {}
