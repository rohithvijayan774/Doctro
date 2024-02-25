import 'package:admin/controller/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientList1 extends StatelessWidget {
  const PatientList1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Patient list",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<AdminController>(builder: (context, patientController, _) {
        return FutureBuilder(
            future: patientController.fetchUsers(context),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : patientController.usersList.isEmpty
                      ? const Center(
                          child: Text('No Patients Found'),
                        )
                      : ListView.builder(
                          itemCount: patientController.usersList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 5, right: 5),
                              child: Card(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                child: ListTile(
                                  title: Text(patientController
                                      .usersList[index].userName),
                                  subtitle: Text(patientController
                                      .usersList[index].userNumber
                                      .toString()),
                                  leading: CircleAvatar(
                                    backgroundImage: patientController
                                                .usersList[index].userProPic ==
                                            null
                                        ? const NetworkImage(
                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhb_tTLAas4h8fw7zHFEm1y4iLqUtGtiMpai0NNBRH2KCOQaW3BHMpbdO0OesMtxgtY2A&usqp=CAU')
                                        : NetworkImage(patientController
                                            .usersList[index].userProPic!),
                                    radius: 25,
                                  ),
                                ),
                              ),
                            );
                          });
            });
      }),
    );
  }
}
