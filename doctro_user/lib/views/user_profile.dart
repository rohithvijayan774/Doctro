import 'package:doctro_user/views/login_page.dart';
import 'package:doctro_user/views/more_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // List iconsList = [
  //   Icon(Icons.account_balance_sharp),
  //   Icon(Icons.abc_outlined),
  //   Icon(Icons.access_alarm),
  // ];
  List<ListItem> items = [
    ListItem(title: '', isSelected: true, icon: Icons.person),
    ListItem(title: '', isSelected: true, icon: Icons.cabin_outlined),
    ListItem(title: '', isSelected: true, icon: Icons.sports_golf_rounded),
    ListItem(title: '', isSelected: true, icon: Icons.grade_sharp),
    ListItem(
        title: 'Me',
        isSelected: true,
        icon: Icons.signal_wifi_connected_no_internet_4_rounded),
    ListItem(title: 'Me', isSelected: true, icon: Icons.sms_failed_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: const Text("user profile"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MoreDetails(),
                ));
              },
              icon: const Icon(Icons.mode_edit_outlined))
        ],
      ),
      body: Container(
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
                    const Text(
                      "user name",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Icon(items[index].icon,
                                    size: 36,
                                    color:
                                        const Color.fromARGB(87, 39, 138, 219)),
                              ),
                              minLeadingWidth: 100,
                              title: const Text(
                                "user name",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 121, 120, 120)),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: 6),
                    ),
                    TextButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut().then(
                            (value) => Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                                (route) => false));
                      },
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(150, 40)),
                          textStyle: MaterialStateProperty.all(
                              const TextStyle(fontSize: 20)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue)),
                      child: const Text("log out"),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: hieght * .15,
                width: width * .4,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 5,
                      color: const Color.fromARGB(185, 255, 255, 255)),
                  shape: BoxShape.circle,
                  // color: Colors.black,
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://img.freepik.com/free-photo/view-happy-3d-man-using-tablet_23-2150709864.jpg?size=626&ext=jpg&ga=GA1.1.1811490750.1705252568&semt=sph'),
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
