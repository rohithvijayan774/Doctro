import 'package:booking_calendar/booking_calendar.dart';
import 'package:doctro_user/controller/user_controller.dart';
import 'package:doctro_user/model/doctor_model.dart';
import 'package:doctro_user/model/user_model.dart';
import 'package:doctro_user/views/booked_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingPage2 extends StatelessWidget {
  final DoctorModel doctors;

  const BookingPage2({
    required this.doctors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final bookingController = Provider.of<UserController>(context);
    bookingController.init(doctors.doctorid, doctors.doctorName,
        doctors.doctorProPic!, bookingController.userModel.userProPic!);
    // bookingController.init(doctors.doctorid);
    // bool isLiked = bookingController.isLiked(widget.doctors.doctorid);
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
        return FutureBuilder(
            future: bookingController
                .init(
                    doctors.doctorid,
                    doctors.doctorName,
                    doctors.doctorProPic!,
                    bookingController.userModel.userProPic!)
                .then((value) => bookingController.fetch(doctors.doctorid)),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(doctors.doctorProPic!),
                          radius: 40,
                        ),
                        // IconButton(
                        //   onPressed: () {
                        //     // bookingController.toggleLike(widget.doctors.doctorid);
                        //   },
                        //   icon: isLiked == false
                        //       ? const Icon(Icons.thumb_up_outlined)
                        //       : const Icon(Icons.thumb_up),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 10),
                          child: Text(
                            doctors.doctorName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: width,
                            // padding: EdgeInsets.only(left: 30, right: 30),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50),
                                  topLeft: Radius.circular(50)),
                            ),
                            child: Expanded(
                              child: BookingCalendar(
                                availableSlotColor: Colors.white,
                                bookingService:
                                    bookingController.mockBookingService,
                                convertStreamResultToDateTimeRanges:
                                    bookingController.convertStreamResultMock,
                                getBookingStream:
                                    bookingController.getBookingStreamMock,
                                uploadBooking:
                                    bookingController.uploadBookingMock,
                                pauseSlots:
                                    bookingController.generatePauseSlots(),
                                pauseSlotText: 'BREAK',
                                hideBreakTime: false,
                                loadingWidget: const Text('Fetching data...'),
                                uploadingWidget: const Center(
                                    child: CircularProgressIndicator()),
                                locale: 'en_US',
                                startingDayOfWeek: StartingDayOfWeek.tuesday,
                                wholeDayIsBookedWidget: const Text(
                                    'Sorry, for this day everything is booked'),

                                //disabledDates: [DateTime(2023, 1, 20)],
                                //disabledDays: [6, 7],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
            });
      }),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Container(
      //     height: hieght * .10,
      //     width: width,
      //     color: Colors.white,
      //     child: Center(
      //         child: ElevatedButton(
      //       onPressed: () {},
      //       child: Text("Book"),
      //       style: ButtonStyle(
      //           backgroundColor: MaterialStateProperty.all(Colors.blue),
      //           foregroundColor: MaterialStateProperty.all(Colors.white)),
      //     ))),
    );
  }
}
