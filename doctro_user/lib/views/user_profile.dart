import 'package:doctro_user/controller/user_controller.dart';
import 'package:doctro_user/views/edit_profile.dart';
import 'package:doctro_user/views/login_page.dart';
import 'package:doctro_user/views/more_details.dart';
import 'package:doctro_user/widgets/profile_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //     icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: const Text("User Profile"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const EditProfile(),
                ));
              },
              icon: const Icon(Icons.mode_edit_outlined))
        ],
      ),
      body: Consumer<UserController>(
          builder: (context, userProfileController, _) {
        return FutureBuilder(
            future: userProfileController.fetchUserData(context),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      color: Colors.blue,
                      width: width,
                      height: hieght * .8,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: hieght * .7,
                              width: width,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(50),
                                    topLeft: Radius.circular(50)),
                              ),
                              // child: Padding(
                              //   padding: const EdgeInsets.only(top: 45),
                              //   child: Align(
                              //     alignment: Alignment.topCenter,
                              //     child: Column(
                              //       children: [
                              //         Text(
                              //           'user name',
                              //           style: TextStyle(
                              //               fontWeight: FontWeight.bold, fontSize: 18),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),

                              child: Column(
                                children: [
                                  SizedBox(
                                    height: hieght * .08,
                                  ),
                                  Text(
                                    userProfileController.userModel.userName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: hieght * .05,
                                  ),
                                  Expanded(
                                      child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ProfileTile(
                                            title: userProfileController
                                                .userModel.userAddress,
                                            icon: Icons.location_on_outlined),
                                        ProfileTile(
                                            title: userProfileController
                                                .userModel.userNumber
                                                .toString(),
                                            icon: Icons.phone),
                                        ProfileTile(
                                            title: userProfileController
                                                .userModel.userDOB,
                                            icon:
                                                Icons.calendar_today_outlined),
                                        ProfileTile(
                                            title: userProfileController
                                                .userModel.userEmail,
                                            icon:
                                                Icons.alternate_email_rounded),
                                      ],
                                    ),
                                  )),
                                  TextButton(
                                    onPressed: () {
                                      FirebaseAuth.instance.signOut().then(
                                          (value) => Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginPage(),
                                                  ),
                                                  (route) => false));
                                    },
                                    style: ButtonStyle(
                                        minimumSize: MaterialStateProperty.all(
                                            const Size(150, 40)),
                                        textStyle: MaterialStateProperty.all(
                                            const TextStyle(fontSize: 20)),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue)),
                                    child: const Text("Logout"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: InkWell(
                              onTap: () {
                                userProfileController
                                    .selectProPic()
                                    .whenComplete(() =>
                                        userProfileController.uploadPropic(
                                            userProfileController
                                                .userModel.userid,
                                            userProfileController.pickProPic!));
                              },
                              child: Container(
                                height: hieght * .15,
                                width: width * .4,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 5,
                                      color: const Color.fromARGB(
                                          185, 255, 255, 255)),
                                  shape: BoxShape.circle,
                                  // color: Colors.black,
                                  image: DecorationImage(
                                    image: userProfileController
                                                .userModel.userProPic ==
                                            null
                                        ? const NetworkImage(
                                            'https://img.freepik.com/free-photo/view-happy-3d-man-using-tablet_23-2150709864.jpg?size=626&ext=jpg&ga=GA1.1.1811490750.1705252568&semt=sph')
                                        : NetworkImage(userProfileController
                                            .userModel.userProPic!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
            });
      }),
    );
  }
}

class ListItem {
  String title;
  bool isSelected;
  IconData icon;
  ListItem({
    required this.title,
    required this.isSelected,
    required this.icon,
  });
}
