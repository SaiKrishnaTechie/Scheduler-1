import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scheduler/scheduler/model/scheduler_model.dart';
import 'package:scheduler/scheduler/schedular_repository.dart';
import 'package:scheduler/scheduler/scheduler_data_source.dart';

part 'scheduler_event.dart';
part 'scheduler_state.dart';

// class SchedulerBloc extends Bloc<SchedulerEvent, SchedulerState> {
//   SchedulerDataSource schedulerDataSource = SchedulerDataSource();
//   SchedulerRepo schedulerRepo = SchedulerRepo();
//   SchedulerBloc() : super(SchedulerInitial()) {

//     @override
//     Stream<SchedulerState> postSChedule(SchedulerEvent event) async* {
//       if (event is PostSchedulerEvent) {
//         yield* postScheduleState(schedulerModel: event.schedulerModel);
//       }
//     }
//  Stream<SchedulerState> postScheduleState(
//         {required SchedulerModel schedulerModel}) async* {
//       yield SchedulerLoading();

//       final dataResponse =
//           await schedulerRepo.postScheduler(schedulerModel: schedulerModel);

//       if (dataResponse.hasData) {
//         yield SchedulerSuccess();
//       } else {
//         yield SchedulerFailed(dataResponse.error ?? "can't place order");
//       }
//     }
//   }

// }
class SchedulerBloc extends Bloc<SchedulerEvent, SchedulerState> {
  SchedulerDataSource schedulerDataSource = SchedulerDataSource();
  SchedulerRepo schedulerRepo = SchedulerRepo();
  SchedulerBloc() : super(SchedulerInitial());

  @override
  Stream<SchedulerState> mapEventToState(SchedulerEvent event) async* {
    if (event is PostSchedulerEvent) {
      yield* postSchedulerState(schedulerModel: event.schedulerModel);
    }

    // if(event is GetInvoiceList){yield* }
  }

  Stream<SchedulerState> postSchedulerState({
    required SchedulerModel? schedulerModel,
  }) async* {
    yield SchedulerLoading();

    final dataResponse =
        await schedulerRepo.postScheduler(schedulerModel: schedulerModel);

    if (dataResponse.hasData) {
      yield SchedulerSuccess(dataResponse.data['msg']);
    } else {
      yield SchedulerFailed(dataResponse.error ?? "can't place order");
    }
  }
}
