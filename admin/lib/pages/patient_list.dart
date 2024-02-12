import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PatientList1 extends StatefulWidget {
  PatientList1({super.key});
  List patientName = ["jyodish", "salman", "mahloofa", "d", "e", "h", "g"];
  List age = ["10", "12", "13", "14", "15", "16", "19"];

  @override
  State<PatientList1> createState() => _PatientList1State();
}

class _PatientList1State extends State<PatientList1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Patient list",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Expanded(
        child: ListView.builder(
            itemCount: widget.patientName.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                child: Card(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(widget.patientName[index]),
                        subtitle: Text(widget.age[index]),
                        leading: const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhb_tTLAas4h8fw7zHFEm1y4iLqUtGtiMpai0NNBRH2KCOQaW3BHMpbdO0OesMtxgtY2A&usqp=CAU'),
                          radius: 25,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
