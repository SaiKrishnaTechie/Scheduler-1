import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'scheduler_model.g.dart';
@JsonSerializable()
class SchedulerModel extends Equatable {
  final String? name;
  final String? startTime;
   final String? endTime;
    final String? date;
 final String? phoneNumber;

  SchedulerModel({
    this.endTime,
    this.name,
    this.startTime,
    this.date,
    this.phoneNumber,
   
  });

  @override
  List<Object> get props => [];

  factory SchedulerModel.fromJson(Map<String, dynamic> json) =>
      _$SchedulerModelFromJson(json);

  Map<String, dynamic> toJson() => _$SchedulerModelToJson(this);
}
