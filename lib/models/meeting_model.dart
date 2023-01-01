import 'package:cloud_firestore/cloud_firestore.dart';

class MeetingModel {
  String? uid;
  String? arrangeBy;
  String? arrangeWith;
  String? duration;
  List<dynamic>? availableDates;
  List<dynamic>? availableTimes;
  String? selectedDate;
  String? selectedTime;
  String? status;

  MeetingModel.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot.get('uid').toString() ?? '',
        arrangeBy = snapshot.get('arrangeBy') ?? '',
        arrangeWith = snapshot.get('arrangeWith') ?? '',
        duration = snapshot.get('duration') ?? '',
        availableDates = snapshot.get('availableDates') ?? [],
        availableTimes = snapshot.get('availableTimes') ?? [],
        selectedDate = snapshot.get('selectedDate') ?? '',
        selectedTime = snapshot.get('selectedTime') ?? '',
        status = snapshot.get('status') ?? '';
}
