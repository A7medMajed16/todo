part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeFailure extends HomeState {
  final String message;

  const HomeFailure(this.message);
}

final class HomeSuccess extends HomeState {
  final List<TaskModel> tasks;

  const HomeSuccess(this.tasks);
}
