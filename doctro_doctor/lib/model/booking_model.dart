class BookingModel {
  String bookingid;
  String patientName;
  String bookingTime;
  String bookingEndTime;
  String doctorName;
  String doctorProPic;
  String patientProPic;
  String doctorid;
  String userid;

  BookingModel({
    required this.bookingid,
    required this.patientName,
    required this.bookingTime,
    required this.bookingEndTime,
    required this.doctorName,
    required this.doctorProPic,
    required this.patientProPic,
    required this.doctorid,
    required this.userid,
  });

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      bookingid: map['bookingid'],
      patientName: map['patientName'],
      bookingTime: map['bookingTime'],
      bookingEndTime: map['bookingEndTime'],
      doctorName: map['doctorName'],
      doctorProPic: map['doctorProPic'],
      patientProPic: map['patientProPic'],
      doctorid: map['doctorid'],
      userid: map['userid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookingid': bookingid,
      'patientName': patientName,
      'bookingTime': bookingTime,
      'bookingEndTime': bookingEndTime,
      'doctorName': doctorName,
      'doctorProPic': doctorProPic,
      'patientProPic': patientProPic,
      'doctorid': doctorid,
      'userid': userid,
    };
  }
}
