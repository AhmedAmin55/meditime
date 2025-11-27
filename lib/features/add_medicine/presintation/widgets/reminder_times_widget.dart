import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meditime/core/constants/app_colors.dart';

class ReminderTimesWidget extends StatefulWidget {
  final List<Map<String, dynamic>> reminderTimes;
  final Function(List<Map<String, dynamic>>) onTimesChanged;

  const ReminderTimesWidget({
    super.key,
    required this.reminderTimes,
    required this.onTimesChanged,
  });

  @override
  State<ReminderTimesWidget> createState() => _ReminderTimesWidgetState();
}

class _ReminderTimesWidgetState extends State<ReminderTimesWidget> {
  void _addReminderTime() {
    setState(() {
      widget.reminderTimes.add({
        'hour': '08',
        'minute': '00',
        'period': 'AM',
      });
    });
    widget.onTimesChanged(widget.reminderTimes);
  }

  void _removeReminderTime(int index) {
    if (widget.reminderTimes.length > 1) {
      setState(() {
        widget.reminderTimes.removeAt(index);
      });
      widget.onTimesChanged(widget.reminderTimes);
    }
  }

  void _togglePeriod(int index) {
    setState(() {
      widget.reminderTimes[index]['period'] =
      widget.reminderTimes[index]['period'] == 'AM' ? 'PM' : 'AM';
    });
    widget.onTimesChanged(widget.reminderTimes);
  }

  void _updateHour(int index, String value) {
    if (value.isNotEmpty) {
      int hour = int.tryParse(value) ?? 8;
      if (hour > 12) hour = 12;
      if (hour < 1) hour = 1;
      setState(() {
        widget.reminderTimes[index]['hour'] = hour.toString().padLeft(2, '0');
      });
      widget.onTimesChanged(widget.reminderTimes);
    }
  }

  void _updateMinute(int index, String value) {
    if (value.isNotEmpty) {
      int minute = int.tryParse(value) ?? 0;
      if (minute > 59) minute = 59;
      if (minute < 0) minute = 0;
      setState(() {
        widget.reminderTimes[index]['minute'] = minute.toString().padLeft(2, '0');
      });
      widget.onTimesChanged(widget.reminderTimes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Reminder Times",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 12),

        ...List.generate(widget.reminderTimes.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Container(
                  width: 312 - 16 - 84,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromRGBO(232, 232, 232, 0.9),
                      width: 0.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 40,
                          child: TextField(
                            controller: TextEditingController(
                              text: widget.reminderTimes[index]['hour'],
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(2),
                            ],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '08',
                            ),
                            onChanged: (value) => _updateHour(index, value),
                          ),
                        ),
                        Text(
                          ':',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          child: TextField(
                            controller: TextEditingController(
                              text: widget.reminderTimes[index]['minute'],
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(2),
                            ],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '00',
                            ),
                            onChanged: (value) => _updateMinute(index, value),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => _togglePeriod(index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.splashScreenColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              widget.reminderTimes[index]['period'],
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.splashScreenColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                if (widget.reminderTimes.isNotEmpty)
                  InkWell(
                    onTap: () => _removeReminderTime(index),
                    child: Container(
                      width: 84,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromRGBO(232, 232, 232, 0.9),
                          width: 0.5,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),

        Container(
          width: 312,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color.fromRGBO(232, 232, 232, 0.9),
              width: 0.5,
            ),
          ),
          child: InkWell(
            onTap: _addReminderTime,
            child: Center(
              child: Icon(
                Icons.add,
                color: AppColors.splashScreenColor,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}