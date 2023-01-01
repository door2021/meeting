import 'package:athelets/Utils/routes_names.dart';
import 'package:athelets/providers/user_provider.dart';
import 'package:athelets/widgets/CustomTxtField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../widgets/loadingWidget.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final nameTxt = TextEditingController();
  final emailTxt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.only(bottom: 35),
                child: Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(user.user!.profilePicture!),
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  minWidth: 200,
                  maxWidth: 400
                ),
                child: Column(
                  children: [
                    CustomTxtField3(
                      label: 'Username',
                      hint: 'Username',
                      txt: nameTxt..text = user.user!.userName!,
                      enabled: false,
                    ),
                    SizedBox(height: 15,),
                    CustomTxtField3(
                      label: 'Email',
                      hint: 'Email',
                      txt: emailTxt..text = user.user!.email!,
                      enabled: false,
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
                        user.setIsLoading(true);
                        await user.signOutUser().then((value) async {

                          await user.updateUser(user.user!.uid, {'isSignIn': false});

                          Future.delayed(Duration(seconds: 2)).then((value) {
                            user.setIsLoading(false);
                            user.setSelectedTab(0);
                            setState(() {
                              webTab = 0;
                            });

                            Navigator.pushNamedAndRemoveUntil(context, RouteName.SignIn, (route) => false);
                          });
                        });
                      },
                      child: Text('Sign Out',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: white))),
                      color: primary,
                      minWidth: 220,
                      height: 45,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    )
                  : LoadingWidget(
                      color: primary,
                    ),
            ]),
          ),
        ),
      ),
    );
  }
}
