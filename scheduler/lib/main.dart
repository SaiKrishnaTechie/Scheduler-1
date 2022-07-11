import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheduler/scheduler/scheduler.dart';
import 'package:scheduler/scheduler/bloc/bloc/scheduler_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => SchedulerBloc(),
    child: const MyApp(),

  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calendar(),debugShowCheckedModeBanner: false,
    );
  }
}
