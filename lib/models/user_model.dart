import 'package:athelets/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? userName;
  String? email;
  String? profilePicture;
  String? rating;
  bool? isSignIn;

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot.get('uid') ?? '',
        userName = snapshot.get('name') ?? '',
        email = snapshot.get('email') ?? '',
        profilePicture = snapshot.get('profilePicture') ?? '',
        rating = snapshot.get('rating') ?? '',
        isSignIn = snapshot.get('isSignIn') ?? '';
}
