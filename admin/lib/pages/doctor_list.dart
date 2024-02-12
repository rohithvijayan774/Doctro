import 'package:admin/pages/doctor_profile.dart';
import 'package:admin/pages/enter_doctor_details.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DoctorList extends StatefulWidget {
  DoctorList({super.key});
  List<String> doctorsNmae = ["jyodish", "b", "c", "d", "`e", "h", "g"];
  List<String> department = ["1", "2", "3", "4", "`5", "6", "7"];
  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  // int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Doctor list",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        width: width,
        height: hieght,
        child: Column(
          children: [
            Center(
              child: Container(
                clipBehavior: Clip.antiAlias,
                height: 142,
                width: 324,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: const Color.fromARGB(255, 30, 129, 221),
                ),
                child: Image.asset(
                  'images/hospital_image.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: width * .65,
                  height: 40,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "search",
                      suffixIcon: const Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(40)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Entr_dr_dt()));
                    },
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.add),
                  ),
                )
              ],
            ),
            Expanded(
              // height: 350,
              child: ListView.builder(
                  itemCount: widget.doctorsNmae.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 5, right: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DoctorProfile(),
                          ));
                        },
                        child: Card(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(widget.doctorsNmae[index]),
                                subtitle: Text(widget.department[index]),
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
            )
          ],
        ),
      ),
    );
  }
}
