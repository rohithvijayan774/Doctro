import 'dart:developer';

import 'package:doctro_user/controller/user_controller.dart';
import 'package:doctro_user/views/forgot_password.dart';
import 'package:doctro_user/views/registration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userLoginController =
        Provider.of<UserController>(context, listen: false);

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
                  key: userLoginController.loginKey,
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
                      const Text("HI! Welcome, Enter your login details"),
                      // Text("Email"),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 50, left: 22, right: 22),
                        child: TextFormField(
                          controller:
                              userLoginController.loginUsernameController,
                          //validation
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@+g+m+a+i+l+.+c+o+m*$')
                                    .hasMatch(value)) {
                              return 'required field';
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
                          controller:
                              userLoginController.loginUserPasswordController,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !RegExp(r'^.{6,}$').hasMatch(value)) {
                              return 'password required';
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
                        padding: const EdgeInsets.only(right: 12),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            style: const ButtonStyle(
                                overlayColor: MaterialStatePropertyAll(
                                    Colors.transparent)),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ForgotPage(),
                              ));
                            },
                            child: const Text(
                              "forgot password?",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 90, 88, 88)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: TextButton(
                          onPressed: () {
                            if (userLoginController.loginKey.currentState!
                                .validate()) {
                              userLoginController.userLogin(
                                  userLoginController
                                      .loginUsernameController.text,
                                  userLoginController
                                      .loginUserPasswordController.text,
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
                          child: const Text("login"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don’t have an account?",
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Registration(),
                                  ));
                                },
                                child: const Text(
                                  "Sign up",
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
