import 'dart:math';

import 'package:athelets/constants.dart';
import 'package:athelets/providers/user_provider.dart';
import 'package:athelets/widgets/CustomTxtField.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../widgets/loadingWidget.dart';

class ArrangeMeeting extends StatefulWidget {
  ArrangeMeeting({Key? key, this.uid}) : super(key: key);

  final String? uid;

  @override
  State<ArrangeMeeting> createState() => _ArrangeMeetingState();
}

class _ArrangeMeetingState extends State<ArrangeMeeting> {
  List<DateTime?> datesList = [];

  final durationTxt = TextEditingController();

  @override
  void initState() {
    setState(() {
      datesList.clear();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: primary,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 80,
                    color: black,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                      width: 100,
                      child: Divider(
                        color: black,
                        thickness: 1.0,
                      )),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.person,
                    size: 80,
                    color: black,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Meeting Duration',
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
              ),
              SizedBox(
                width: 120,
                child: TextField(
                  controller: durationTxt,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: primary)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: primary)),
                      hintText: 'Type hours...',
                      hintStyle: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 14, color: Colors.grey.shade500))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Select Dates',
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
              ),
              Container(
                height: 250,
                margin: EdgeInsets.only(top: 15, bottom: 20),
                color: Colors.grey.shade100,
                width: MediaQuery.of(context).size.width,
                child: CalendarDatePicker2(
                  config: CalendarDatePicker2Config(
                    calendarType: CalendarDatePicker2Type.multi,
                  ),
                  onValueChanged: (dates) {
                    setState(() {
                      datesList = dates;
                    });
                    print(datesList);
                  },
                  initialValue: datesList,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Select Times',
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
              ),
              Container(
                height: 35,
                margin: EdgeInsets.only(top: 15, bottom: 20),
                color: Colors.grey.shade100,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: times.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (times[index]['select'] == false) {
                            setState(() {
                              times[index]['select'] = true;
                            });
                          } else {
                            setState(() {
                              times[index]['select'] = false;
                            });
                          }
                        },
                        child: Container(
                            margin: EdgeInsets.only(
                                right: index == times.length - 1 ? 0 : 10),
                            color: times[index]['select'] == false
                                ? Colors.grey.shade200
                                : Colors.lightBlue,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Center(
                                child: Text(
                              '${times[index]['time']}',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 12,
                                      color: times[index]['select'] == false ? Colors.black : Colors.white,
                                      fontWeight: FontWeight.w500)),
                            ))),
                      );
                    }),
              ),
              user.isLoading == false
                  ? MaterialButton(
                      onPressed: () async {
                        if (datesList.length < 1) {
                          showToast('Select dates for arranging meeting !');
                        } else {
                          await postMeeting();
                        }
                      },
                      child: Text('Create Meeting',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: white))),
                      color: primary,
                      minWidth: 220,
                      height: 40,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    )
                  : LoadingWidget(
                      color: primary,
                    ),
              SizedBox(height: 15,)
            ],
          ),
        ),
      ),
    );
  }

  postMeeting() async {
    var user = Provider.of<UserProvider>(context, listen: false);

    var id = Random().nextInt(999999);

    var timesList = [];

    times.forEach((t) {
      if(t['select'] == true){
        timesList.add(t['time']);
      }
    });

    var data = {
      'uid': id,
      'arrangeBy': user.user!.uid,
      'arrangeWith': widget.uid,
      'duration': durationTxt.text,
      'availableDates': datesList,
      'availableTimes': timesList,
      'selectedDate': '',
      'selectedTime': '',
      'status': 'Pending'
    };

    user.setIsLoading(true);

    await user.postMeeting(data).then((value) {
      user.setIsLoading(false);

      user.fetchAllMeeting();

      showToast('Meeting created successfully');

      Navigator.pop(context);
    }).catchError((e){
      user.setIsLoading(false);

      showToast(errorTxt);
    });
  }
}

var times = [
  {'time': '12:00 AM', 'select': false},
  {'time': '1:00 AM', 'select': false},
  {'time': '2:00 AM', 'select': false},
  {'time': '3:00 AM', 'select': false},
  {'time': '4:00 AM', 'select': false},
  {'time': '5:00 AM', 'select': false},
  {'time': '6:00 AM', 'select': false},
  {'time': '7:00 AM', 'select': false},
  {'time': '8:00 AM', 'select': false},
  {'time': '9:00 AM', 'select': false},
  {'time': '10:00 AM', 'select': false},
  {'time': '11:00 AM', 'select': false},
  {'time': '12:00 PM', 'select': false},
  {'time': '1:00 PM', 'select': false},
  {'time': '2:00 PM', 'select': false},
  {'time': '3:00 PM', 'select': false},
  {'time': '4:00 PM', 'select': false},
  {'time': '5:00 PM', 'select': false},
  {'time': '6:00 PM', 'select': false},
  {'time': '7:00 PM', 'select': false},
  {'time': '8:00 PM', 'select': false},
  {'time': '9:00 PM', 'select': false},
  {'time': '10:00 PM', 'select': false},
  {'time': '11:00 PM', 'select': false}
];
