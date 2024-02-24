import 'package:doctro_user/controller/user_controller.dart';
import 'package:flutter/material.dart';
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
                return ListView.builder(
                  itemCount: bookControl.bookingsList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(),
                      title: Text(bookControl.bookingsList[index].doctorName),
                      subtitle:
                          Text(bookControl.bookingsList[index].bookingTime),
                    );
                  },
                );
              });
        }));
  }
}
