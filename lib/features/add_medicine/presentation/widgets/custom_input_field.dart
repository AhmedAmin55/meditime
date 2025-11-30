import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:meditime/core/constants/app_colors.dart';
import 'package:meditime/core/constants/app_texts.dart';
import 'package:meditime/core/constants/app_textstyle.dart';

class CustomInputField extends StatelessWidget {
  final String? hint;
  final bool isDropdown;
  final List<String>? items;
  final int maxLines;
  final FormFieldSetter<String>? onChange;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final double? formHeight;
  final double? formWidth;
  final double? horPadding;
  final double? verPadding;
  final double? dropdownHeight;
  final double? dropdownWidth;
  final bool? enableBorder;

  const CustomInputField({
    super.key,
    this.hint,
    this.isDropdown = false,
    this.items,
    this.maxLines = 1,
    this.onChange,
    this.validator,
    this.controller,
    this.formHeight,
    this.formWidth,
    this.horPadding,
    this.verPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.enableBorder,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // لو Dropdown → نجيب القيمة الحالية من الـ controller
    final String? currentValue = isDropdown && controller != null
        ? (controller!.text.isEmpty ? items?.first : controller!.text)
        : null;

    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: isDropdown
          ? SizedBox(
        height: formHeight ?? 56,
        width: formWidth ?? width,
        child: DropdownButtonFormField2<String>(
          value: currentValue, // ← ده اللي كان ناقص وسبب المشكلة كلها!
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: horPadding ?? 20,
              vertical: verPadding ?? 16,
            ),
            border: borderDecoration(),
            enabledBorder: borderDecoration(),
            focusedBorder: borderDecoration(),
          ),
          hint: Text(
            hint ?? "Select",
            style: AppTextsStyle.montserratRegular18(context).copyWith(fontSize: 14, color: Colors.grey),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.splashScreenColor),
            iconSize: 28,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: dropdownHeight ?? 200,
            width: dropdownWidth ?? width - 64,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(height: 48),
          items: items
              ?.map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(item, style: const TextStyle(fontSize: 14)),
          ))
              .toList(),
          onChanged: (value) {
            if (value != null && controller != null) {
              controller!.text = value; // نحدث الـ controller
            }
            onChange?.call(value);
          },
          validator: validator,
        ),
      )
          : SizedBox(
        height: formHeight ?? (maxLines > 1 ? null : 56),
        width: formWidth ?? width,
        child: TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            hintText: hint ?? '',
            hintStyle: AppTextsStyle.montserratRegular18(context).copyWith(fontSize: 14, color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(
              horizontal: horPadding ?? 20,
              vertical: verPadding ?? (maxLines > 1 ? 16 : 16),
            ),
            border: enableBorder == true ? borderDecoration() : InputBorder.none,
            enabledBorder: enableBorder == true ? borderDecoration() : InputBorder.none,
            focusedBorder: enableBorder == true ? borderDecoration() : InputBorder.none,
          ),
          validator: validator,
          onChanged: onChange,
        ),
      ),
    );
  }

  InputBorder borderDecoration() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.medicineBorderColor.withOpacity(0.9),
        width: 0.8,
      ),
    );
  }
}