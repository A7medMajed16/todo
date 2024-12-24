part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginFailure extends LoginState {
  final String errorMessage;

  const LoginFailure(this.errorMessage);
}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LogoutLoading extends LoginState {}

final class LogoutFailure extends LoginState {
  final String errorMessage;

  const LogoutFailure(this.errorMessage);
}

final class LogoutSuccess extends LoginState {}
