import 'package:admin/model/user_model.dart';
import 'package:admin/views/Navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AdminController extends ChangeNotifier {
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
}
