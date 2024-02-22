import 'package:admin/controller/admin_controller.dart';
import 'package:admin/views/doctor_profile.dart';
import 'package:admin/views/enter_doctor_details.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorList extends StatelessWidget {
  const DoctorList({super.key});
  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final adController = Provider.of<AdminController>(context, listen: false);
    print(FirebaseAuth.instance.currentUser!.uid);
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
              child: CarouselSlider.builder(
                  options: CarouselOptions(
                    autoPlayInterval: const Duration(seconds: 2),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    viewportFraction: 1,
                    autoPlay: true,
                    aspectRatio: 20 / 9,
                  ),
                  itemCount: adController.hospitalADList.length,
                  itemBuilder: (
                    context,
                    itemIndex,
                    pageViewIndex,
                  ) {
                    return Container(
                      clipBehavior: Clip.antiAlias,
                      height: 142,
                      width: 324,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: const Color.fromARGB(255, 30, 129, 221),
                      ),
                      child: Image.asset(
                        adController.hospitalADList[itemIndex],
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
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
                          builder: (context) => const EnterDrDetails()));
                    },
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.add),
                  ),
                )
              ],
            ),
            Expanded(
              child: Consumer<AdminController>(
                  builder: (context, doctorsListController, _) {
                return FutureBuilder(
                    future: doctorsListController.fetchDoctors(context),
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : snapshot.hasError
                              ? Center(
                                  child: Text(snapshot.error.toString()),
                                )
                              : ListView.builder(
                                  itemCount:
                                      doctorsListController.doctorsList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 5, right: 5),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => DoctorProfile(
                                              drID: doctorsListController
                                                  .doctorsList[index].doctorid,
                                              drName: doctorsListController
                                                  .doctorsList[index]
                                                  .doctorName,
                                              drAge: doctorsListController
                                                  .doctorsList[index].doctorAge,
                                              drDepartment:
                                                  doctorsListController
                                                      .doctorsList[index]
                                                      .doctorDepartment,
                                              drDescription:
                                                  doctorsListController
                                                      .doctorsList[index]
                                                      .doctorDescription,
                                              drEmail: doctorsListController
                                                  .doctorsList[index]
                                                  .doctorEmail,
                                            ),
                                          ));
                                        },
                                        child: Card(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: Text(
                                                    'Dr. ${doctorsListController.doctorsList[index].doctorName}'),
                                                subtitle: Text(
                                                    doctorsListController
                                                        .doctorsList[index]
                                                        .doctorDepartment),
                                                leading: CircleAvatar(
                                                  backgroundImage: doctorsListController
                                                              .doctorsList[
                                                                  index]
                                                              .doctorProPic ==
                                                          null
                                                      ? const NetworkImage(
                                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhb_tTLAas4h8fw7zHFEm1y4iLqUtGtiMpai0NNBRH2KCOQaW3BHMpbdO0OesMtxgtY2A&usqp=CAU')
                                                      : NetworkImage(
                                                          doctorsListController
                                                              .doctorsList[
                                                                  index]
                                                              .doctorProPic!),
                                                  radius: 25,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                    });
              }),
            )
          ],
        ),
      ),
    );
  }
}
