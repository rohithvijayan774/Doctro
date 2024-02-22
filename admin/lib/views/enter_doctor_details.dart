import 'package:admin/controller/admin_controller.dart';
import 'package:admin/views/Navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnterDrDetails extends StatelessWidget {
  const EnterDrDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final enterKey = GlobalKey<FormState>();
    //form validation
    final addDoctController = Provider.of<AdminController>(context);
    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60),
                child: Center(
                  child: Text("Enter Doctor Details",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35),
                child: InkWell(
                  onTap: () {
                    addDoctController.selectProPic();
                  },
                  child: CircleAvatar(
                    backgroundImage: addDoctController.pickProPic == null
                        ? const NetworkImage(
                            'https://static.vecteezy.com/system/resources/thumbnails/028/287/555/small/an-indian-young-female-doctor-isolated-on-green-ai-generated-photo.jpg')
                        : FileImage(addDoctController.pickProPic!)
                            as ImageProvider,
                    radius: 60,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: enterKey,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 22, right: 22),
                      child: TextFormField(
                        controller: addDoctController.doctorNameController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                            return "Name required";
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
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 22, right: 22),
                      child: TextFormField(
                        controller: addDoctController.doctorEmailController,
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
                            label: const Text("Email"),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(20)),
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
                            addDoctController.doctorDepartmentController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                            return "Department required";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            label: const Text("Department"),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 22, right: 22),
                      child: TextFormField(
                        controller: addDoctController.doctorAgeController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !RegExp(r'^[0-9]{0,2}$').hasMatch(value)) {
                            return "Age required";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            label: const Text("Age"),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 22, right: 22),
                      child: TextFormField(
                        controller: addDoctController.doctorPasswordController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !RegExp(r'^.{6,}$').hasMatch(value)) {
                            return "Password required";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            label: const Text("Password"),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 22, right: 22),
                      child: TextFormField(
                        controller: addDoctController.doctorAddressController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Address required";
                          } else {
                            return null;
                          }
                        },
                        maxLines: 4,
                        decoration: InputDecoration(
                            label: const Text("Address"),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(20)),
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
                            addDoctController.doctorDescriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Description required";
                          } else {
                            return null;
                          }
                        },
                        maxLines: 4,
                        decoration: InputDecoration(
                            label: const Text("Description"),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 20),
                      child: TextButton(
                        onPressed: () {
                          if (enterKey.currentState!.validate()) {
                            if (addDoctController.pickProPic != null) {
                              addDoctController
                                  .registerDoctor(
                                      addDoctController
                                          .doctorNameController.text,
                                      addDoctController
                                          .doctorEmailController.text,
                                      addDoctController
                                          .doctorPasswordController.text,
                                      addDoctController
                                          .doctorDepartmentController.text,
                                      int.parse(addDoctController
                                          .doctorAgeController.text),
                                      addDoctController
                                          .doctorAddressController.text,
                                      addDoctController
                                          .doctorDescriptionController.text,
                                      context)
                                  .then((value) =>
                                      addDoctController.uploadPropic(
                                          addDoctController
                                              .doctorModel.doctorid,
                                          addDoctController.pickProPic!))
                                  .then((value) => Navigator.of(context).pop());
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Choose Profile Pic')));
                            }

                            // Navigator.of(context).pushAndRemoveUntil(
                            //     MaterialPageRoute(
                            //       builder: (context) => const NavBar(),
                            //     ),
                            //     (route) => false);
                          } else {
                            print("not validated");
                          }
                        },
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(300, 50)),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(fontSize: 20)),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue)),
                        child: const Text("submit"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
