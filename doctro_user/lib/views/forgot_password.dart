import 'package:doctro_user/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPage extends StatelessWidget {
  const ForgotPage({super.key});

  @override
  Widget build(BuildContext context) {
    final forgotKey = GlobalKey<FormState>();
    final forgotPassController = Provider.of<UserController>(context);
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
                  key: forgotKey,
                  child: Column(
                    children: [
                      const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // Text("HI! Welcome, Enter your login details"),
                      // Text("Email"),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 50, left: 22, right: 22),
                        child: TextFormField(
                          controller:
                              forgotPassController.loginUsernameController,
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

                      // Padding(
                      //   padding:
                      //       const EdgeInsets.only(top: 30, left: 22, right: 22),
                      //   child: TextFormField(
                      //     validator: (value) {
                      //       if (value == null ||
                      //           value.isEmpty ||
                      //           !RegExp(r'^.{6,}$').hasMatch(value)) {
                      //         return "New Password required";
                      //       } else {
                      //         return null;
                      //       }
                      //     },
                      //     decoration: InputDecoration(
                      //         label: const Text("New password"),
                      //         enabledBorder: OutlineInputBorder(
                      //           borderSide: const BorderSide(
                      //               color: Colors.black, width: 2),
                      //           borderRadius: BorderRadius.circular(20),
                      //         ),
                      //         focusedBorder: OutlineInputBorder(
                      //             borderSide: const BorderSide(width: 2),
                      //             borderRadius: BorderRadius.circular(20))),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 12),
                      //   child: Align(
                      //     alignment: Alignment.centerRight,
                      //     child: TextButton(
                      //       style: ButtonStyle(
                      //           overlayColor:
                      //               MaterialStatePropertyAll(Colors.transparent)),
                      //       onPressed: () {},
                      //       child: Text(
                      //         "forgot password?",
                      //         style: TextStyle(
                      //             color: Color.fromARGB(255, 90, 88, 88)),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: TextButton(
                          onPressed: () {
                            if (forgotKey.currentState!.validate()) {
                              forgotPassController.forgotPassword(
                                  forgotPassController.loginUsernameController,
                                  context);
                            } else {
                              print("not validated");
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
                          child: const Text("confirm"),
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
