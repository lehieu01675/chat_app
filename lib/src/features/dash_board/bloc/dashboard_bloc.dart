import 'package:chatapp/src/data/models/user_model.dart';
import 'package:chatapp/src/data/repositories/user_repo.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  UserRepository userRepository;

  DashboardBloc({required this.userRepository}) : super(DashboardLoading()) {
    on<DashboardGetCurrentUser>(_getCurrentUser);
    on<DashboardUpdateUserStatus>(_updateUserStatus);
  }

  Future<void> _updateUserStatus(
      DashboardUpdateUserStatus event, Emitter<DashboardState> emit) async {
    try {
      await userRepository.updateUserStatus(status: event.status);
    } catch (e) {
      emit(DashboardError(error: e.toString()));
    }
  }

  /// get c
  Future<void> _getCurrentUser(
      DashboardGetCurrentUser event, Emitter<DashboardState> emit) async {
    try {
      var user = await userRepository.getCurrentUser();
      emit(DashboardGetCurrentUserSuccess(currentUser: user!));
    } catch (e) {
      emit(DashboardError(error: e.toString()));
    }
  }
}
