class Student {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? rollNumber;
  final String? email;
  final String? course;
  final String? semester;
  final String? docId;

  Student({
    this.firstName,
    this.lastName,
    this.phone,
    this.docId,
    this.course,
    this.semester,
    this.email,
    this.rollNumber,
  });
  Student.fromJson(Map<String, dynamic> json, String docid)
      : firstName = json['first_name'],
        lastName = json['last_name'],
        docId = docid,
        phone = json['phone'],
        email = json['email'],
        course = json['couse'],
        semester = json['semester'],
        rollNumber = json['roll_no'];
}
