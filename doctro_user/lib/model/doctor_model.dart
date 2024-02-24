import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DoctorModel {
  String doctorid;
  String doctorName;
  String doctorEmail;
  String doctorDepartment;
  int doctorAge;
  String doctorAddress;
  String doctorDescription;
  String? doctorProPic;
  // List<DateTimeRange> bookedSlots;

  DoctorModel({
    required this.doctorid,
    required this.doctorName,
    required this.doctorEmail,
    required this.doctorDepartment,
    required this.doctorAge,
    required this.doctorAddress,
    required this.doctorDescription,
    this.doctorProPic,
    // this.bookedSlots = const [],
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
      doctorProPic: map['doctorProPic'],
      // bookedSlots: (map['bookedSlots'] as List<dynamic>)
      //     .map((slot) => DateTimeRangeX.fromJson(slot))
      //     .toList(),
    );
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
      // 'bookedSlots': bookedSlots.map((slot) => slot.toJson()).toList()
    };
  }
}

// Extension for easier DateTimeRange conversion (optional)
extension DateTimeRangeX on DateTimeRange {
  static DateTimeRange fromJson(Map<String, dynamic> json) => DateTimeRange(
        start: (json['start'] as Timestamp).toDate(),
        end: (json['end'] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        'start': start.toUtc().millisecondsSinceEpoch,
        'end': end.toUtc().millisecondsSinceEpoch,
      };
}
