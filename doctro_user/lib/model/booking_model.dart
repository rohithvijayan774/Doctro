class BookingModel {
  String bookingid;
  String patientName;
  String bookingTime;
  String bookingEndTime;
  String doctorName;

  BookingModel({
    required this.bookingid,
    required this.patientName,
    required this.bookingTime,
    required this.bookingEndTime,
    required this.doctorName,
  });

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      bookingid: map['bookingid'],
      patientName: map['patientName'],
      bookingTime: map['bookingTime'],
      bookingEndTime: map['bookingEndTime'],
      doctorName: map['doctorName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookingid': bookingid,
      'patientName': patientName,
      'bookingTime': bookingTime,
      'bookingEndTime': bookingEndTime,
      'doctorName': doctorName,
    };
  }
}
