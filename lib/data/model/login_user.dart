class LoginUser {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final bool? regComplete;
  final String? rollNumber;
  final String? userType;
  final bool? payComplete;
  final String? docId;

  LoginUser(
      {this.firstName,
      this.lastName,
      this.phone,
      this.docId,
      this.regComplete,
      this.rollNumber,
      this.payComplete,
      this.userType});
  LoginUser.fromJson(Map<String, dynamic> json, String docid)
      : firstName = json['first_name'],
        lastName = json['last_name'],
        docId = docid,
        phone = json['phone'],
        regComplete = json['reg_complete'],
        rollNumber = json['roll_no'],
        payComplete = json['pay_complete'],
        userType = json['user_type'];
}
