import 'package:athelets/devices/desktop/Authentication/ForgotPasswordScreen.dart';
import 'package:athelets/devices/desktop/Authentication/SignUpScreen.dart';
import 'package:athelets/devices/desktop/Tabs/MainScreen.dart';
import 'package:athelets/widgets/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:athelets/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../providers/user_provider.dart';
import '../../../../widgets/CustomTxtField.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailTxt = TextEditingController();
  final passTxt = TextEditingController();
  bool _isObscure = true;

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
              Text('Lets Sign you in',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.white))),
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
                    CustomTxtField(hint: 'Email', txt: emailTxt),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTxtField2(hint: 'Password', txt: passTxt, isSecure: true),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: Text('Forgot Password ?', style: GoogleFonts.poppins(textStyle: TextStyle(color: white, fontWeight: FontWeight.w500))),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              user.isLoading == false
                  ? MaterialButton(
                      onPressed: () async {
                        if (emailTxt.text.isEmpty || passTxt.text.isEmpty) {
                          showToast('Email or password are incorrect');
                        }
                        if (passTxt.text.length < 6) {
                          showToast(
                              'Your password should greater then 6 characters');
                        } else {
                          await signIn(context);
                        }
                      },
                      child: Text('Sign In',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: primary))),
                      color: white,
                      minWidth: 220,
                      height: 45,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    )
                  : LoadingWidget(
                      color: Colors.white,
                    ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have an account ? ',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: white)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      'Sign Up',
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

  signIn(ctx) async {
    var user = Provider.of<UserProvider>(ctx, listen: false);

    user.setIsLoading(true);

    user
        .signInUser(emailTxt.text.trim(), passTxt.text.trim())
        .then((value) async {
      user.setIsLoading(false);

      if (value['success'] == true) {

        await user.updateUser(user.user!.uid, {'isSignIn': true});

        await user.fetchUserById(user.user!.uid);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Main()));
      } else {
        user.setIsLoading(false);
      }
    }).catchError((e) {
      print(e);
      user.setIsLoading(false);

      if (e.code == 'user-not-found') {
        showToast('User with this email not found !');
      } else if (e.code == 'invalid-email') {
        showToast('Invalid email! enter correct email.');
      } else if (e.code == 'wrong-password') {
        showToast('Your password is incorrect.');
      } else {
        showToast(errorTxt);
      }
    });
  }
}
