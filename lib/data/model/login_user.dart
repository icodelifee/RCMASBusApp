class LoginUser {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final bool? regComplete;
  final String? rollNumber;
  final String? userType;

  LoginUser(
      {this.firstName,
      this.lastName,
      this.phone,
      this.regComplete,
      this.rollNumber,
      this.userType});
  LoginUser.fromJson(Map<String, dynamic> json)
      : firstName = json['first_name'],
        lastName = json['last_name'],
        phone = json['phone'],
        regComplete = json['reg_complete'],
        rollNumber = json['roll_no'],
        userType = json['user_type'];
}
