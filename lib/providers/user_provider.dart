import 'dart:io';

import 'package:athelets/constants.dart';
import 'package:athelets/models/meeting_model.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  //for main screen tabs
  int selectedTab = 0;

  UserModel? user;
  List<UserModel> usersList = [];
  List<MeetingModel> meetingList = [];

  bool isLoading = false;
  String? searchTxt = '';

  setSelectedTab(val) {
    selectedTab = val;
    notifyListeners();
  }

  setSearchTxt(val) {
    searchTxt = val;
    notifyListeners();
  }

  setIsLoading(val) {
    isLoading = val;
    notifyListeners();
  }

  Future signInUser(email, password) async {
    var mmsg = {};

    var msg = await service.signIn(email, password);

    if (msg.data() != null) {
      user = UserModel.fromSnapshot(msg);
      mmsg.addAll({'success': true});
      notifyListeners();
    } else {
      mmsg.addAll({'success': false});
    }

    return mmsg;
  }

  Future signUpUser(data, pass) async {
    var msg = {};

    var smsg = await service.signUp(data, pass);
    if (smsg.data() != null) {
      user = UserModel.fromSnapshot(smsg);
      msg.addAll({'success': true});
      notifyListeners();
    } else {
      msg.addAll({'success': false});
    }

    return msg;
  }

  Future fetchUserById(uid) async {
    var msg = await service.fetchDocumentById("users", uid);
    user = UserModel.fromSnapshot(msg);
    notifyListeners();
  }

  Future fetchAllUser() async {
    var msg = await service.fetchDocuments("users");

    if (usersList.isNotEmpty) {
      usersList.clear();

      msg.docs.forEach((doc) {
        UserModel u = UserModel.fromSnapshot(doc);
        usersList.add(u);
        notifyListeners();
      });
    } else {
      msg.docs.forEach((doc) {
        UserModel u = UserModel.fromSnapshot(doc);
        usersList.add(u);
        notifyListeners();
      });
    }

    if(usersList.length > 0){
      usersList
          .sort((a, b) => int.parse(a.rating!).compareTo(int.parse(b.rating!)));
    }
  }

  Future fetchAllMeeting() async {
    var msg = await service.fetchDocuments("meetings");

    if (meetingList.isNotEmpty) {
      meetingList.clear();

      msg.docs.forEach((doc) {
        MeetingModel m = MeetingModel.fromSnapshot(doc);
        meetingList.add(m);
        notifyListeners();
      });
    } else {
      msg.docs.forEach((doc) {
        MeetingModel m = MeetingModel.fromSnapshot(doc);
        meetingList.add(m);
        notifyListeners();
      });
    }
  }

  Future updateUser(uid, data) async {
    var msg = await service.updateDocument("users", uid, data);
    return msg;
  }

  Future postMeeting(data) async {
    var msg = await service.postDocument("meetings", data);
    return msg;
  }

  Future updateMeeting(uid, data) async {
    var msg = await service.updateDocument("meetings", uid, data);
    return msg;
  }

  Future updateMeetingById(uid, data) async {
    var msg = await service.updateDocumentById("meetings", uid, data);
    return msg;
  }

  Future<String> postStorage(dir, data) async {
    var msg = await service.postStorage(dir, data);
    return msg;
  }

  Future signOutUser() async {
    var msg = await service.signOut();
    return msg;
  }
}
