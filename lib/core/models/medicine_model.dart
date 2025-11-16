class MedicineModel {
  final String medicineName;
  final String specialInstructions;
  final String status;
  final int assignToWho;
  final String dosage;
  final String medicineType;
  final DateTime duration;
  final String custmaizeDays;
  final DateTime reminderTimes;


  MedicineModel({
    required this.medicineName,
    required this.specialInstructions,
    required this.assignToWho,
    required this.dosage,
    required this.medicineType,
    required this.duration,
    required this.custmaizeDays,
    required this.reminderTimes,
    required this.status,
  });
}

List<MedicineModel> medicineList = [
  MedicineModel(
    status: "missed",
    medicineName: "Paracetamol",
    specialInstructions: "withFood",
    assignToWho: 1,
    dosage: "sppon",
    medicineType: "pills",
    duration: DateTime.now(),
    custmaizeDays: "everyDay",
    reminderTimes: DateTime.now(),
  ),
  MedicineModel(
    status: "missed",
    medicineName: "Paracetamol",
    specialInstructions: "withFood",
    assignToWho: 1,
    dosage: "sppon",
    medicineType: "cream",
    duration: DateTime.now(),
    custmaizeDays: "everyDay",
    reminderTimes: DateTime.now(),
  ),
  MedicineModel(
    status: "taken",
    medicineName: "Paracetamol",
    specialInstructions: "withFood",
    assignToWho: 1,
    dosage: "sppon",
    medicineType: "injection",
    duration: DateTime.now(),
    custmaizeDays: "everyDay",
    reminderTimes: DateTime.now(),
  ),
  MedicineModel(
    status: "missed",
    medicineName: "Paracetamol",
    specialInstructions: "withFood",
    assignToWho: 1,
    dosage: "sppon",
    medicineType: "liquid",
    duration: DateTime.now(),
    custmaizeDays: "everyDay",
    reminderTimes: DateTime.now(),
  ),
  MedicineModel(
    status: "waiting",
    medicineName: "Paracetamol",
    specialInstructions: "withFood",
    assignToWho: 1,
    dosage: "sppon",
    medicineType: "pills",
    duration: DateTime.now(),
    custmaizeDays: "everyDay",
    reminderTimes: DateTime.now(),
  ),
  MedicineModel(
    status: "waiting",
    medicineName: "Paracetamol",
    specialInstructions: "withFood",
    assignToWho: 1,
    dosage: "sppon",
    medicineType: "pills",
    duration: DateTime.now(),
    custmaizeDays: "everyDay",
    reminderTimes: DateTime.now(),
  ),
  MedicineModel(
    status: "missed",
    medicineName: "Paracetamol",
    specialInstructions: "withFood",
    assignToWho: 1,
    dosage: "sppon",
    medicineType: "pills",
    duration: DateTime.now(),
    custmaizeDays: "everyDay",
    reminderTimes: DateTime.now(),
  ),
  MedicineModel(
    status: "missed",
    medicineName: "Paracetamol",
    specialInstructions: "withFood",
    assignToWho: 1,
    dosage: "sppon",
    medicineType: "pills",
    duration: DateTime.now(),
    custmaizeDays: "everyDay",
    reminderTimes: DateTime.now(),
  ),
  MedicineModel(
    status: "missed",
    medicineName: "Paracetamol",
    specialInstructions: "withFood",
    assignToWho: 1,
    dosage: "sppon",
    medicineType: "pills",
    duration: DateTime.now(),
    custmaizeDays: "everyDay",
    reminderTimes: DateTime.now(),
  ),
];
