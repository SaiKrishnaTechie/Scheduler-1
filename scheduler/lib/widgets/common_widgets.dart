// ignore_for_file: prefer_const_constructors

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputTimePicker extends StatefulWidget {
  final String? label;
  final TextEditingController controller;
  final DateTime? initialValue;
  final Function(String?) onSubmit;
  // final String label;
  InputTimePicker({
    Key? key,
    this.label,
    required this.controller,
    this.initialValue,
    // required this.label,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _InputTimePickerState createState() => _InputTimePickerState();
}

class _InputTimePickerState extends State<InputTimePicker> {
  @override
  Widget build(BuildContext context) {
    var time;
    return ListTile(
      onTap: () async {
        time = await showTimePicker(
          initialTime: TimeOfDay.now(),
          context: context,
        );
        widget.controller.text = time?.format(context);
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: 2,
      ),
      leading: null,

      title: Container(
        padding: EdgeInsets.all(3),
        color: Colors.blue.shade200.withOpacity(0.6),
        width: 220,
        height: 50,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "${widget.label}",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 100,
            ),
            Expanded(
              child: TextField(
                onTap: () async {
                  time = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );
                  widget.controller.text = time?.format(context);
                },
                controller: widget.controller,
                readOnly: true, onSubmitted: widget.onSubmit,
                // controller: widget.controller,
                style: TextStyle(fontSize: 12),
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: widget.initialValue?.toString().split(" ")[0],
                    isDense: true,
                    alignLabelWithHint: true,
                    // focusedBorder:
                    border: InputBorder.none),
              ),
            ),
            Icon(Icons.keyboard_arrow_right)
          ],
        ),
      ),
      // trailing: Icon(Icons.keyboard_arrow_right),
    );
  }
}

class BuildDateFormField extends StatefulWidget {
  final Function(String)? changeDate;
  final String label;
  final DateTime? initialValue;
  final bool enable;
  final bool required;
  final FormFieldSetter<DateTime>? onSaved;
  final DateFormat? format;
  final TextEditingController? controller;
  const BuildDateFormField(
      {Key? key,
      this.changeDate,
      required this.label,
      this.enable = true,
      this.required = false,
      this.onSaved,
      this.format,
      this.initialValue,
      this.controller})
      : super(key: key);

  @override
  _BuildDateFormFieldState createState() => _BuildDateFormFieldState();
}

class _BuildDateFormFieldState extends State<BuildDateFormField> {
  String finalTime = "";
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        finalTime = selectedDate.day.toString() +
            "/" +
            selectedDate.month.toString() +
            "/" +
            selectedDate.year.toString();

        // print("final time is$finalTime");
        widget.changeDate!(finalTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final mFormat = DateFormat("12,08,2021");
    final mFormat =
        widget.format ?? DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
    return Expanded(
        child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
            leading: null,
            title: Container(
              color: Colors.blue.shade200.withOpacity(0.6),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Date",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Expanded(
                    child: DateTimeField(
                      // initialValue: widget.initialValue,
                      controller: widget.controller,
                      enabled: widget.enable,
                      validator: (value) => value == null ? "* required" : null,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 16),
                          labelStyle: TextStyle(color: Colors.black),
                          // labelText: widget.initialValue?.toString().split(" ")[0],
                          isDense: true,
                          label: null,
                          alignLabelWithHint: true,
                          border: InputBorder.none),
                      format: mFormat,
                      style: TextStyle(fontSize: 12),
                      onChanged: widget.onSaved,
                      onShowPicker:
                          (BuildContext context, DateTime? currentValue) async {
                        _selectDate(context);
                      },
                      //  onFieldSubmitted: widget.onSaved,
                      // onShowPicker: (context, currentValue) async {
                      //   DateTime? date;
                      //   if (widget.enable)

                      //     // date = await showDatePicker(
                      //     //     context: context,
                      //     //     firstDate: DateTime(1900),
                      //     //     initialDate: currentValue ?? DateTime.now(),
                      //     //     lastDate: DateTime(2100));
                      //   // if (date != null) {

                      //   return date;
                      //   // }
                      // }
                    ),
                  ),
                ],
              ),
            )));
  }
}

class LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color? color, textColor;
  final TextStyle? textStyle;

  const LoginButton({
    required this.label,
    Key? key,
    this.onPressed,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.textStyle,
  }) : super(key: key);

  ButtonStyle get _buttonStyle => ElevatedButton.styleFrom(
        onPrimary: textColor,
        textStyle: textStyle,
        primary: color,
        elevation: 0,
        minimumSize: const Size(50, 60),
        fixedSize: const Size(300, 40),
        // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(3))),
      );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: _buttonStyle,
      onPressed: onPressed,
      child: FittedBox(
        child: Text(
          label,
        ),
      ),
    );
  }
}

showSnackBar(
  BuildContext context, {
  required String message,
  required Color color,
  IconData icon = Icons.done_all_outlined,
  bool autoDismiss = true,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
        SnackBar(
      duration: autoDismiss ? Duration(seconds: 3) : Duration(days: 4),
      padding: EdgeInsets.all(0),
      content: Container(
        padding: EdgeInsets.all(10),
        color: Colors.black,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  message,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  //  style: TextStyle(color: Palette.DARK)
                ),
              ),
            ),
            Icon(
              icon,
              color: Colors.white,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    ));
}

SnackBar snackBar({
  required String message,
  required Color color,
  required Widget icon,
  bool autoDismiss = true,
}) {
  return SnackBar(
    duration: autoDismiss ? Duration(seconds: 1) : Duration(days: 1),
    content: Row(
      children: [
        Expanded(
          child: Text(
            message,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        icon,
      ],
    ),
    backgroundColor: color,
  );
}
