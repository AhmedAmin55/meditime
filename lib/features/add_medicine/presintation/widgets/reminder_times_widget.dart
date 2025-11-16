import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meditime/core/constants/app_colors.dart';


class ReminderTimesWidget extends StatefulWidget {
  const ReminderTimesWidget({super.key});

  @override
  State<ReminderTimesWidget> createState() => _ReminderTimesWidgetState();
}

class _ReminderTimesWidgetState extends State<ReminderTimesWidget> {
  List<Map<String, dynamic>> _reminderTimes = [
    {
      'hour': '08',
      'minute': '00',
      'period': 'AM',
    },
  ];

  void _addReminderTime() {
    setState(() {
      _reminderTimes.add({
        'hour': '08',
        'minute': '00',
        'period': 'AM',
      });
    });
  }

  void _removeReminderTime(int index) {
    if (_reminderTimes.length > 1) {
      setState(() {
        _reminderTimes.removeAt(index);
      });
    }
  }

  void _togglePeriod(int index) {
    setState(() {
      _reminderTimes[index]['period'] =
      _reminderTimes[index]['period'] == 'AM' ? 'PM' : 'AM';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Reminder Times",
          // style: GoogleFonts.poppins(
          //   fontSize: 16,
          //   fontWeight: FontWeight.w500,
          //   color: Colors.black.withOpacity(0.7),
          // ),
        ),
        const SizedBox(height: 12),

        // Display reminder times
        ...List.generate(_reminderTimes.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                // Time field container
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
                        // Hour input
                        SizedBox(
                          width: 40,
                          child: TextField(
                            controller: TextEditingController(
                              text: _reminderTimes[index]['hour'],
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(2),
                            ],
                            // style: GoogleFonts.poppins(
                            //   fontSize: 14,
                            //   color: Colors.black87,
                            //   fontWeight: FontWeight.w400,
                            // ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '08',
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                int hour = int.tryParse(value) ?? 8;
                                if (hour > 12) hour = 12;
                                if (hour < 1) hour = 1;
                                _reminderTimes[index]['hour'] =
                                    hour.toString().padLeft(2, '0');
                              }
                            },
                          ),
                        ),
                        Text(
                          ':',
                          // style: GoogleFonts.poppins(
                          //   fontSize: 14,
                          //   color: Colors.black87,
                          //   fontWeight: FontWeight.w400,
                          // ),
                        ),
                        // Minute input
                        SizedBox(
                          width: 40,
                          child: TextField(
                            controller: TextEditingController(
                              text: _reminderTimes[index]['minute'],
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(2),
                            ],
                            // style: GoogleFonts.poppins(
                            //   fontSize: 14,
                            //   color: Colors.black87,
                            //   fontWeight: FontWeight.w400,
                            // ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '00',
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                int minute = int.tryParse(value) ?? 0;
                                if (minute > 59) minute = 59;
                                if (minute < 0) minute = 0;
                                _reminderTimes[index]['minute'] =
                                    minute.toString().padLeft(2, '0');
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        // AM/PM toggle
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
                              _reminderTimes[index]['period'],
                              // style: GoogleFonts.poppins(
                              //   fontSize: 14,
                              //   color: AppColors.splashScreenColor,
                              //   fontWeight: FontWeight.w500,
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Delete button
                if (_reminderTimes.isNotEmpty)
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

        // Add new time button
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