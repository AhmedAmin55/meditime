// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/constants/app_textstyle.dart';
import '../../business_logic/add_medicine_cubit/add_medicine_cubit.dart';
import '../../data/models/medicine_type_model.dart';

enum type { pills, cream, liquid, injection }

class MedicineTypeSelector extends StatefulWidget {
  const MedicineTypeSelector({super.key});

  @override
  State<MedicineTypeSelector> createState() => _MedicineTypeSelectorState();
}

class _MedicineTypeSelectorState extends State<MedicineTypeSelector> {
  static final List<MedicineTypeModel> _items = [
    MedicineTypeModel(Icon: AppImages.pillsIcon, title: AppTexts.pills, id: 0),
    MedicineTypeModel(Icon: AppImages.creamIcon, title: AppTexts.cream, id: 1),
    MedicineTypeModel(
      Icon: AppImages.liquidIcon,
      title: AppTexts.liquid,
      id: 2,
    ),
    MedicineTypeModel(
      Icon: AppImages.injectionIcon,
      title: AppTexts.injection,
      id: 3,
    ),
  ];

  int? isSelected;

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
          return GestureDetector(
            onTap: () {
              setState(() {
                isSelected = index;

                context.read<AddMedicineCubit>().selectedType =
                    _items[index].title;
              });
            },
            child: Container(
              width: 141,
              height: 89,
              decoration: BoxDecoration(
                color: isSelected == index
                    ? AppColors.splashScreenColor.withOpacity(0.2)
                    : AppColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected == index
                      ? AppColors.splashScreenColor.withOpacity(0.9)
                      : AppColors.medicineBorderColor.withOpacity(0.7),
                  width: 0.5,
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
                    _items[index].Icon,
                    width: 56,
                    height: 47,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _items[index].title,
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
