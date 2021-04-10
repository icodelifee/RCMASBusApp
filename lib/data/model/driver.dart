import 'package:cloud_firestore/cloud_firestore.dart';

class Driver {
  Driver(
      {this.driverId,
      this.firstName,
      this.lastName,
      this.phone,
      this.docId,
      this.licenseExpiryDate,
      this.licenseNo});

  String? driverId;
  String? firstName;
  String? lastName;
  String? docId;
  String? phone;
  String? licenseNo;
  Timestamp? licenseExpiryDate;

  factory Driver.fromJson(Map<String, dynamic> json, String docId) => Driver(
        driverId: json['driver_id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        phone: json['phone'],
        licenseNo: json['license_no'],
        docId: docId,
        licenseExpiryDate: json['license_expiry_date'],
      );

  Map<String, dynamic> toJson() => {
        'driver_id': driverId,
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
      };
}
