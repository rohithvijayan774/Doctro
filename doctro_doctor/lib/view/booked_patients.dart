import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class booked_patients extends StatefulWidget {
  const booked_patients({super.key});

  @override
  State<booked_patients> createState() => _booked_patientsState();
}

class _booked_patientsState extends State<booked_patients> {
  List patientnames = [
    "patient1",
    "patient2",
    "patient3",
  ];
  List age = [
    10,
    20,
    30,
  ];
  List time = [
    "time 1",
    "time 2",
    "time 3",
  ];
  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Booked patients",
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      body: ListView.builder(
        itemCount: age.length,
        itemBuilder: (BuildContext context, int index) {
          return Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(31, 72, 143, 230),
                    borderRadius: BorderRadius.circular(60)),
                height: hieght * .13,
                width: width * .9,
                child: Row(children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: CircleAvatar(
                      radius: 37,
                      backgroundColor: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(patientnames[index]),
                        Text(age[index].toString()),
                        Text(time[index]),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * .15),
                    child: TextButton(
                      onPressed: () {
                        //cool alert box (cool_alert: ^2.0.1)
                        CoolAlert.show(
                            onConfirmBtnTap: () {},
                            context: context,
                            type: CoolAlertType.confirm,
                            text: "You want to cancel the patients",
                            widget: TextFormField(
                              decoration: const InputDecoration(
                                hintText: "please enter the reason",
                              ),
                            ));
                        //cool alert box end!!
                      },
                      child: Text("cancel"),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.red)),
                    ),
                  )
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
