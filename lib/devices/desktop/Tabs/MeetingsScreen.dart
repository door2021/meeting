import 'package:athelets/models/meeting_model.dart';
import 'package:athelets/providers/user_provider.dart';
import 'package:athelets/widgets/loadingWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../constants.dart';

class Meetings extends StatelessWidget {
  const Meetings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 50),
              child: Text(
                'All Meetings',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    textStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: 450,
                minWidth: 200,
              ),
              child: ListView.builder(
                  itemCount: user.meetingList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return user.meetingList[index].arrangeWith == user.user!.uid
                        ? GestureDetector(
                      onTap: () async {
                        if (user.meetingList[index].status == 'Rejected') {
                          showToast('Meeting had been canceled');
                        } else if (user.meetingList[index].status ==
                            'Completed') {
                          showToast(
                              'Meeting had arranged on ${user.meetingList[index].selectedDate} at ${user.meetingList[index].selectedTime}');
                        } else {
                          showMeeting(context, user.meetingList[index]);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        color: Colors.grey.shade100,
                        margin: EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(user
                                      .usersList
                                      .where((u) =>
                                  u.uid ==
                                      user.meetingList[index]
                                          .arrangeBy)
                                      .first
                                      .profilePicture!),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  user.usersList
                                      .where((u) =>
                                  u.uid ==
                                      user.meetingList[index]
                                          .arrangeBy)
                                      .first
                                      .userName!,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              user.meetingList[index].status == 'Pending'
                                  ? 'Invite you for meeting'
                                  : user.meetingList[index].status ==
                                  'Rejected'
                                  ? 'Meeting had been canceled'
                                  : 'Meeting had arranged on ${user.meetingList[index].selectedDate} at ${user.meetingList[index].selectedTime}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: primary,
                            )
                          ],
                        ),
                      ),
                    )
                        : user.meetingList[index].arrangeBy == user.user!.uid ? GestureDetector(
                      onTap: () async {
                        showToast('Wait for other party decision !');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        color: Colors.grey.shade100,
                        margin: EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(user
                                      .usersList
                                      .where((u) =>
                                  u.uid ==
                                      user.meetingList[index]
                                          .arrangeWith)
                                      .first
                                      .profilePicture!),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  user.usersList
                                      .where((u) =>
                                  u.uid ==
                                      user.meetingList[index]
                                          .arrangeWith)
                                      .first
                                      .userName!,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              user.meetingList[index].status == 'Pending'
                                  ? 'Wait for other party decision'
                                  : user.meetingList[index].status ==
                                  'Rejected'
                                  ? 'Meeting had been canceled'
                                  : 'Meeting had arranged on ${user.meetingList[index].selectedDate} at ${user.meetingList[index].selectedTime}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: primary,
                            )
                          ],
                        ),
                      ),
                    ) : Container();
                  }),
            )
          ],
        ),
      ),
    );
  }

  showMeeting(ctx, MeetingModel m) {
    bool isLoading = false;
    var user = Provider.of<UserProvider>(ctx, listen: false);
    var times = [];
    var dates = [];

    m.availableTimes!.forEach((t) {
      times.add({'time': t, 'select': false});
    });

    m.availableDates!.forEach((d) {
      DateTime date = (d as Timestamp).toDate();
      dates.add(
          {'date': DateFormat('dd-MM-yyyy').format(date), 'select': false});
    });

    showModalBottomSheet(
        context: ctx,
        builder: (ctx) {
          return StatefulBuilder(
              builder: (BuildContext ctx, StateSetter setState) {
            return Container(
              height: 400,

              color: primary,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      constraints: BoxConstraints(
                        minWidth: 200,
                        maxWidth: 400
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Available Dates',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: white)),
                          ),
                          Container(
                            height: 35,
                            margin: EdgeInsets.only(top: 10),
                            width: MediaQuery.of(ctx).size.width,
                            child: ListView.builder(
                                itemCount: dates.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (dates[index]['select'] == false) {
                                        setState(() {
                                          dates[index]['select'] = true;
                                        });

                                        dates.forEach((t) {
                                          if (t['date'] != dates[index]['date'] &&
                                              t['select'] == true) {
                                            setState(() {
                                              t['select'] = false;
                                            });
                                          }
                                        });
                                      } else {
                                        setState(() {
                                          dates[index]['select'] = false;
                                        });
                                      }
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            right:
                                            index == dates.length - 1 ? 0 : 10),
                                        color: dates[index]['select'] == false
                                            ? Colors.grey.shade200
                                            : Colors.lightBlue,
                                        padding: EdgeInsets.symmetric(horizontal: 12),
                                        child: Center(
                                            child: Text(
                                              '${dates[index]['date']}',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                      dates[index]['select'] == false
                                                          ? Colors.black
                                                          : Colors.white,
                                                      fontWeight: FontWeight.w500)),
                                            ))),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Available Times',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: white)),
                          ),
                          Container(
                            height: 35,
                            margin: EdgeInsets.only(top: 10),
                            width: MediaQuery.of(ctx).size.width,
                            child: ListView.builder(
                                itemCount: times.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (times[index]['select'] == false) {
                                        setState(() {
                                          times[index]['select'] = true;
                                        });

                                        times.forEach((t) {
                                          if (t['time'] != times[index]['time'] &&
                                              t['select'] == true) {
                                            setState(() {
                                              t['select'] = false;
                                            });
                                          }
                                        });
                                      } else {
                                        setState(() {
                                          times[index]['select'] = false;
                                        });
                                      }
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            right:
                                            index == times.length - 1 ? 0 : 10),
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
                                                      color:
                                                      times[index]['select'] == false
                                                          ? Colors.black
                                                          : Colors.white,
                                                      fontWeight: FontWeight.w500)),
                                            ))),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          isLoading == false
                              ? Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () async {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      await user.updateMeetingById(
                                          int.parse(m.uid!),
                                          {'status': "Rejected"}).then((value) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        showToast('Meeting had been updated');
                                        user.fetchAllMeeting();
                                        Navigator.pop(ctx);
                                      }).catchError((e) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      });
                                    },
                                    child: Text('Reject',
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.red))),
                                    color: white,
                                    height: 45,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () async {
                                      if(dates.where((d) => d['select'] == true).length < 1){
                                        showToast('Select available date !');
                                      }else if(times.where((t) => t['select'] == true).length < 1){
                                        showToast('Select available time !');
                                      }else{
                                        setState(() {
                                          isLoading = true;
                                        });

                                        await user.updateMeetingById(
                                            int.parse(m.uid!), {
                                          'status': "Completed", 'selectedDate': dates.where((d) => d['select'] == true).first['date'], 'selectedTime':  times.where((t) => t['select'] == true).first['time']
                                        }).then((value) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          showToast('Meeting had been updated');
                                          user.fetchAllMeeting();
                                          Navigator.pop(ctx);
                                        }).catchError((e) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        });
                                      }
                                    },
                                    child: Text('Update',
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: primary))),
                                    color: white,
                                    height: 45,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                )
                              ],
                            ),
                          )
                              : LoadingWidget(color: white)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }
}
