import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:doctro_user/controller/user_controller.dart';
import 'package:doctro_user/model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingPage3 extends StatelessWidget {
  final DoctorModel doctors;
  const BookingPage3({
    required this.doctors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    DateTime todayDate = DateTime.now();
    final formattedSelectedDate = DateFormat('MMMM dd,yyyy').format(todayDate);
    var reminderDate = DateFormat('dd-MMM-yyyy').format(todayDate);
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
      ),
      body: Consumer<UserController>(builder: (context, bookingController, _) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(doctors.doctorProPic!),
              ),
              Container(
                width: width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    DatePicker(
                      DateTime.now(),
                      initialSelectedDate: DateTime.now(),
                      selectionColor: Colors.blue,
                      selectedTextColor: Colors.white,
                      deactivatedColor: Colors.grey,
                      onDateChange: (selectedDate) {
                        reminderDate =
                            DateFormat('dd-MMM-yyyy').format(selectedDate);

                        // reminderProvider.fetchReminder(reminderDate);
                        // print(reminderDate);
                        print(reminderDate);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('9:00'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
