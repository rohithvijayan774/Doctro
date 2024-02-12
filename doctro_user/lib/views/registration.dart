import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctro_user/controller/user_controller.dart';
import 'package:doctro_user/views/login_page.dart';
import 'package:doctro_user/views/more_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    final regController = Provider.of<UserController>(context, listen: false);
    return Scaffold(
      // resizeToAvoidBottomInset: false,

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 200),
                child: Form(
                  key: regController.regKey,
                  child: Column(
                    children: [
                      const Text(
                        "Registration",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text("HI! Welcome, Enter your details"),
                      // Text("Email"),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 50, left: 22, right: 22),
                        child: TextFormField(
                          controller: regController.useremailController,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@+g+m+a+i+l+.+c+o+m*$')
                                    .hasMatch(value)) {
                              return "Email required";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              label: const Text("E-mail"),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 2),
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),

                      Padding(
                        padding:
                            const EdgeInsets.only(top: 30, left: 22, right: 22),
                        child: TextFormField(
                          controller: regController.userpasswordController,
                          validator: (value1) {
                            if (value1 == null ||
                                value1.isEmpty ||
                                !RegExp(r'^.{6,}$').hasMatch(value1)) {
                              return "Password required";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              label: const Text("password"),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 2),
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),

                      Padding(
                        padding:
                            const EdgeInsets.only(top: 30, left: 22, right: 22),
                        child: TextFormField(
                          obscureText: true,
                          controller:
                              regController.userconfirmpasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "confirm password required";
                            }
                            if (value !=
                                regController.userpasswordController.text) {
                              return "Enter the same password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              label: const Text("Confirm password"),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 2),
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: TextButton(
                          onPressed: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => MoreDetails(),
                            // ));

                            if (regController.regKey.currentState!.validate()) {
                              regController.userSignUp(
                                  regController.useremailController.text,
                                  regController.userpasswordController.text,
                                  context);
                            } else {
                              log("not validated");
                            }
                          },
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  const Size(300, 50)),
                              textStyle: MaterialStateProperty.all(
                                  const TextStyle(fontSize: 20)),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue)),
                          child: const Text("continue"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ));
                                },
                                child: const Text(
                                  "login",
                                  style: TextStyle(color: Colors.black87),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// createaAccount(emailAddress, password, context) async {
//   try {
//     final credential =
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//       email: emailAddress,
//       password: password,
//     );

//     Navigator.of(context).push(MaterialPageRoute(
//       builder: (context) => MoreDetails(),
//     ));
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       print('The password provided is too weak.');
//     } else if (e.code == 'email-already-in-use') {
//       print('The account already exists for that email.');
//     }
//   } catch (e) {
//     print(e);
//   }
// }
