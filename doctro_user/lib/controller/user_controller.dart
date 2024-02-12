import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctro_user/model/user_model.dart';
import 'package:doctro_user/views/Navigation.dart';
import 'package:doctro_user/views/login_page.dart';
import 'package:doctro_user/views/more_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

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
      print(e);
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
            userGender: snapshot['userGender']);
        _userid = userModel.userid;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Fetching Data Failed : $e')));
    }
  }
}
