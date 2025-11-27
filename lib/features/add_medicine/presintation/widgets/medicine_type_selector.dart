import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/constants/app_textstyle.dart';
import '../../data/models/medicine_type_model.dart';

class MedicineTypeSelector extends StatelessWidget {
  final String? selectedType;
  final Function(String) onTypeSelected;

  const MedicineTypeSelector({
    super.key,
    this.selectedType,
    required this.onTypeSelected,
  });

  static final List<MedicineTypeModel> _items = [
    MedicineTypeModel(Icon: AppImages.pillsIcon, title: AppTexts.pills),
    MedicineTypeModel(Icon: AppImages.creamIcon, title: AppTexts.cream),
    MedicineTypeModel(Icon: AppImages.liquidIcon, title: AppTexts.liquid),
    MedicineTypeModel(Icon: AppImages.injectionIcon, title: AppTexts.injection),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(22),
      height: height * 0.28,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: _items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2.2,
          crossAxisSpacing: 30,
          mainAxisSpacing: 21,
        ),
        itemBuilder: (context, index) {
          final item = _items[index];
          final isSelected = selectedType == item.title;

          return GestureDetector(
            onTap: () {
              onTypeSelected(item.title);
            },
            child: Container(
              width: 141,
              height: 89,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.splashScreenColor.withOpacity(0.2)
                    : AppColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected
                      ? AppColors.splashScreenColor.withOpacity(0.9)
                      : AppColors.medicineBorderColor.withOpacity(0.7),
                  width: isSelected ? 1 : 0.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.15),
                    blurRadius: 2,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    item.Icon,
                    width: 56,
                    height: 47,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.title,
                    style: AppTextsStyle.montserratSemiBold22(context).copyWith(
                      fontSize: 15,
                      color: AppColors.timeColor.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}