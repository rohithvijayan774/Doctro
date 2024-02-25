import 'package:cool_alert/cool_alert.dart';
import 'package:doctro_doctor/controller/doctor_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookedPatients extends StatelessWidget {
  const BookedPatients({super.key});

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
      body: Consumer<DoctorController>(
          builder: (context, patientListController, _) {
        return FutureBuilder(
            future: patientListController.fetchPatients(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : patientListController.bookingsList.isEmpty
                      ? const Center(
                          child: Text('No Patients Found'),
                        )
                      : ListView.builder(
                          itemCount: patientListController.bookingsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            String formatttedDate = DateFormat('dd-MM-yy')
                                .format(DateTime.parse(patientListController
                                    .bookingsList[index].bookingTime));
                            String formatttedTime = DateFormat('jm').format(
                                DateTime.parse(patientListController
                                    .bookingsList[index].bookingTime));
                            return Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          31, 72, 143, 230),
                                      borderRadius: BorderRadius.circular(60)),
                                  height: hieght * .13,
                                  width: width * .9,
                                  child: Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: CircleAvatar(
                                        radius: 37,
                                        backgroundImage: NetworkImage(
                                            patientListController
                                                .bookingsList[index]
                                                .patientProPic),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              patientListController
                                                  .bookingsList[index]
                                                  .patientName,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          // Text(age[index].toString()),
                                          Text(
                                              '$formatttedDate • $formatttedTime'),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        //cool alert box (cool_alert: ^2.0.1)
                                        CoolAlert.show(
                                            onConfirmBtnTap: () {
                                              patientListController
                                                  .deleteBooking(
                                                      'doctors',
                                                      patientListController
                                                          .firebaseAuth
                                                          .currentUser!
                                                          .uid,
                                                      patientListController
                                                          .bookingsList[index]
                                                          .bookingid)
                                                  .then(
                                                    (value) =>
                                                        patientListController
                                                            .deleteBooking(
                                                      'users',
                                                      patientListController
                                                          .bookingsList[index]
                                                          .userid,
                                                      patientListController
                                                          .bookingsList[index]
                                                          .bookingid,
                                                    ),
                                                  );
                                            },
                                            context: context,
                                            type: CoolAlertType.confirm,
                                            text:
                                                "You want to cancel the patients",
                                            widget: TextFormField(
                                              decoration: const InputDecoration(
                                                hintText:
                                                    "please enter the reason",
                                              ),
                                            ));
                                        //cool alert box end!!
                                      },
                                      child: const Text("cancel"),
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red)),
                                    )
                                  ]),
                                ),
                              ),
                            );
                          },
                        );
            });
      }),
    );
  }
}
