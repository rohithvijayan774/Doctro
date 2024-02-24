import 'dart:developer';
import 'dart:io';

import 'package:booking_calendar/booking_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctro_user/model/booking_model.dart';
import 'package:doctro_user/model/doctor_model.dart';
import 'package:doctro_user/model/user_model.dart';
import 'package:doctro_user/views/Navigation.dart';
import 'package:doctro_user/views/booked_details.dart';
import 'package:doctro_user/views/login_page.dart';
import 'package:doctro_user/views/more_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UserController extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  ////////////////////////////////REGISTER//////////////////////////////////////
  final regKey = GlobalKey<FormState>();
  TextEditingController useremailController = TextEditingController();
  TextEditingController userpasswordController = TextEditingController();
  TextEditingController userconfirmpasswordController = TextEditingController();

  final moredetKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController userDOBController = TextEditingController();
  TextEditingController userphoneController = TextEditingController();
  TextEditingController useraddressController = TextEditingController();
  TextEditingController usergenderController = TextEditingController();

  String? _userid;
  String get userid => _userid!;

  String? _userEmail;
  String get userEmail => _userEmail!;

  Future userSignUp(
    String userEmail,
    String userPassword,
    context,
  ) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
      _userid = firebaseAuth.currentUser!.uid;
      _userEmail = userEmail;
      final user = firebaseAuth.currentUser;
      user!.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Verification mail send to $userEmail. Please Verify mail before login.')));
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const MoreDetails(),
      ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Signup failed because, $e')));
    }
  }

  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  Future createAccount(
      String userid,
      String userName,
      String userEmail,
      String userDOB,
      int userNumber,
      String userAddress,
      String userGender,
      context) async {
    _userModel = UserModel(
        userid: userid,
        userName: userName,
        userEmail: userEmail,
        userDOB: userDOB,
        userNumber: userNumber,
        userAddress: userAddress,
        userGender: userGender);
    await firebaseFirestore
        .collection('users')
        .doc(userid)
        .set(_userModel!.toMap());

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false);
  }

  ////////////////////////////////LOGIN//////////////////////////////////////
  final loginKey = GlobalKey<FormState>();
  TextEditingController loginUsernameController = TextEditingController();
  TextEditingController loginUserPasswordController = TextEditingController();

  Future<void> userLogin(
    String userEmail,
    String userPassword,
    context,
  ) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);
      final emailVerified = firebaseAuth.currentUser!.emailVerified;

      if (emailVerified == false) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please verify your email')));
      } else {
        CollectionReference collection = firebaseFirestore.collection('users');
        var userQuery =
            await collection.doc(firebaseAuth.currentUser!.uid).get();
        if (userQuery.exists) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const NavBar()),
              (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('This email not registered')));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login Failed : $e')));
    }
  }

  Future fetchUserData(context) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .get()
          .then((DocumentSnapshot snapshot) {
        _userModel = UserModel(
            userid: snapshot['userid'],
            userName: snapshot['userName'],
            userEmail: snapshot['userEmail'],
            userDOB: snapshot['userDOB'],
            userNumber: snapshot['userNumber'],
            userAddress: snapshot['userAddress'],
            userGender: snapshot['userGender'],
            userProPic: snapshot['userProPic']);

        _userid = userModel.userid;
        updateNameController.text = userModel.userName;
        updateDOBController.text = userModel.userDOB;
        updateNumberController.text = userModel.userNumber.toString();
        updateAddressController.text = userModel.userAddress;
        updateGenderController.text = userModel.userGender;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Fetching Data Failed : $e')));
    }
  }

  Future forgotPassword(
    TextEditingController userEmailController,
    context,
  ) async {
    await firebaseAuth.sendPasswordResetEmail(email: userEmailController.text);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('Password reset mail send to ${userEmailController.text}')));
  }

  final updateProKey = GlobalKey<FormState>();
  TextEditingController updateNameController = TextEditingController();
  TextEditingController updateDOBController = TextEditingController();
  TextEditingController updateNumberController = TextEditingController();
  TextEditingController updateAddressController = TextEditingController();
  TextEditingController updateGenderController = TextEditingController();

  Future updateProfile(String userName, String userDOB, int userNumber,
      String userAddress, String userGender, context) async {
    try {
      DocumentReference docRef = firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid);
      await docRef.update({
        'userName': userName,
        'userDOB': userDOB,
        'userNumber': userNumber,
        'userAddress': userAddress,
        'userGender': userGender,
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Your Profile updated')));
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Updating Profile Failed : $e')));
    }
  }

  Future<void> selectDate(
    context,
    TextEditingController dateController,
  ) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800),
        lastDate: DateTime(2100));

    if (picked != null) {
      // selectedDate = picked;
      dateController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  File? pickProPic;

  Future<File> selectProPic() async {
    try {
      final pickedPic =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedPic != null) {
        pickProPic = File(pickedPic.path);
      }
    } catch (e) {
      print('Image select failed : $e');
    }
    notifyListeners();
    return pickProPic!;
  }

  Future<String> storeImagetoStorge(String ref, File file) async {
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    UploadTask uploadTask =
        firebaseStorage.ref().child(ref).putFile(file, metadata);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    log(downloadURL);
    notifyListeners();
    return downloadURL;
  }

  uploadPropic(String picName, File proPic) async {
    await storeImagetoStorge('Users Profile Pics/$picName/', proPic)
        .then((value) async {
      userModel.userProPic = value;

      DocumentReference docRef =
          firebaseFirestore.collection('users').doc(userModel.userid);
      await docRef.update({'userProPic': value});
    });
    _userModel = userModel;
  }

  //////////////////////FETCH DOCTORS//////////////////////////////////////////
  Map<String, bool> likeStatus = {};

  bool isLiked(String doctorid) => likeStatus[doctorid] ?? false;

  void toggleLike(String doctorid) {
    likeStatus[doctorid] = !(likeStatus[doctorid] ?? false);
    notifyListeners();
  }

  List<DoctorModel> doctorsList = [];
  DoctorModel? doctors;

  DoctorModel? _doctorModel;
  DoctorModel get doctorModel => _doctorModel!;

  Future fetchDoctors(context) async {
    try {
      print('//////////Fetching Doctors');
      doctorsList.clear();
      CollectionReference doctorsRef = firebaseFirestore.collection('doctors');
      QuerySnapshot doctorsSnapshot = await doctorsRef.get();
      for (var doc in doctorsSnapshot.docs) {
        String doctorid = doc['doctorid'];
        String doctorName = doc['doctorName'];
        String doctorEmail = doc['doctorEmail'];
        String doctorDepartment = doc['doctorDepartment'];
        int doctorAge = doc['doctorAge'];
        String doctorAddress = doc['doctorAddress'];
        String doctorDescription = doc['doctorDescription'];
        String doctorProPic = doc['doctorProPic'] ?? '';

        doctors = DoctorModel(
            doctorid: doctorid,
            doctorName: doctorName,
            doctorEmail: doctorEmail,
            doctorDepartment: doctorDepartment,
            doctorAge: doctorAge,
            doctorAddress: doctorAddress,
            doctorDescription: doctorDescription,
            doctorProPic: doctorProPic);

        doctorsList.add(doctors!);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fetching Doctors failed : $e')));
    }
  }

  ////////////////////SLOT BOOKING////////////////////////////////////////

  List<BookingService> convertedBooking = [];
  List<DateTimeRange> converted = [];

  List<Map<String, dynamic>> bookings = [];

  final now = DateTime.now();
  late BookingService mockBookingService;

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
    ///disabledDays will properly work with real data

    // List<DateTimeRange> convertedBookings = bookings
    //     .where((booking) =>
    //         booking['serviceId'] ==
    //         doctorModel.doctorid) // Filter by service ID
    //     .map((booking) => DateTimeRange(
    //           start: DateTime.parse(booking['bookingStart']),
    //           end: DateTime.parse(booking['bookingEnd']),
    //         ))
    //     .toList();
    // converted.add(convertedBookings);

    DateTime first = now;
    DateTime tomorrow = now.add(const Duration(days: 1));
    DateTime second = now.add(const Duration(minutes: 55));
    DateTime third = now.subtract(const Duration(minutes: 240));
    DateTime fourth = now.subtract(const Duration(minutes: 500));
    // converted.add(
    //     DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
    // converted.add(DateTimeRange(
    //     start: second, end: second.add(const Duration(minutes: 23))));
    // converted.add(DateTimeRange(
    //     start: third, end: third.add(const Duration(minutes: 15))));
    // converted.add(DateTimeRange(
    //     start: fourth, end: fourth.add(const Duration(minutes: 50))));

    //book whole day example
    // converted.add(DateTimeRange(
    //     start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 5, 0),
    //     end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 0)));
    return converted;
  }

  Future init(String doctorid, String doctorName) async {
    mockBookingService = BookingService(
        userId: firebaseAuth.currentUser!.uid,
        userName: userModel.userName,
        serviceId: doctorid,
        serviceName: doctorName,
        serviceDuration: 30,
        bookingEnd: DateTime(now.year, now.month, now.day, 17, 30),
        bookingStart: DateTime(now.year, now.month, now.day, 9, 0));
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  BookingModel? _bookingModel;
  BookingModel get bookingModel => _bookingModel!;

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));

    bookings.add(newBooking.toJson());

    // converted.add(DateTimeRange(
    //     start: newBooking.bookingStart, end: newBooking.bookingEnd));

    // convertedBooking.add(newBooking);

    log('////////////convertedBooking///////////${convertedBooking}');

    log(bookings.toString());
    _bookingModel = BookingModel(
      bookingid: newBooking.bookingStart.toString(),
      patientName: newBooking.userName ?? 'unknown',
      bookingTime: newBooking.bookingStart.toString(),
      bookingEndTime: newBooking.bookingEnd.toString(),
      doctorName: newBooking.serviceName.toString(),
    );
    print('////////////${newBooking.serviceId}');
    await firebaseFirestore
        .collection('doctors')
        .doc(newBooking.serviceId)
        .collection('bookings')
        .doc(newBooking.bookingStart.toString())
        .set(_bookingModel!.toMap());
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('bookings')
        .doc(newBooking.bookingStart.toString())
        .set(_bookingModel!.toMap());

    print('/////////Uploaded successfully');

    // converted.clear();

    // for (var booking in bookings) {
    //   if (booking['serviceId'] == '1U5pzHK4xyWxsDqztRBvciWQEDJ3') {
    //     converted.add(DateTimeRange(
    //         start: DateTime.parse(booking['bookingStart']),
    //         end: DateTime.parse(booking['bookingEnd'])));
    //   }
    // }

    log(converted.length.toString());
    // log('${newBooking.toJson()} has been uploaded');
    String formatttedDate =
        DateFormat('dd-MM-yy').format(newBooking.bookingStart);

    String formatttedTime = DateFormat('jm').format(newBooking.bookingStart);
    print('////////////$formatttedDate/////////');
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 13, 0),
          end: DateTime(now.year, now.month, now.day, 14, 30))
    ];
  }

  List<BookingModel> bookingsList = [];
  BookingModel? booking;
  Future fetchBookings() async {
    try {
      bookingsList.clear();
      converted.clear();
      CollectionReference userssRef = firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('bookings');
      QuerySnapshot usersSnapshot = await userssRef.get();
      for (var doc in usersSnapshot.docs) {
        String bookingid = doc['bookingid'];
        String patientName = doc['patientName'];
        String bookingTime = doc['bookingTime'];
        String bookingEndTime = doc['bookingEndTime'];
        String doctorName = doc['doctorName'];

        booking = BookingModel(
          bookingid: bookingid,
          patientName: patientName,
          bookingTime: bookingTime,
          bookingEndTime: bookingEndTime,
          doctorName: doctorName,
        );

        bookingsList.add(booking!);
      }
    } catch (e) {
      print(e);
    }
  }

  //////////////////////////////////////////
  Future fetch(String doctorsId) async {
    try {
      bookingsList.clear();
      converted.clear();
      CollectionReference userssRef = firebaseFirestore
          .collection('doctors')
          .doc(doctorsId)
          .collection('bookings');
      QuerySnapshot usersSnapshot = await userssRef.get();
      for (var doc in usersSnapshot.docs) {
        String bookingid = doc['bookingid'];
        String patientName = doc['patientName'];
        String bookingTime = doc['bookingTime'];
        String bookingEndTime = doc['bookingEndTime'];
        String doctorName = doc['doctorName'];

        booking = BookingModel(
          bookingid: bookingid,
          patientName: patientName,
          bookingTime: bookingTime,
          bookingEndTime: bookingEndTime,
          doctorName: doctorName,
        );

        bookingsList.add(booking!);
        converted.add(DateTimeRange(
            start: DateTime.parse(booking!.bookingTime),
            end: DateTime.parse(booking!.bookingEndTime)));
      }
    } catch (e) {
      print(e);
    }
  }
}
