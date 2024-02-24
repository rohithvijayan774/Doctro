import 'package:doctro_user/controller/user_controller.dart';
import 'package:doctro_user/views/booking_page2.dart';
import 'package:doctro_user/views/booking_page3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Consumer<UserController>(builder: (context, userHomeController, _) {
        return FutureBuilder(
            future: userHomeController
                .fetchUserData(context)
                .then((value) => userHomeController.fetchDoctors(context)),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 11, 118, 233),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                          ),
                          height: hieght * .40,
                          width: width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  CircleAvatar(
                                    backgroundImage: userHomeController
                                                .userModel.userProPic ==
                                            null
                                        ? const NetworkImage(
                                            'https://img.freepik.com/free-photo/view-happy-3d-man-using-tablet_23-2150709864.jpg?size=626&ext=jpg&ga=GA1.1.1811490750.1705252568&semt=sph')
                                        : NetworkImage(userHomeController
                                            .userModel.userProPic!),
                                    radius: 40,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    userHomeController.userModel.userName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width * .65,
                                        height: 45,
                                        child: Center(
                                          child: TextFormField(
                                            cursorHeight: 30,
                                            // cursorOpacityAnimates: true,
                                            cursorColor: Colors.black,
                                            decoration: InputDecoration(
                                              hintText: "Search",
                                              filled: true,
                                              fillColor: Colors.white,
                                              // labelText: "search",

                                              prefixIcon: const Icon(
                                                Icons.search,
                                                size: 20,
                                              ),

                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey,
                                                      width: 0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40)),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide:
                                                    const BorderSide(width: 0),
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.sort_rounded,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          // height: 350,

                          child: ListView.builder(
                              itemCount: userHomeController.doctorsList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => BookingPage2(
                                            doctors: userHomeController
                                                .doctorsList[index],
                                            // drName: userHomeController
                                            //     .doctorsList[index].doctorName,
                                            // drProPic: userHomeController
                                            //     .doctorsList[index]
                                            //     .doctorProPic!,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                                'Dr. ${userHomeController.doctorsList[index].doctorName}'),
                                            subtitle: Text(userHomeController
                                                .doctorsList[index]
                                                .doctorDepartment),
                                            leading: CircleAvatar(
                                              backgroundImage: userHomeController
                                                          .doctorsList[index]
                                                          .doctorProPic ==
                                                      null
                                                  ? const NetworkImage(
                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhb_tTLAas4h8fw7zHFEm1y4iLqUtGtiMpai0NNBRH2KCOQaW3BHMpbdO0OesMtxgtY2A&usqp=CAU')
                                                  : NetworkImage(
                                                      userHomeController
                                                          .doctorsList[index]
                                                          .doctorProPic!),
                                              radius: 25,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    );
            });
      }),
    );
  }
}
