// home_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/features/home/presentation/views/widgets/tab_controller_mixin.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with TabControllerManager {
  HomeCubit() : super(HomeInitial());

  // Add methods to control tabs if needed
  void changeTab(int index) {
    tabController?.animateTo(index);
  }
}
