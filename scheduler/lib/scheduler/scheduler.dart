import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scheduler/event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scheduler/scheduler/bloc/bloc/scheduler_bloc.dart';
import 'package:scheduler/scheduler/model/scheduler_model.dart';
import 'package:scheduler/widgets/common_widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  TextEditingController name = TextEditingController();
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  String finalDate = "";
  void changeDate(String val) {
    finalDate = val;
    setState(() {});
    // print("time at scheduler is $finalDate");
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SchedulerBloc, SchedulerState>(
      listener: (context, state) {
        if (state is SchedulerLoading) {
          showSnackBar(context,
              message: "Loading...",
              color: Colors.white,
              // icon: HomeSvg().SnackbarIcon,
              autoDismiss: true);
          Navigator.pop(context);
        }
        if (state is SchedulerSuccess) {
          showSnackBar(context,
              message: state.msg,
              color: Colors.white,
              // icon: HomeSvg().SnackbarIcon,
              autoDismiss: true);
          Navigator.pop(context);
        }
        if (state is SchedulerFailed) {
          showSnackBar(context,
              message: state.errror,
              color: Colors.white,
              // icon: HomeSvg().SnackbarIcon,
              autoDismiss: true);
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("ESTech Calendar"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TableCalendar(
              focusedDay: selectedDay,
              firstDay: DateTime(1990),
              lastDay: DateTime(2050),
              calendarFormat: CalendarFormat.week,
              // onFormatChanged: (CalendarFormat _format) {
              //   setState(() {
              //     format = _format;
              //   });
              // },
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekVisible: true,

              //Day Changed
              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                });
                print(focusedDay);
              },
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },

              eventLoader: _getEventsfromDay,

              //To style the Calendar
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                defaultDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                weekendDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonShowsNext: false,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                formatButtonTextStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ..._getEventsfromDay(selectedDay).map(
              (Event event) => ListTile(
                title: Text(
                  event.title,
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Add Schedule"),
              content: BottomSheet(
                  onClosing: () {},
                  builder: (context) => SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name"),
                            Container(
                              color: Colors.blue.shade200.withOpacity(0.6),
                              child: TextFormField(
                                controller: name,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Date & Time"),
                            InputTimePicker(
                              controller: TextEditingController(
                                text: DateTime.tryParse(startTime.toString())
                                    .toString(),
                              ),
                              label: "Start Time",
                              onSubmit: (p0) {},
                              initialValue:
                                  DateTime.tryParse(selectedTime.toString()),
                            ),
                            InputTimePicker(
                              controller: TextEditingController(
                                text: DateTime.tryParse(endTime.toString())
                                    .toString(),
                              ),
                              label: "End Time",
                              onSubmit: (p0) {},
                              initialValue:
                                  DateTime.tryParse(selectedTime.toString()),
                            ),
                            BuildDateFormField(
                              controller:
                                  TextEditingController(text: finalDate),
                              changeDate: changeDate,
                              label: "      ",
                            )
                          ],
                        ),
                      )),

              // TextFormField(
              //   controller: _eventController,
              // ),
              actions: [
                LoginButton(
                  label: "Add Schedule",
                  color: const Color(0xFF086DB5),
                  textStyle: TextStyle(fontSize: 13),
                  onPressed: () {
                    BlocProvider.of<SchedulerBloc>(context)
                        .add(PostSchedulerEvent(
                            schedulerModel: SchedulerModel(
                      date: finalDate,
                      endTime: endTime.toString(),
                      startTime: startTime.toString(),
                      name: name.text,
                    )));
                  },
                ),
                // TextButton(
                //   child: Text("Ok"),
                //   onPressed: () {
                //     print("hereeeeeeeeee");

                //     BlocProvider.of<SchedulerBloc>(context)
                //         .add(PostSchedulerEvent(
                //             schedulerModel: SchedulerModel(
                //       date: finalDate,
                //       endTime: endTime.toString(),
                //       startTime: startTime.toString(),
                //       name: name.text,
                //     )));
                //     print("anddddddddd");
                //     if (_eventController.text.isEmpty) {
                //     } else {
                //       if (selectedEvents[selectedDay] != null) {
                //         BlocProvider.of<SchedulerBloc>(context).add(
                //             PostSchedulerEvent(
                //                 schedulerModel: SchedulerModel(
                //                     date: "21/07/2022",
                //                     endTime: "22:40:28",
                //                     startTime: "20:40:28",
                //                     name: "New event",
                //                     phoneNumber: "8921423269")));
                //         selectedEvents[selectedDay]!.add(
                //           Event(title: _eventController.text),
                //         );
                //       } else {
                //         selectedEvents[selectedDay] = [
                //           Event(title: _eventController.text)
                //         ];
                //       }
                //     }
                //     Navigator.pop(context);
                //     _eventController.clear();
                //     setState(() {});
                //     return;
                //   },
              ],
            ),
          ),
          label: Text(""),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
