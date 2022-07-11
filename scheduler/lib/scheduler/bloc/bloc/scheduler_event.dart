part of 'scheduler_bloc.dart';

abstract class SchedulerEvent extends Equatable {
  const SchedulerEvent();

  @override
  List<Object> get props => [];
}

class PostSchedulerEvent extends SchedulerEvent {
  final SchedulerModel schedulerModel;

  PostSchedulerEvent({
    required this.schedulerModel,
  });
}
