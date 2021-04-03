import 'package:cloud_firestore/cloud_firestore.dart';

class Stop {
  Stop({
    this.stopId,
    this.arrivalTime,
    this.stopLocation,
    this.stopName,
    this.docId,
  });

  String? stopId;
  Timestamp? arrivalTime;
  String? stopLocation;
  String? stopName;
  String? docId;

  factory Stop.fromJson(Map<String, dynamic> json, String docId) => Stop(
      stopId: json['stop_id'],
      arrivalTime: json['arrival_time'] as Timestamp,
      stopLocation: json['stop_location'],
      stopName: json['stop_name'],
      docId: docId);

  Map<String, dynamic> toJson() => {
        'stop_id': stopId,
        'arrival_time': arrivalTime,
        'stop_location': stopLocation,
        'stop_name': stopName,
      };
}
