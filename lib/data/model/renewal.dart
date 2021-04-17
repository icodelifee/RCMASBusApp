import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rcmasbusapp/data/model/bus_pass.dart';
import 'package:rcmasbusapp/data/model/payment.dart';
import 'package:rcmasbusapp/data/model/student.dart';

class Renewal {
  Renewal(
      {this.passId,
      this.paymentId,
      this.renewalDate,
      this.renewalId,
      this.rollNo,
      this.isApproved,
      this.payment,
      this.pass,
      this.student,
      this.docId});

  String? passId;
  String? paymentId;
  Timestamp? renewalDate;
  String? renewalId;
  bool? isApproved;
  String? rollNo;
  String? docId;
  Payment? payment;
  BusPass? pass;
  Student? student;

  factory Renewal.fromJson(
    Map<String, dynamic> json,
    String docid,
  ) =>
      Renewal(
          passId: json['pass_id'],
          paymentId: json['payment_id'],
          renewalDate: json['renewal_date'],
          renewalId: json['renewal_id'],
          rollNo: json['roll_no'],
          isApproved: json['is_approved'],
          docId: docid);

  Map<String, dynamic> toJson() => {
        'pass_id': passId,
        'payment_id': paymentId,
        'renewal_date': renewalDate,
        'renewal_id': renewalId,
        'roll_no': rollNo,
      };
}
