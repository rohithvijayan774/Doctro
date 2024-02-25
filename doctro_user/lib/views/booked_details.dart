import 'package:cool_alert/cool_alert.dart';
import 'package:doctro_user/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookDetails extends StatefulWidget {
  final String drName;
  final String date;
  final String time;
  const BookDetails(
      {required this.drName,
      required this.date,
      required this.time,
      super.key});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          //title

          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          title: const Padding(
            padding: EdgeInsets.only(left: 50),
            child: Text(
              "Booked Details",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Consumer<UserController>(builder: (context, bookControl, _) {
          return FutureBuilder(
              future: bookControl.fetchBookings(),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : bookControl.bookingsList.isEmpty
                        ? const Center(
                            child: Text('No Bookings Found'),
                          )
                        : ListView.builder(
                            itemCount: bookControl.bookingsList.length,
                            itemBuilder: (context, index) {
                              String formatttedDate = DateFormat('dd-MM-yy')
                                  .format(DateTime.parse(bookControl
                                      .bookingsList[index].bookingTime));
                              String formatttedTime = DateFormat('jm').format(
                                  DateTime.parse(bookControl
                                      .bookingsList[index].bookingTime));
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Card(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(bookControl
                                          .bookingsList[index].doctorProPic),
                                    ),
                                    title: Text(
                                      bookControl
                                          .bookingsList[index].doctorName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    subtitle: Text(
                                        '$formatttedDate • $formatttedTime'),
                                    trailing: TextButton(
                                      onPressed: () {
                                        //cool alert box (cool_alert: ^2.0.1)
                                        CoolAlert.show(
                                            onConfirmBtnTap: () {
                                              bookControl
                                                  .deleteBooking(
                                                      'users',
                                                      bookControl.firebaseAuth
                                                          .currentUser!.uid,
                                                      bookControl
                                                          .bookingsList[index]
                                                          .bookingid)
                                                  .then(
                                                    (value) => bookControl
                                                        .deleteBooking(
                                                      'doctors',
                                                      bookControl
                                                          .bookingsList[index]
                                                          .doctorid,
                                                      bookControl
                                                          .bookingsList[index]
                                                          .bookingid,
                                                    ),
                                                  );
                                            },
                                            context: context,
                                            type: CoolAlertType.confirm,
                                            text:
                                                "You want to cancel the Booking",
                                            widget: TextFormField(
                                              decoration: const InputDecoration(
                                                hintText:
                                                    "please enter the reason",
                                              ),
                                            ));
                                        //cool alert box end!!
                                      },
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red)),
                                      child: const Text("cancel"),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
              });
        }));
  }
}
