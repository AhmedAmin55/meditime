// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/constants/app_textstyle.dart';
import '../../business_logic/search_cubit/search_cubit.dart';

class InactiveSearchBar extends StatelessWidget {
  const InactiveSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<SearchCubit, bool>(
      builder: (context, state) {
        return Row(
          children: [
            Text(
              AppTexts.todayIsSchedule,
              style: AppTextsStyle.poppinsMedium20(context),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                context.read<SearchCubit>().search();
              },
              child: Container(
                margin: EdgeInsets.only(right: 7),
                width: width * 0.1,
                height: height * 0.03,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Center(child: Image.asset(AppImages.searchIcon)),
              ),
            ),
          ],
        );
      },
    );
  }
}
