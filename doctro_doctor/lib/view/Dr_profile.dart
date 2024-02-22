import 'package:doctro_doctor/controller/doctor_controller.dart';
import 'package:doctro_doctor/view/edit_profile.dart';
import 'package:doctro_doctor/view/login_page.dart';
import 'package:doctro_doctor/widgets/profile_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrProfile extends StatelessWidget {
  const DrProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print("//////////${FirebaseAuth.instance.currentUser!.uid}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Consumer<DoctorController>(
          builder: (context, drProfileController, _) {
        return FutureBuilder(
            future: drProfileController.fetchDoctor(context),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Container(
                            height: hieght * .22,
                            width: width,
                            color: const Color.fromARGB(255, 255, 255, 255),
                            child: Stack(
                              children: [
                                Container(
                                  height: 150,
                                  width: width,
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black38,
                                        blurRadius: 5,
                                        offset: Offset(2, 5),
                                      )
                                    ],
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30, top: 15),
                                      child: Container(
                                        height: 160,
                                        width: 160,
                                        decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black38,
                                                blurRadius: 5,
                                                offset: Offset(2, 5),
                                              )
                                            ],
                                            image: DecorationImage(
                                              image: drProfileController
                                                          .doctorModel
                                                          .doctorProPic ==
                                                      null
                                                  ? const AssetImage(
                                                      'assetName')
                                                  : NetworkImage(
                                                          drProfileController
                                                              .doctorModel
                                                              .doctorProPic!)
                                                      as ImageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 30),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Dr. ${drProfileController.doctorModel.doctorName}",
                                            style: const TextStyle(
                                                fontSize: 21,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            drProfileController
                                                .doctorModel.doctorDepartment,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const EditProfile(),
                                                  ),
                                                );
                                              },
                                              style: ButtonStyle(
                                                  minimumSize:
                                                      MaterialStateProperty.all(
                                                          const Size(90, 30)),
                                                  textStyle:
                                                      MaterialStateProperty.all(
                                                          const TextStyle(
                                                              fontSize: 14)),
                                                  foregroundColor:
                                                      MaterialStateProperty.all(
                                                          const Color.fromARGB(
                                                              255, 0, 0, 0)),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          const Color.fromARGB(
                                                              255, 255, 255, 255)),
                                                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)))),
                                              child: const Text(
                                                "Edit Profile",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 25, top: 20),
                            child: Text(
                              "Other informations",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              ProfileTile(
                                icon: Icons.location_city,
                                title: drProfileController
                                    .doctorModel.doctorAddress,
                              ),
                              ProfileTile(
                                icon: Icons.calendar_today,
                                title:
                                    "${drProfileController.doctorModel.doctorAge} y/old",
                              ),
                              ProfileTile(
                                icon: Icons.alternate_email_sharp,
                                title:
                                    drProfileController.doctorModel.doctorEmail,
                              ),
                            ],
                          ),
                        )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: TextButton(
                              onPressed: () {
                                drProfileController.firebaseAuth
                                    .signOut()
                                    .whenComplete(
                                      () => Navigator.of(context)
                                          .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage(),
                                              ),
                                              (route) => false),
                                    );
                              },
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(100, 40)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(fontSize: 14)),
                                foregroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 255, 255, 255),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                ),
                              ),
                              child: const Text(
                                "logout",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    );
            });
      }),
    );
  }
}
