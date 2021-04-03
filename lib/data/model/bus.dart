class Bus {
  Bus({
    this.busId,
    this.driverId,
    this.busLicenseNo,
    this.busNo,
    this.docId,
  });

  String? busId;
  String? driverId;
  String? busLicenseNo;
  String? busNo;
  String? docId;

  factory Bus.fromJson(Map<String, dynamic> json, String docId) => Bus(
      busId: json['bus_id'],
      driverId: json['driver_id'],
      busLicenseNo: json['bus_license_no'],
      busNo: json['bus_no'],
      docId: docId);

  Map<String, dynamic> toJson() => {
        'bus_id': busId,
        'driver_id': driverId,
        'bus_license_no': busLicenseNo,
        'bus_no': busNo,
      };
}
