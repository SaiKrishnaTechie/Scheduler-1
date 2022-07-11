part of 'scheduler_bloc.dart';

@immutable
abstract class SchedulerState {}

class SchedulerInitial extends SchedulerState {}

class SchedulerLoading extends SchedulerState {}

class SchedulerSuccess extends SchedulerState {
  final String msg;
  SchedulerSuccess(this.msg);
}

class SchedulerFailed extends SchedulerState {
  final String errror;

  SchedulerFailed(this.errror);
}
