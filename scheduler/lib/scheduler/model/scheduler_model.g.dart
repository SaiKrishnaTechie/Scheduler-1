part of 'scheduler_model.dart';
SchedulerModel _$SchedulerModelFromJson(Map<String, dynamic> json) => SchedulerModel(
    
      name: json['name'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      date: json['date'] as String?,
     
    );

Map<String, dynamic> _$SchedulerModelToJson(SchedulerModel instance) => <String, dynamic>{
      'startTime': instance.startTime,
      'name': instance.name,
      'endTime': instance.endTime,
      'phoneNumber': instance.phoneNumber,

      'date': instance.date,
      
    };
