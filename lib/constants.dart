import 'package:athelets/services/firebaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

var txt = 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.';

FirebaseFirestore fireStore = FirebaseFirestore.instance;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseStorage storage = FirebaseStorage.instance;
SharedPreferences? prefs;
FirebaseService service = FirebaseService();

var date = DateTime.now();

int webTab = 0;

var todayDate = date.day.toString() +
    '/' +
    date.month.toString() +
    '/' +
    date.year.toString();

showToast(msg) {
  Fluttertoast.showToast(
      msg: msg, backgroundColor: Colors.black, toastLength: Toast.LENGTH_SHORT,);
}

String errorTxt = 'Something went wrong! try again';

final paymentMethods = ['assets/payments/visa.png', 'assets/payments/mastercard.png', 'assets/payments/stripe.png', 'assets/payments/paypal.png', 'assets/payments/applepay.png', 'assets/payments/gpay.png'];

final genders = ['Male', 'Female'];

//Custom App Bar
Widget CustomAppBar({String? title, Icon? icon}){
  return AppBar(
    elevation: 0.0,
    backgroundColor: Color.fromRGBO(2, 13, 40, 1),
    centerTitle: true,
    title: Text(title!,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.white))),
  );
}

Color primary = Color.fromRGBO(2, 13, 40, 1);
Color white = Colors.white;
Color black = Colors.black;
