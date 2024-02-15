import 'package:admin/views/doctor_list.dart';
import 'package:flutter/material.dart';

class DoctorProfile extends StatelessWidget {
  final String drName;
  final int drAge;
  final String drDepartment;
  final String drDescription;
  const DoctorProfile({
    required this.drName,
    required this.drAge,
    required this.drDepartment,
    required this.drDescription,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Doctor profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: 218,
                width: 219,
                child: Image.asset(
                  'images/Doctors.png',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Container(
                width: width * 1,
                height: hieght * .56,
                decoration: const ShapeDecoration(
                  color: Color.fromARGB(42, 146, 186, 214),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 10),
                          child: Text(
                            "Dr. $drName",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 5),
                        child: Text(
                          "Age: $drAge",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 5),
                        child: Text(
                          "Department: $drDepartment",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(drDescription),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(MaterialPageRoute(
                                builder: (context) => DoctorList()));
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 233, 28, 9),
                              minimumSize: Size(234, 48))),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
