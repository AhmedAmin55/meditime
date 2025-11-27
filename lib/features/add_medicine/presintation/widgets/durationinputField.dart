import 'package:flutter/material.dart';
import 'package:meditime/features/add_medicine/presintation/widgets/custom_input_field.dart';

import '../../../../core/constants/app_colors.dart';

class DurationInputField extends StatefulWidget {
  final TextEditingController? numberController;
  final String? selectedUnit;
  final Function(String?)? onUnitChanged;
  final VoidCallback? onNumberChanged;

  const DurationInputField({
    super.key,
    this.numberController,
    this.selectedUnit,
    this.onUnitChanged,
    this.onNumberChanged,
  });

  @override
  State<DurationInputField> createState() => _DurationInputFieldState();
}

class _DurationInputFieldState extends State<DurationInputField> {
  String currentUnit = 'days';

  @override
  void initState() {
    super.initState();
    currentUnit = widget.selectedUnit ?? 'days';
  }

  @override
  void didUpdateWidget(DurationInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedUnit != null && widget.selectedUnit != currentUnit) {
      setState(() {
        currentUnit = widget.selectedUnit!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(left: 15, right: 10, top: 3),
      height: height * 0.055,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("i will take it for"),
          Spacer(),
          CustomInputField(
            controller: widget.numberController,
            formWidth: 50,
            formHeight: 40,
            horPadding: 10,
            verPadding: 0,
            hint: "00",
            onChanged: (value) {
              if (widget.onNumberChanged != null) {
                widget.onNumberChanged!();
              }
            },
          ),
          SizedBox(width: 10),
          CustomInputField(
            formWidth: 100,
            formHeight: 40,
            dropdownHeight: 120,
            dropdownWidth: 100,
            verPadding: 0,
            isDropdown: true,
            hint: currentUnit,
            items: ["days", "weeks", "months", "years"],
            horPadding: 0,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  currentUnit = value;
                });
                if (widget.onUnitChanged != null) {
                  widget.onUnitChanged!(value);
                }
              }
            },
          )
        ],
      ),
    );
  }
}