import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:medilab_prokit/providers/appointment_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:medilab_prokit/utils/MLColors.dart';
import 'package:medilab_prokit/screens/MLBookAppointmentScreen.dart';

class CalendarComponent extends StatefulWidget {
  final callChildMethodController controller;
  CalendarComponent({required this.controller});
  @override
  _CalendarComponentState createState() => _CalendarComponentState(controller);
}

class _CalendarComponentState extends State<CalendarComponent> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  _CalendarComponentState(callChildMethodController _controller) {
    _controller.method = returnDateTime;
  }

  dynamic returnDateTime() {
    context.read<AppointmentProvider>().changeDateTime(
        newDateTime: (DateFormat('dd-MM-yyyy').format(_selectedDay) +
            " " +
            _selectedTime.format(context)));
  }

  Future<void> _selectTime(BuildContext context, DateTime? _selectedDay) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
            primaryColor: mlPrimaryColor,
            colorScheme: ColorScheme.light(primary: mlPrimaryColor),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            timePickerTheme: TimePickerThemeData(
              dayPeriodBorderSide: BorderSide.none,
              dayPeriodColor: Colors.white,
              dayPeriodTextColor: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.selected)
                      ? mlPrimaryColor
                      : Colors.grey),
            )),
        child: child!,
      ),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          // Enable to select days 5 days from now
          firstDay: DateTime.now(),
          // firstDay: DateTime.now().add(Duration(days: 5)),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            // Use `selectedDayPredicate` to determine which day is currently selected.
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              // Call `setState()` when updating the selected day
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });

              _selectTime(context, _selectedDay);
            }
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              // Call `setState()` when updating calendar format
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            // No need to call `setState()` here
            _focusedDay = focusedDay;
          },
          calendarStyle: CalendarStyle(
            isTodayHighlighted: false,
            selectedDecoration: BoxDecoration(
              color: mlPrimaryColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              TextFormField(
                controller: TextEditingController(
                    text: DateFormat('dd-MM-yyyy').format(_selectedDay)),
                decoration: InputDecoration(
                  labelText: 'Selected Date',
                ),
                readOnly: true,
              ),
              TextFormField(
                controller:
                    TextEditingController(text: _selectedTime.format(context)),
                decoration: InputDecoration(
                  labelText: 'Selected Time',
                ),
                readOnly: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
