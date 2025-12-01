// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:meditime/core/constants/app_colors.dart';

class Summary extends StatelessWidget {
  final String medicineName;
  final String assignTo;
  final String specialInstructions;
  final String dosage;
  final String medicineType;
  final String reminderTimes;

  const Summary({
    super.key,
    required this.medicineName,
    required this.assignTo,
    required this.specialInstructions,
    required this.dosage,
    required this.medicineType,
    required this.reminderTimes,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Summary",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: height * 0.35,
            width: width,
            decoration: BoxDecoration(
              color: AppColors.addBackground,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.medicineBorderColor,
                width: 1,
              ),
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: width * 0.451,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 29,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5FAFF),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildLabel("Medicine name :"),
                        _buildLabel("Assign to :"),
                        _buildLabel("Special instructions :"),
                        _buildLabel("Dosage :"),
                        _buildLabel("Medicine Type :"),
                        _buildLabel("Reminder Times :"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 29,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: AppColors.medicineBorderColor,
                          width: 0.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildValue(medicineName),
                          _buildValue(assignTo),
                          _buildValue(specialInstructions),
                          _buildValue(dosage),
                          _buildValue(medicineType),
                          _buildValue(reminderTimes),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600]));
  }

  Widget _buildValue(String value) {
    return Text(
      value,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
