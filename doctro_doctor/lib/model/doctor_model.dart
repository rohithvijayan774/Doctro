class DoctorModel {
  String doctorid;
  String doctorName;
  String doctorEmail;
  String doctorDepartment;
  int doctorAge;
  String doctorAddress;
  String doctorDescription;
  String? doctorProPic;

  DoctorModel({
    required this.doctorid,
    required this.doctorName,
    required this.doctorEmail,
    required this.doctorDepartment,
    required this.doctorAge,
    required this.doctorAddress,
    required this.doctorDescription,
    this.doctorProPic,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
        doctorid: map['doctorid'],
        doctorName: map['doctorName'],
        doctorEmail: map['doctorEmail'],
        doctorDepartment: map['doctorDepartment'],
        doctorAge: map['doctorAge'],
        doctorAddress: map['doctorAddress'],
        doctorDescription: map['doctorDescription'],
        doctorProPic: map['doctorProPic']);
  }

  Map<String, dynamic> toMap() {
    return {
      'doctorid': doctorid,
      'doctorName': doctorName,
      'doctorEmail': doctorEmail,
      'doctorDepartment': doctorDepartment,
      'doctorAge': doctorAge,
      'doctorAddress': doctorAddress,
      'doctorDescription': doctorDescription,
      'doctorProPic': doctorProPic,
    };
  }
}
