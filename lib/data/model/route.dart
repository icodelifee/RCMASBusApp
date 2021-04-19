import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rcmasbusapp/data/model/stop.dart';

class Route {
  Route(
      {this.routeId,
      this.routeLocation,
      this.routeName,
      this.stops,
      this.routeFee,
      this.docId});

  String? routeId;
  String? routeLocation;
  String? routeName;
  String? routeFee;
  String? docId;
  List<Stop>? stops;
  factory Route.fromJson(Map<String, dynamic> json,
          List<QueryDocumentSnapshot> stops, String docId) =>
      Route(
          routeId: json['route_id'],
          routeLocation: json['route_location'],
          routeName: json['route_name'],
          routeFee: json['route_fee'],
          stops: stops
              .map((QueryDocumentSnapshot e) => Stop.fromJson(e.data()!, e.id))
              .toList(),
          docId: docId);

  Map<String, dynamic> toJson() => {
        'route_id': routeId,
        'route_location': routeLocation,
        'route_name': routeName,
      };
}
