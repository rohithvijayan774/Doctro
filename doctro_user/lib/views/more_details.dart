import 'dart:developer';

import 'package:doctro_user/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoreDetails extends StatelessWidget {
  const MoreDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final moreDetController =
        Provider.of<UserController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: moreDetController.moredetKey,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Center(
                  child: Text("More About You !",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 22, right: 22),
                child: Center(
                    child: TextFormField(
                  controller: moreDetController.usernameController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                      return ("Name required");
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      label: const Text("Name"),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(20))),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 22, right: 22),
                child: Center(
                    child: TextFormField(
                  controller: moreDetController.userDOBController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r'^(0[1-9]|[12][0-9]|3[01])[-/.](0[1-9]|1[012])[-/.](19|20)\d\d$')
                            .hasMatch(value)) {
                      return ("dd/mm/yyyy");
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      label: const Text("Date of Birth"),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(20))),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 22, right: 22),
                child: Center(
                    child: TextFormField(
                  controller: moreDetController.userphoneController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return ("Mobile Number required");
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      label: const Text("Mobile Number"),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(20))),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 22, right: 22),
                child: Center(
                    child: TextFormField(
                  controller: moreDetController.useraddressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ("Address required");
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      label: const Text("Address"),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(20))),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 22, right: 22),
                child: Center(
                    child: TextFormField(
                  controller: moreDetController.usergenderController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r'[m+a+l+e]?[f+e+m+a+l+e]?[o+t+h+e+r]$')
                            .hasMatch(value)) {
                      return ("Enter (male/female/other)");
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      label: const Text("Gender"),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(20))),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 22, right: 22),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: TextButton(
                        onPressed: () {
                          if (moreDetController.moredetKey.currentState!
                              .validate()) {
                            moreDetController.createAccount(
                                moreDetController.userid,
                                moreDetController.usernameController.text,
                                moreDetController.userEmail,
                                moreDetController.userDOBController.text,
                                int.parse(
                                    moreDetController.userphoneController.text),
                                moreDetController.useraddressController.text,
                                moreDetController.usergenderController.text,
                                context);
                          }
                        },
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(350, 55)),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(fontSize: 20)),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45)))),
                        child: const Text("Create Account")),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
