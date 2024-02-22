import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctro_doctor/model/doctor_model.dart';
import 'package:doctro_doctor/view/Dr_profile.dart';
import 'package:doctro_doctor/view/Navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DoctorController extends ChangeNotifier {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  ///////////////////////////DOCTOR LOGIN////////////////////////////////////
  TextEditingController usernameController = TextEditingController();
  TextEditingController userPassController = TextEditingController();

  Future<void> doctorLogin(String username, String password, context) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: username, password: password);
      final doctor = firebaseAuth.currentUser!.uid;

      CollectionReference collection = firebaseFirestore.collection('doctors');
      var userQuery = await collection.doc(doctor).get();

      if (userQuery.exists) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const NavBar()),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('This email not registered')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login Failed : $e')));
    }
  }

  TextEditingController doctorNameController = TextEditingController();
  TextEditingController doctorAgeController = TextEditingController();
  TextEditingController doctorAddressController = TextEditingController();
  TextEditingController doctorDescriptionController = TextEditingController();

  String? _doctorid;
  String get doctorid => _doctorid!;

  DoctorModel? _doctorModel;
  DoctorModel get doctorModel => _doctorModel!;

  Future fetchDoctor(context) async {
    try {
      await firebaseFirestore
          .collection('doctors')
          .doc(firebaseAuth.currentUser!.uid)
          .get()
          .then((DocumentSnapshot snapshot) {
        _doctorModel = DoctorModel(
            doctorid: snapshot['doctorid'],
            doctorName: snapshot['doctorName'],
            doctorEmail: snapshot['doctorEmail'],
            doctorDepartment: snapshot['doctorDepartment'],
            doctorAge: snapshot['doctorAge'],
            doctorAddress: snapshot['doctorAddress'],
            doctorDescription: snapshot['doctorDescription'],
            doctorProPic: snapshot['doctorProPic']);

        _doctorid = doctorModel.doctorid;

        doctorNameController.text = doctorModel.doctorName;
        doctorAgeController.text = doctorModel.doctorAge.toString();
        doctorAddressController.text = doctorModel.doctorAddress;
        doctorDescriptionController.text = doctorModel.doctorDescription;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Fetching Data Failed : $e')));
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

  Future updateProfile(String doctorname, int doctorage, String doctorAddress,
      String doctorDescription, context) async {
    try {
      doctorModel.doctorName = doctorname;
      doctorModel.doctorAge = doctorage;
      doctorModel.doctorAddress = doctorAddress;
      doctorModel.doctorDescription = doctorDescription;
      DocumentReference docRef = firebaseFirestore
          .collection('doctors')
          .doc(firebaseAuth.currentUser!.uid);
      await docRef.update({
        'doctorName': doctorname,
        'doctorAge': doctorage,
        'doctorAddress': doctorAddress,
        'doctorDescription': doctorDescription,
      });
      _doctorModel = doctorModel;
      notifyListeners();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Profile Updated')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Updating Failed : $e')));
    }
  }
}
