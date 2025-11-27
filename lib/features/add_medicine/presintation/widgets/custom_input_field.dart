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
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final double? formHeight;
  final double? formWidth;
  final double? horPadding;
  final double? verPadding;
  final double? dropdownHeight;
  final double? dropdownWidth;

  const CustomInputField({
    super.key,
    this.hint,
    this.isDropdown = false,
    this.items,
    this.maxLines = 1,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.controller,
    this.formHeight,
    this.formWidth,
    this.horPadding,
    this.verPadding,
    this.dropdownHeight,
    this.dropdownWidth,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isDropdown
              ? SizedBox(
            height: formHeight ??
                (maxLines == 2 ? height * 0.12 : height * 0.06),
            width: formWidth ?? width,
            child: DropdownButtonFormField2<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: horPadding ?? 24,
                  vertical: verPadding ?? 12,
                ),
                border: borderDecoration(),
              ),
              hint: Text(
                hint ?? AppTexts.selectFamilyMember,
                style: AppTextsStyle.montserratRegular18(
                  context,
                ).copyWith(fontSize: 14),
              ),
              iconStyleData: IconStyleData(
                icon: Icon(
                  Icons.keyboard_arrow_down_outlined,
                ),
                iconSize: 24,
              ),
              dropdownStyleData: DropdownStyleData(
                direction: DropdownDirection.textDirection,
                maxHeight: dropdownHeight ?? 150,
                width: dropdownWidth ?? 312,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(1, 2),
                    ),
                  ],
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
              validator: validator,
              items: items
                  ?.map(
                    (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ),
              )
                  .toList() ??
                  [],
              onChanged: onChanged,
              onSaved: onSaved,
            ),
          )
              : SizedBox(
            height: formHeight ??
                (maxLines == 2 ? height * 0.12 : height * 0.06),
            width: formWidth ?? width,
            child: TextFormField(
              controller: controller,
              maxLines: maxLines,
              onChanged: onChanged,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                hintStyle: AppTextsStyle.montserratRegular18(
                  context,
                ).copyWith(fontSize: 14),
                hintText: hint ?? '',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: horPadding ?? 24,
                  vertical: verPadding ?? (maxLines == 2 ? 24 : 12),
                ),
                border: borderDecoration(),
                enabledBorder: borderDecoration(),
                focusedBorder: borderDecoration(),
              ),
              validator: validator,
              onSaved: onSaved,
            ),
          ),
        ],
      ),
    );
  }
}

InputBorder borderDecoration() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: AppColors.medicineBorderColor.withOpacity(0.9),
      width: 0.5,
    ),
  );
}