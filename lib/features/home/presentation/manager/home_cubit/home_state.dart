part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoadingMore extends HomeState {}

final class HomeFailure extends HomeState {
  final String message;

  const HomeFailure(this.message);
}

final class HomeSuccess extends HomeState {}
