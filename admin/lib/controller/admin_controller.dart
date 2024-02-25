import 'dart:developer';
import 'dart:io';

import 'package:admin/model/booking_model.dart';
import 'package:admin/model/doctor_model.dart';
import 'package:admin/model/user_model.dart';
import 'package:admin/views/Navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminController extends ChangeNotifier {
  List hospitalADList = [
    'images/hospital_image.jpg',
    'images/slider_1.jpg',
    'images/slider_2.jpg',
    'images/Slider_4.webp',
  ];
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  TextEditingController adminemailController = TextEditingController();
  TextEditingController adminpasswordController = TextEditingController();

  Future<void> adminLogin(
    String username,
    String password,
    context,
  ) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: username, password: password);
      final admin = firebaseAuth.currentUser!.uid;

      if (admin == 'rhI5kx8KWPSUvRMfjfcIik1HhSm2') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const NavBar()),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Check username or password')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Admin login failed : $e')));
    }
  }

  ///////////////////////FETCH USERS////////////////////////////////////////////
  String? _userid;
  String get userid => _userid!;

  List<UserModel> usersList = [];
  UserModel? users;

  Future fetchUsers(context) async {
    try {
      usersList.clear();
      CollectionReference usersRef = firebaseFirestore.collection('users');
      QuerySnapshot usersSnapshot = await usersRef.get();

      for (var doc in usersSnapshot.docs) {
        String userid = doc['userid'];
        String userName = doc['userName'];
        String userEmail = doc['userEmail'];
        String userDOB = doc['userDOB'];
        int userNumber = doc['userNumber'];
        String userAddress = doc['userAddress'];
        String userGender = doc['userGender'];
        String userProPic = doc['userProPic'] ?? '';

        users = UserModel(
            userid: userid,
            userName: userName,
            userEmail: userEmail,
            userDOB: userDOB,
            userNumber: userNumber,
            userAddress: userAddress,
            userGender: userGender,
            userProPic: userProPic);
        usersList.add(users!);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fetching Patients failed : $e')));
    }
  }

  ///////////////////////////DOCTOR DETAILS/////////////////////////////////////

  TextEditingController doctorNameController = TextEditingController();
  TextEditingController doctorEmailController = TextEditingController();
  TextEditingController doctorDepartmentController = TextEditingController();
  TextEditingController doctorAgeController = TextEditingController();
  TextEditingController doctorPasswordController = TextEditingController();
  TextEditingController doctorAddressController = TextEditingController();
  TextEditingController doctorDescriptionController = TextEditingController();

  DoctorModel? _doctorModel;
  DoctorModel get doctorModel => _doctorModel!;

  Future<void> registerDoctor(
      String doctorName,
      String doctorEmail,
      String doctorPassword,
      String doctorDepartment,
      int doctorAge,
      String doctorAddress,
      String doctorDescription,
      context) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: doctorEmail, password: doctorPassword);
      final doctorid = userCredential.user!.uid;
      _doctorModel = DoctorModel(
          doctorid: doctorid,
          doctorName: doctorName,
          doctorEmail: doctorEmail,
          doctorDepartment: doctorDepartment,
          doctorAge: doctorAge,
          doctorAddress: doctorAddress,
          doctorDescription: doctorDescription);

      await firebaseFirestore
          .collection('doctors')
          .doc(doctorid)
          .set(_doctorModel!.toMap());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Pasword is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Email already used')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
    notifyListeners();
  }

  List<DoctorModel> doctorsList = [];
  DoctorModel? doctors;

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
          SnackBar(content: Text('Fetching Patients failed : $e')));
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
    await storeImagetoStorge('Doctors Profile Pics/$picName/', proPic)
        .then((value) async {
      doctorModel.doctorProPic = value;

      DocumentReference docRef =
          firebaseFirestore.collection('doctors').doc(doctorModel.doctorid);
      await docRef.update({'doctorProPic': value});
    });
    _doctorModel = doctorModel;
  }

  // BookingModel? _bookingModel;
  // BookingModel get bookingModel => _bookingModel!;

  List<BookingModel> bookingsList = [];
  BookingModel? booking;
  Future fetchBookingsFromPatient() async {
    try {
      bookingsList.clear();
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
        String doctorProPic = doc['doctorProPic'];
        String patientProPic = doc['patientProPic'];
        String doctorid = doc['doctorid'];
        String userid = doc['userid'];

        booking = BookingModel(
          bookingid: bookingid,
          patientName: patientName,
          bookingTime: bookingTime,
          bookingEndTime: bookingEndTime,
          doctorName: doctorName,
          doctorProPic: doctorProPic,
          patientProPic: patientProPic,
          doctorid: doctorid,
          userid: userid,
        );

        bookingsList.add(booking!);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteDoctor(String doctorID, context) async {
    try {
      // delete doctor bookings collection
      final CollectionReference colletionRef = firebaseFirestore
          .collection('doctors')
          .doc(doctorID)
          .collection('bookings');
      final QuerySnapshot querySnapshot = await colletionRef.get();
      final List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      for (var document in documents) {
        await document.reference.delete();
      }
      //delete doctor collection
      await firebaseFirestore.collection('doctors').doc(doctorID).delete();

      //delete bookings from patient

      final QuerySnapshot usersSnapsot =
          await firebaseFirestore.collection('users').get();
      final List<QueryDocumentSnapshot> users = usersSnapsot.docs;

      for (var userDoc in users) {
        final String userId = userDoc.id;

        final QuerySnapshot bookingSnapshot = await userDoc.reference
            .collection('bookings')
            .where('doctorid', isEqualTo: doctorID)
            .get();
        final List<QueryDocumentSnapshot> bookings = bookingSnapshot.docs;

        for (var bookingsDoc in bookings) {
          await bookingsDoc.reference.delete();
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Doctor Deleted Successfully')));
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Deleting Doctor failed : $e')));
    }
  }
}
