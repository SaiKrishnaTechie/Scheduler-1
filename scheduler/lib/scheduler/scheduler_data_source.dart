import 'package:dio/dio.dart';
import 'package:scheduler/scheduler/model/scheduler_model.dart';
import 'package:scheduler/utils/data_reposnse.dart';

class SchedulerDataSource {
  Dio client = Dio();

  Future<DoubleResponse> postScheduler({
    required SchedulerModel? schedulerModel,
  }) async {
    print(schedulerModel!.date);
    print(schedulerModel.endTime!.split('(')[1].replaceAll(")", ""));
    print(schedulerModel.startTime.toString());
    String path = "https://alpha.classaccess.io/api/challenge/v1/save/schedule";
    final response = await client.post(
      path,
      data: {
        "name": schedulerModel.name,
        "startTime":
            schedulerModel.startTime!.split('(')[1].replaceAll(")", ""),
        "endTime": schedulerModel.endTime!.split('(')[1].replaceAll(")", ""),
        "date": schedulerModel.date,
        "phoneNumber": "8921423269"
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    print(response.data['msg']);
    print(response.data['status']);
    return DoubleResponse(response.data['status'] == true,
        response.data['msg']);
  }
}
