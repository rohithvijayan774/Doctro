import 'package:doctro_user/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final updateProController = Provider.of<UserController>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: updateProController.updateProKey,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Center(
                  child: Text("Edit your Profile !",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 22, right: 22),
                child: Center(
                    child: TextFormField(
                  controller: updateProController.updateNameController,
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
                  readOnly: true
                  ,
                  onTap: () {
                    updateProController.selectDate(
                        context, updateProController.updateDOBController);
                  },
                  controller: updateProController.updateDOBController,
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
                  controller: updateProController.updateNumberController,
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
                  controller: updateProController.updateAddressController,
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
                  controller: updateProController.updateGenderController,
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
                          if (updateProController.updateProKey.currentState!
                              .validate()) {
                            updateProController
                                .updateProfile(
                                  updateProController.updateNameController.text,
                                  updateProController.updateDOBController.text,
                                  int.parse(updateProController
                                      .updateNumberController.text),
                                  updateProController
                                      .updateAddressController.text,
                                  updateProController
                                      .updateGenderController.text,
                                  context,
                                )
                                .then((value) => Navigator.of(context).pop());
                            // updateProController.createAccount(
                            //     updateProController.userid,
                            //     updateProController.usernameController.text,
                            //     updateProController.userEmail,
                            //     updateProController.userDOBController.text,
                            //     int.parse(
                            //         updateProController.userphoneController.text),
                            //     updateProController.useraddressController.text,
                            //     updateProController.usergenderController.text,
                            //     context);
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
                        child: const Text("Update Account")),
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
