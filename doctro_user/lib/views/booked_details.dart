import 'package:flutter/material.dart';

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
        body: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    // boxShadow:,
                    color: Color.fromARGB(91, 137, 202, 255),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  height: hieght * .15,
                  width: width * .9,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://static.vecteezy.com/system/resources/thumbnails/028/287/555/small/an-indian-young-female-doctor-isolated-on-green-ai-generated-photo.jpg'),
                          radius: 40,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title(color: Colors.black, child: Text("Doctor name")),
                                  // Title(color: Colors.black, child: Text("Date")),
                                  // Title(color: Colors.black, child: Text("Time slot")),
                                  Text(widget.drName),
                                  Text(widget.date),
                                  Text(widget.time),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 230),
                  child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(110, 40)),
                          textStyle: MaterialStateProperty.all(
                              const TextStyle(fontSize: 20)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 23, 127, 213)),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45)))),
                      child: const Text("Cancel")),
                ),
              ],
            ),
          ),
        ));
  }
}
