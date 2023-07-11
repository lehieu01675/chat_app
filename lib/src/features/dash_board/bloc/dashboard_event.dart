part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class DashboardGetCurrentUser extends DashboardEvent {}

class DashboardUpdateUserStatus extends DashboardEvent {
  final bool status;

  const DashboardUpdateUserStatus({required this.status});
  @override
  List<Object> get props => [status];
}
