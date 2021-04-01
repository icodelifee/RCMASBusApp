// To parse this JSON data, do
//
//     final busPass = busPassFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

BusPass busPassFromJson(String str, String docId) =>
    BusPass.fromJson(json.decode(str), docId);

String busPassToJson(BusPass data) => json.encode(data.toJson());

class BusPass {
  BusPass({
    this.routeId,
    this.stopId,
    this.passId,
    this.timestamp,
    this.isApproved,
    this.paymentId,
    this.docId,
    this.rollNo,
    this.isPaymentComplete,
  });

  String? routeId;
  String? stopId;
  String? paymentId;
  String? passId;
  String? docId;
  Timestamp? timestamp;
  String? rollNo;
  bool? isApproved;
  bool? isPaymentComplete;

  factory BusPass.fromJson(Map<String, dynamic> json, String docid) => BusPass(
        routeId: json['route_id'] as String,
        stopId: json['stop_id'] as String,
        passId: json['pass_id'] as String,
        timestamp: json['timestamp'] as Timestamp,
        isApproved: json['is_approved'] as bool,
        docId: docid,
        paymentId: json['payment_id'] as String,
        rollNo: json['roll_no'] as String,
        isPaymentComplete: json['is_payment_complete'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'route_id': routeId,
        'stop_id': stopId,
        'pass_id': passId,
        'timestamp': timestamp,
        'is_approved': isApproved,
        'payment_id': paymentId,
        'roll_no': rollNo,
        'is_payment_complete': isPaymentComplete,
      };
}
