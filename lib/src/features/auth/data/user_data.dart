class UserData {
  static final UserData _instance = UserData._privateConstructor();

  factory UserData() {
    return _instance;
  }

  UserData._privateConstructor();

  String? nickName;
  String? firstName;
  String? lastName;
  String? userEmail;
  String? password;
  String? birthDate;
  int? gender;
  String? avatar;
  String? bio;
}
