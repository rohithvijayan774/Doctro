import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  BookingPage({super.key});
  List<String> times = [
    "Time: 10.00 to 12.00",
    "Time: 1.00 to 3.00",
    "Time: 3.00 to 6.00",
  ];

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhb_tTLAas4h8fw7zHFEm1y4iLqUtGtiMpai0NNBRH2KCOQaW3BHMpbdO0OesMtxgtY2A&usqp=CAU'),
            radius: 40,
          ),
          const Text("Dr name "),
          Expanded(
            child: Container(
              width: width,
              padding: const EdgeInsets.only(left: 30, right: 30),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50)),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 30,
                        ),
                        child: Text(
                          'Book Appointment',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: IconButton(
                            onPressed: () async {
                              final result = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2000, 1, 1),
                                  lastDate: DateTime(2050, 12, 31),
                                  initialDate: DateTime.now());

                              print(result);
                            },
                            icon: const Icon(Icons.calendar_month)),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        // itemBuilder: (context, index) {
                        //   return Text("time");
                        // },
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.times[index]),
                              SizedBox(
                                width: width,
                                height: hieght * .23,
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 8,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 1,
                                          crossAxisSpacing: 30,
                                          mainAxisSpacing: 30,
                                          crossAxisCount: 4),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  116, 151, 207, 0.525),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          height: 60,
                                          width: 60,
                                          child: Center(
                                              child: Text("${index + 1}")),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: 3),
                  )
                ],
              ),
            ),
          ),
          Container(
              height: hieght * .10,
              width: width,
              color: Colors.white,
              child: Center(
                  child: ElevatedButton(
                onPressed: () {},
                child: const Text("Book"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    foregroundColor: MaterialStateProperty.all(Colors.white)),
              ))),
        ],
      ),
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
