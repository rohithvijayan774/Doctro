import 'package:doctro_user/controller/user_controller.dart';
import 'package:doctro_user/views/booking_page2.dart';
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
            future: userHomeController.fetchUserData(context),
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
                                  const CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhb_tTLAas4h8fw7zHFEm1y4iLqUtGtiMpai0NNBRH2KCOQaW3BHMpbdO0OesMtxgtY2A&usqp=CAU'),
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
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (context) => BookingPage2(
                                      //           drName: widget.doctorsNmae[index],
                                      //         )));
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
                                                'widget.doctorsNmae[index]'),
                                            subtitle: Text(
                                                'widget.department[index]'),
                                            leading: const CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhb_tTLAas4h8fw7zHFEm1y4iLqUtGtiMpai0NNBRH2KCOQaW3BHMpbdO0OesMtxgtY2A&usqp=CAU'),
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
