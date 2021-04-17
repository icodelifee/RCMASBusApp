import 'package:cloud_firestore/cloud_firestore.dart';

class Bus {
  Bus(
      {this.busId,
      this.driverId,
      this.busLicenseNo,
      this.busNo,
      this.docId,
      this.fitness,
      this.insurance,
      this.permit,
      this.pollution,
      this.allottedSeats,
      this.totalSeats,
      this.tax});

  String? busId;
  String? driverId;
  String? busLicenseNo;
  String? busNo;
  String? docId;
  int? allottedSeats;
  int? totalSeats;
  DateTime? fitness;
  DateTime? insurance;
  DateTime? permit;
  DateTime? pollution;
  DateTime? tax;

  factory Bus.fromJson(Map<String, dynamic> json, String docId) => Bus(
      busId: json['bus_id'],
      driverId: json['driver_id'],
      busLicenseNo: json['bus_license_no'],
      busNo: json['bus_no'],
      allottedSeats: json['allotted_seats'],
      totalSeats: json['total_seats'],
      fitness: (json['fitness'] as Timestamp).toDate(),
      insurance: (json['insurance'] as Timestamp).toDate(),
      permit: (json['permit'] as Timestamp).toDate(),
      pollution: (json['pollution'] as Timestamp).toDate(),
      tax: (json['tax'] as Timestamp).toDate(),
      docId: docId);

  Map<String, dynamic> toJson() => {
        'bus_id': busId,
        'driver_id': driverId,
        'bus_license_no': busLicenseNo,
        'bus_no': busNo,
      };
}
