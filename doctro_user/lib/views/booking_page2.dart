import 'package:booking_calendar/booking_calendar.dart';
import 'package:doctro_user/views/booked_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingPage2 extends StatefulWidget {
  final String drName;
  BookingPage2({required this.drName, super.key});
  List<String> times = [
    "Time: 10.00 to 12.00",
    "Time: 1.00 to 3.00",
    "Time: 3.00 to 6.00",
  ];

  @override
  State<BookingPage2> createState() => _BookingPage2State();
}

class _BookingPage2State extends State<BookingPage2> {
  final now = DateTime.now();
  late BookingService mockBookingService;

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
    ///disabledDays will properly work with real data
    DateTime first = now;
    DateTime tomorrow = now.add(const Duration(days: 1));
    DateTime second = now.add(const Duration(minutes: 55));
    DateTime third = now.subtract(const Duration(minutes: 240));
    DateTime fourth = now.subtract(const Duration(minutes: 500));
    converted.add(
        DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
    converted.add(DateTimeRange(
        start: second, end: second.add(const Duration(minutes: 23))));
    converted.add(DateTimeRange(
        start: third, end: third.add(const Duration(minutes: 15))));
    converted.add(DateTimeRange(
        start: fourth, end: fourth.add(const Duration(minutes: 50))));

    //book whole day example
    converted.add(DateTimeRange(
        start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 5, 0),
        end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 0)));
    return converted;
  }

  @override
  void initState() {
    super.initState();
    // DateTime.now().startOfDay
    // DateTime.now().endOfDay
    mockBookingService = BookingService(
        serviceName: 'Mock Service',
        serviceDuration: 30,
        bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
        bookingStart: DateTime(now.year, now.month, now.day, 8, 0));
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    print('${newBooking.toJson()} has been uploaded');
    String formatttedDate =
        DateFormat('dd-MM-yy').format(newBooking.bookingStart);
    String formatttedTime = DateFormat('jm').format(newBooking.bookingStart);
    print('////////////$formatttedDate/////////');
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BookDetails(
          drName: widget.drName, date: formatttedDate, time: formatttedTime),
    ));
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 12, 0),
          end: DateTime(now.year, now.month, now.day, 13, 0))
    ];
  }

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
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhb_tTLAas4h8fw7zHFEm1y4iLqUtGtiMpai0NNBRH2KCOQaW3BHMpbdO0OesMtxgtY2A&usqp=CAU'),
            radius: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            child: Text(
              widget.drName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              width: width,
              // padding: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50)),
              ),
              child: Expanded(
                child: BookingCalendar(
                  bookingService: mockBookingService,
                  convertStreamResultToDateTimeRanges: convertStreamResultMock,
                  getBookingStream: getBookingStreamMock,
                  uploadBooking: uploadBookingMock,
                  pauseSlots: generatePauseSlots(),
                  pauseSlotText: 'LUNCH',
                  hideBreakTime: false,
                  loadingWidget: const Text('Fetching data...'),
                  uploadingWidget:
                      Center(child: const CircularProgressIndicator()),
                  locale: 'en_US',
                  startingDayOfWeek: StartingDayOfWeek.tuesday,
                  wholeDayIsBookedWidget:
                      const Text('Sorry, for this day everything is booked'),

                  //disabledDates: [DateTime(2023, 1, 20)],
                  //disabledDays: [6, 7],
                ),
              ),
            ),
          ),
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
