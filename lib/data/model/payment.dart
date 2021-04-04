import 'package:cloud_firestore/cloud_firestore.dart';

class Payment {
  String? passId;
  String? paymentCode;
  Timestamp? paymentDate;
  String? paymentId;
  String? rollNo;

  Payment(
      {this.passId,
      this.paymentCode,
      this.paymentDate,
      this.paymentId,
      this.rollNo});

  Payment.fromJson(Map<String, dynamic> json) {
    passId = json['pass_id'];
    paymentCode = json['payment_code'];
    paymentDate = json['payment_date'];
    paymentId = json['payment_id'];
    rollNo = json['roll_no'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['pass_id'] = passId;
    data['payment_code'] = paymentCode;
    data['payment_date'] = paymentDate;
    data['payment_id'] = paymentId;
    data['roll_no'] = rollNo;
    return data;
  }
}
