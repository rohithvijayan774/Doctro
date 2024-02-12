import 'package:flutter/material.dart';

class DrProfile extends StatefulWidget {
  const DrProfile({super.key});

  @override
  State<DrProfile> createState() => _DrProfileState();
}

class _DrProfileState extends State<DrProfile> {
  final List<ListItem> _items = [
    ListItem(title: '', isSelected: true, icon: Icons.home),
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
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Column(
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
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30, top: 15),
                        child: Container(
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 136, 127, 127),
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Doctor Name",
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const Text(
                              "Department",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            TextButton(
                                onPressed: () {
                                  // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ,), (route) => false);
                                },
                                style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                        const Size(90, 30)),
                                    textStyle: MaterialStateProperty.all(
                                        const TextStyle(fontSize: 14)),
                                    foregroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 0, 0, 0)),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 255, 255, 255)),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(45)))),
                                child: const Text(
                                  "Edit Profile",
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Icon(_items[index].icon,
                          size: 36, color: Color.fromARGB(87, 39, 138, 219)),
                    ),
                    minLeadingWidth: 100,
                    title: const Text(
                      "user name",
                      style:
                          TextStyle(color: Color.fromARGB(255, 121, 120, 120)),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: 6),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(90, 30)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 14)),
                    foregroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 255, 255, 255)),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45)))),
                child: const Text(
                  "logout",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          ),
        ],
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
