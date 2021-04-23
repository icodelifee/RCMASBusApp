import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rcmasbusapp/data/model/route.dart';

class ChangeRoute {
  ChangeRoute({
    this.routeId,
    this.route,
    this.stopId,
    this.rollNumber,
    this.isApproved,
    this.paymentCompleted,
    this.changeRouteId,
    this.timestamp,
    this.status,
    this.docId,
    this.extraPaymentFee,
  });

  String? routeId;
  Route? route;
  String? stopId;
  String? rollNumber;
  bool? isApproved;
  bool? paymentCompleted;
  DateTime? timestamp;
  String? status;
  int? extraPaymentFee;
  String? docId;
  String? changeRouteId;

  factory ChangeRoute.fromJson(Map<String, dynamic> json, String docId) =>
      ChangeRoute(
        routeId: json['route_id'],
        route: Route.fromJson(json['route'], [], ''),
        stopId: json['stop_id'],
        rollNumber: json['roll_no'],
        isApproved: json['is_approved'],
        paymentCompleted: json['payment_completed'],
        timestamp: (json['timestamp'] as Timestamp).toDate(),
        status: json['status'],
        docId: docId,
        changeRouteId: json['change_route_id'],
        extraPaymentFee: json['extra_payment_fee'],
      );

  Map<String, dynamic> toJson() => {
        'route_id': routeId,
        'route': route,
        'stop_id': stopId,
        'roll_no': rollNumber,
        'is_approved': isApproved,
        'payment_completed': paymentCompleted,
        'timestamp': timestamp,
        'status': status,
        'extra_payment_fee': extraPaymentFee
      };
}
