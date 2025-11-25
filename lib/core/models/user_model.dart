class UserModel {
  final String uid;
  final String name;
  final int? age;
  final String email;
  final String? profilePhoto;
  final String phoneNumber;

  UserModel({
    required this.uid,
    required this.name,
    this.age,
    required this.email,
    required this.phoneNumber,
    this.profilePhoto,
  });

  Map<String, dynamic> toMap() => {
    'user_id': uid,
    'name': name,
    'age': age,
    'email': email,
    'phone_number': phoneNumber,
    'profile_photo': profilePhoto,
  };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    uid: map['user_id'],
    name: map['name'],
    age: map['age'],
    email: map['email'],
    phoneNumber: map['phone_number'],
    profilePhoto: map['profile_photo'],
  );
}
