import 'dart:math';

import 'package:athelets/devices/mobile/Tabs/MainScreen.dart';
import 'package:athelets/widgets/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:athelets/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../providers/user_provider.dart';
import '../../../../widgets/CustomTxtField.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final nameTxt = TextEditingController();
  final emailTxt = TextEditingController();
  final passTxt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Icon(
                Icons.people_alt_outlined,
                color: white,
                size: 80,
              ),
              SizedBox(
                height: 20,
              ),
              Text('Lets Sign you up',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.white))),
              SizedBox(
                height: 30,
              ),
              CustomTxtField(hint: 'Username', txt: nameTxt),
              SizedBox(
                height: 20,
              ),
              CustomTxtField(hint: 'Email', txt: emailTxt),
              SizedBox(
                height: 20,
              ),
              CustomTxtField2(hint: 'Password', txt: passTxt, isSecure: true),
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 30,
              ),
              user.isLoading == false
                  ? MaterialButton(
                onPressed: () async {
                  var rating = 0 +  Random().nextInt(5);

                  var data = {
                    'name': nameTxt.text,
                    'email': emailTxt.text,
                    'profilePicture':
                    'https://i.pravatar.cc/150?img=3',
                    'rating': rating.toString(),
                    'isSignIn': true,
                  };

                  if (passTxt.text.length < 6) {
                    showToast(
                        'Your password should greater then 6 characters');
                  } else {
                    await signUp(context, data);
                  }
                },
                child: Text('Sign Up',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: primary))),
                color: white,
                minWidth: 220,
                height: 40,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              )
                  : LoadingWidget(
                color: Colors.white,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account ? ',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: white)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Sign In',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: white)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  signUp(ctx, data) async {
    var user = Provider.of<UserProvider>(ctx, listen: false);

    user.setIsLoading(true);

    await user.signUpUser(data, passTxt.text.trim()).then((value) {
      user.setIsLoading(false);

      if (value['success'] == true) {
        showToast('Account created successfully !');
        Navigator.push(
            ctx,
            MaterialPageRoute(
                builder: (context) => Main()));
      } else {
        showToast(errorTxt);
      }
    }).catchError((e) {
      print(e);
      user.setIsLoading(false);
        showToast(errorTxt);
    });
  }
}
