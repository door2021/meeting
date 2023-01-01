import 'package:athelets/providers/user_provider.dart';
import 'package:athelets/widgets/CustomTxtField.dart';
import 'package:athelets/widgets/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:athelets/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final emailTxt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
        backgroundColor: primary,
        appBar: AppBar(
          backgroundColor: primary,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text('Did you forgot your password?',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Colors.white))),
                SizedBox(
                  height: 15,
                ),
                Text(
                    'Enter your email address you’re using for your account bellow and we will send you an OTP to login and reset your password',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: white))),
                SizedBox(
                  height: 20,
                ),
                CustomTxtField(hint: 'Email', txt: emailTxt),
                SizedBox(
                  height: 30,
                ),
                user.isLoading == false ?
                MaterialButton(
                  onPressed: () async {
                    user.setIsLoading(true);
                    await firebaseAuth
                        .sendPasswordResetEmail(email: emailTxt.text)
                        .then((value) {
                      user.setIsLoading(false);
                      showToast('Reset Password link send to your email !');
                      Navigator.pop(context);
                    }).catchError((e) {
                      user.setIsLoading(false);
                      if (e.code == 'user-not-found') {
                        showToast('User not exist with this email !');
                      } else if (e.code == 'invalid-email') {
                        showToast('Invalid email! enter correct email.');
                      } else {
                        showToast(errorTxt);
                      }
                    });
                  },
                  child: Text('Send',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: primary))),
                  color: white,
                  minWidth: 220,
                  height: 40,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ) : LoadingWidget(color: white),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Text('Back to Sign In',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: white)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
