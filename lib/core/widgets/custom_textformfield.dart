import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomTextformfield extends StatefulWidget {
  CustomTextformfield({
    super.key,
    required this.prefixIcon,
    this.hintTextStyle,
    this.hintText,
    this.obscureText = false,
    this.readOnly = false,
    this.controller,
    this.validator,
    required this.keyboardType,
    this.visibleSuffixIcon,
    this.inVisibleSuffixIcon,
  });

  final String prefixIcon;
  final String? visibleSuffixIcon;
  final String? inVisibleSuffixIcon;
  final String? hintText;
  bool obscureText;
  final bool readOnly;
  final TextStyle? hintTextStyle;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  @override
  State<CustomTextformfield> createState() => _CustomTextformfieldState();
}

class _CustomTextformfieldState extends State<CustomTextformfield> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // return Container(
    //   padding: EdgeInsets.all(15),
    //   height: height*0.06,
    //   decoration: BoxDecoration(
    //     color: AppColors.white,
    //     borderRadius: BorderRadius.circular(15),
    //     border: Border.all(width: 0.1, color: AppColors.waitingMedicineColor),
    //     boxShadow: [
    //       const BoxShadow(
    //         color: Colors.white,
    //         offset: Offset(-3, -3),
    //         blurRadius: 6,
    //       ),
    //       BoxShadow(
    //         color: Colors.black.withOpacity(0.2),
    //         offset: const Offset(3, 3),
    //         blurRadius: 6,
    //       ),
    //     ],
    //   ),
    //   child: TextFormField(
    //     validator:validator,
    //     controller: controller,
    //     readOnly: readOnly,
    //     obscureText: obscureText,
    //     keyboardType:keyboardType ,
    //     decoration: InputDecoration(
    //       prefixIconConstraints: BoxConstraints(maxWidth: width*0.05,),
    //       prefixIcon: Image.asset(prefixIcon,),
    //       suffixIconConstraints: BoxConstraints(maxWidth: width*0.06,),
    //       suffixIcon: suffixIcon == null ? null : Image.asset(suffixIcon!),
    //       hintText: hintText,
    //       hintStyle: hintTextStyle,
    //       border: InputBorder.none,
    //     ),
    //   ),
    // );
    return Material(
      elevation: 2,
      shadowColor: AppColors.waitingMedicineColor.withOpacity(0.5),
      borderRadius: BorderRadius.circular(15),
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          validator: widget.validator,
          controller: widget.controller,
          readOnly: widget.readOnly,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            prefixIconConstraints: BoxConstraints(maxWidth: width * 0.05),
            prefixIcon: Image.asset(widget.prefixIcon),
            suffixIconConstraints: BoxConstraints(maxWidth: width * 0.06),
            suffixIcon: widget.visibleSuffixIcon== null && widget.inVisibleSuffixIcon == null
                ? null
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.obscureText = !widget.obscureText;
                      });
                    },
                    child: Image.asset(
                      widget.obscureText
                          ? widget.visibleSuffixIcon!
                          : widget.inVisibleSuffixIcon!,
                    ),
                  ),
            hintText: widget.hintText,
            hintStyle: widget.hintTextStyle,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

InputBorder borderDecoration() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: AppColors.waitingMedicineColor, width: 0.3),
  );
}
