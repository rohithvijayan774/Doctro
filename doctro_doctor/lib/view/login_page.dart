import 'dart:developer';

import 'package:doctro_doctor/controller/doctor_controller.dart';
import 'package:doctro_doctor/view/Navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginKey = GlobalKey<FormState>();
    final loginController =
        Provider.of<DoctorController>(context, listen: false);
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
                  key: loginKey,
                  child: Column(
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text("Hi! Welcome, Enter your login details"),
                      // Text("Email"),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 50, left: 22, right: 22),
                        child: TextFormField(
                          controller: loginController.usernameController,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@+g+m+a+i+l+.+c+o+m*$')
                                    .hasMatch(value)) {
                              return 'Enter valid  email';
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
                          controller: loginController.userPassController,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !RegExp(r'^.{6,}$').hasMatch(value)) {
                              return ' Enter atleast 6 length password';
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
                        padding: const EdgeInsets.only(top: 50),
                        child: TextButton(
                          onPressed: () {
                            if (loginKey.currentState!.validate()) {
                              log("validated");
                              loginController.doctorLogin(
                                  loginController.usernameController.text,
                                  loginController.userPassController.text,
                                  context);
                            } else {
                              log("not validate");
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
                          child: const Text("login"),
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
