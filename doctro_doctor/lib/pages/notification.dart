import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NotiFication extends StatefulWidget {
  NotiFication({super.key});
  // List<String> doctorsName = [
  //   "Admin",
  //   "doctor 2",
  //   "doctor 3",
  // ];
  List<String> message = [
    "Lorem Ipsum is  the industry's ",
    "Contrary to popular . It has roots in a piece of classical Latin literature from 45 BC, making it over 2000",
    "here are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour,here are many variations of passages of Lorem Ipsum available, but the majorithere are many variations of passages of Lorem Ipsum available, but the majorithere are many variations of passages of Lorem Ipsum available, but the majorithere are many variations of passages of Lorem Ipsum available, but the majorit ",
  ];
  List<String> times = [
    "times ",
    "times 1",
    "times 2",
  ];

  @override
  State<NotiFication> createState() => _NotiFicationState();
}

class _NotiFicationState extends State<NotiFication> {
  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          'Notification',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: widget.message.length,
          itemBuilder: (context, index) {
            return Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 40),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Admin",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: hieght * .1,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              widget.message[index],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(widget.times[index]),
                        )
                      ],
                    ),
                  ),
                  height: hieght * .2,
                  width: width * .9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(34, 42, 133, 244),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
