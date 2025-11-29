import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../business_logic/add_medicine_cubit/add_medicine_cubit.dart';
import 'custom_input_field.dart';
//
// class CustomizeDaysWidget extends StatefulWidget {
//   const CustomizeDaysWidget({super.key});
//
//   @override
//   State<CustomizeDaysWidget> createState() => _CustomizeDaysWidgetState();
// }
//
// class _CustomizeDaysWidgetState extends State<CustomizeDaysWidget> {
//   String selectedOption = 'Every sunday';
//   bool isDropdownOpen = false;
//   final LayerLink _layerLink = LayerLink();
//   OverlayEntry? _overlayEntry;
//
//   final List<String> dayOptions = [
//     'Everyday',
//     'Every saturday',
//     'Every sunday',
//     'Every monday',
//     'Every tuesday',
//     'Every wednesday',
//     'Every thursday',
//     'Every friday',
//   ];
//
//   OverlayEntry _createOverlayEntry() {
//     RenderBox renderBox = context.findRenderObject() as RenderBox;
//     var size = renderBox.size;
//
//     return OverlayEntry(
//       builder: (context) => Positioned(
//         width: 180,
//         child: CompositedTransformFollower(
//           link: _layerLink,
//           showWhenUnlinked: false,
//           offset: Offset(size.width - 180, 60),
//           child: Material(
//             elevation: 8,
//             borderRadius: BorderRadius.circular(12),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: Colors.grey.shade300,
//                   width: 1,
//                 ),
//               ),
//               child: ListView.separated(
//                 padding: const EdgeInsets.symmetric(vertical: 8),
//                 shrinkWrap: true,
//                 itemCount: dayOptions.length,
//                 separatorBuilder: (context, index) => Divider(
//                   height: 1,
//                   color: Colors.grey.shade200,
//                 ),
//                 itemBuilder: (context, index) {
//                   final option = dayOptions[index];
//                   final isSelected = option == selectedOption;
//                   return InkWell(
//                     onTap: () {
//                       setState(() {
//                         selectedOption = option;
//                         _removeOverlay();
//                       });
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             option,
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: isSelected
//                                   ? Colors.blue.shade700
//                                   : Colors.black87,
//                             ),
//                           ),
//                           if (isSelected)
//                             Container(
//                               width: 16,
//                               height: 16,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                   color: Colors.blue.shade700,
//                                   width: 5,
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _toggleDropdown() {
//     if (isDropdownOpen) {
//       _removeOverlay();
//     } else {
//       _overlayEntry = _createOverlayEntry();
//       Overlay.of(context).insert(_overlayEntry!);
//       setState(() {
//         isDropdownOpen = true;
//       });
//     }
//   }
//
//   void _removeOverlay() {
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//     setState(() {
//       isDropdownOpen = false;
//     });
//   }
//
//   @override
//   void dispose() {
//     _removeOverlay();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CompositedTransformTarget(
//       link: _layerLink,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         color: const Color(0xFFF8FBFF),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title: Customize days
//             Text(
//               'Customize days',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.blueGrey.shade600,
//               ),
//             ),
//             const SizedBox(height: 10),
//
//             // Notify Me box - Outer container (312x50)
//             Container(
//               width: 312,
//               height: 50,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(
//                   color: const Color(0xFFE8E8E8),
//                   width: 0.5,
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Left: Notify Me
//                   const Text(
//                     'Notify me',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87,
//                     ),
//                   ),
//
//                   // Right: Inner box (158x41) - Day selector
//                   GestureDetector(
//                     onTap: _toggleDropdown,
//                     child: Container(
//                       width: 158,
//                       height: 41,
//                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           color: const Color(0xFFE8E8E8),
//                           width: 0.5,
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             selectedOption,
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           Icon(
//                             isDropdownOpen
//                                 ? Icons.keyboard_arrow_up_rounded
//                                 : Icons.keyboard_arrow_down_rounded,
//                             size: 20,
//                             color: Colors.grey,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


class CustomizeDaysWidget extends StatefulWidget {
  const CustomizeDaysWidget({super.key});

  @override
  State<CustomizeDaysWidget> createState() => _CustomizeDaysWidgetState();
}

class _CustomizeDaysWidgetState extends State<CustomizeDaysWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return  Container(
      padding: EdgeInsets.only(left: 15, right: 10, top: 3),
      height: height * 0.055,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Notify me"),
          Spacer(),
          SizedBox(width: 10),
          // 🟣 اختيار الوحدة
          CustomInputField(
            onChange: (unit) {
              if(unit == "Everyday"){
                (context).read<AddMedicineCubit>().notifyMe = "Everyday";
              }else if(unit =="Every saturday"){
                (context).read<AddMedicineCubit>().notifyMe = "Every saturday";
              }else if(unit =="Every sunday"){
                (context).read<AddMedicineCubit>().notifyMe = "Every sunday";
              }else if(unit =="Every monday"){
                (context).read<AddMedicineCubit>().notifyMe = "Every monday";
              }else if(unit =="Every tuesday"){
                (context).read<AddMedicineCubit>().notifyMe = "Every tuesday";
              }else if(unit =="Every wednesday"){
                (context).read<AddMedicineCubit>().notifyMe = "Every wednesday";
              }else if(unit =="Every thursday"){
                (context).read<AddMedicineCubit>().notifyMe = "Every thursday";
              }else if(unit =="Every friday"){
                (context).read<AddMedicineCubit>().notifyMe = "Every friday";
              }
            },
            isDropdown: true,
            formWidth: 170,
            formHeight: 40,
            dropdownHeight: 120,
            dropdownWidth: 170,
            verPadding: 0,
            hint: "Everyday",
            items: [
              'Everyday',
              'Every saturday',
              'Every sunday',
              'Every monday',
              'Every tuesday',
              'Every wednesday',
              'Every thursday',
              'Every friday',
            ],
            horPadding: 0,
          ),
        ],
      ),
    );
  }
}
