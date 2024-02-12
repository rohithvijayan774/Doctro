import 'package:admin/pages/Navigation.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Entr_dr_dt extends StatefulWidget {
  const Entr_dr_dt({super.key});

  @override
  State<Entr_dr_dt> createState() => _Entr_dr_dtState();
}

// ignore: camel_case_types
class _Entr_dr_dtState extends State<Entr_dr_dt> {
  final enterKey = GlobalKey<FormState>(); //form validation
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   //title

      //   elevation: 0,
      //   // title: const Text("Patient list",
      //   // style: TextStyle(fontWeight: FontWeight.bold),),
      // ),
      body: Column(
        children: [
          const Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 60),
                child: Center(
                  child: Text("Enter Doctor Details",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 35),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://static.vecteezy.com/system/resources/thumbnails/028/287/555/small/an-indian-young-female-doctor-isolated-on-green-ai-generated-photo.jpg'),
                  radius: 60,
                ),
              ),
            ],
          ),
          // ListView(
          //   prototypeItem: TextFormField(
          //     decoration:  InputDecoration(
          //       label: const Text("Email"),
          //       enabledBorder: OutlineInputBorder(
          //         borderSide:const BorderSide(width: 2),
          //         borderRadius: BorderRadius.circular(20)
          //       ),
          //       focusedBorder: OutlineInputBorder(
          //         borderSide: const BorderSide(width: 2),
          //         borderRadius: BorderRadius.circular(20)
          //       )
          //     ),
          //   )
          // ),
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
                            print("validated");
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const NavBar(),
                                ),
                                (route) => false);
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
