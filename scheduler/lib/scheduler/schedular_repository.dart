import 'package:scheduler/scheduler/model/scheduler_model.dart';
import 'package:scheduler/scheduler/scheduler_data_source.dart';
import 'package:scheduler/utils/data_reposnse.dart';

class SchedulerRepo {
  SchedulerDataSource _dataSource = SchedulerDataSource();

  Future<DataResponse> postScheduler({
    required SchedulerModel? schedulerModel,
  }) async {
    final restAPIresponse = await _dataSource.postScheduler(
     schedulerModel: schedulerModel
    );

    try {
     
      if (restAPIresponse.data1) {
        return DataResponse(
          data: restAPIresponse.data1,
        );
      } else {
        return DataResponse(
          error: restAPIresponse.data2 ?? "",
        );
      }
    } catch (e) {
      print("implement Error conersion Text" + e.toString());
    }
    return DataResponse(
      error: restAPIresponse.data2 ?? "",
    );
  }
}
