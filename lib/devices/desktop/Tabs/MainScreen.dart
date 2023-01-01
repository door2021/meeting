import 'package:athelets/Utils/routes_names.dart';
import 'package:athelets/constants.dart';
import 'package:athelets/devices/desktop/Tabs/HomeScreen.dart';
import 'package:athelets/devices/desktop/Tabs/MeetingsScreen.dart';
import 'package:athelets/devices/desktop/Tabs/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  final tabs = [HomeTab(), Meetings(), Profile()];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    var user = Provider.of<UserProvider>(context, listen: false);
    user.fetchAllUser();
    user.fetchAllMeeting();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
        body: webTab == 0 ? HomeTab() : webTab == 1 ? Meetings() : Profile(),
        appBar: AppBar(
          backgroundColor: primary,
          iconTheme: IconThemeData(color: white),
        ),
        drawer: Drawer(
          backgroundColor: primary,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 60,),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(user.user!.profilePicture!),
                  ),
                  SizedBox(height: 60,),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        webTab = 0;
                      });
                      Navigator.pop(context);
                      // Navigator.pushNamed(context, RouteName.home);
                    },
                    child: ListTile(
                      leading: Image.asset(
                        'assets/bottomIcons/home.png',
                        height: 40,
                        width: 40,
                      ),
                      title: Text('Users', style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: white)),),
                      trailing: Icon(Icons.arrow_forward_ios, size: 22, color: white,),
                    ),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        webTab = 1;
                      });
                      Navigator.pop(context);
                      // Navigator.pushNamed(context, RouteName.meeting);
                    },
                    child: ListTile(
                      leading: Image.asset(
                        'assets/bottomIcons/athletes.png',
                        height: 40,
                        width: 40,
                      ),
                      title: Text('Meetings', style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: white))),
                      trailing: Icon(Icons.arrow_forward_ios, size: 22, color: white,),
                    ),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        webTab = 2;
                      });
                      Navigator.pop(context);
                      // Navigator.pushNamed(context, RouteName.profile);
                    },
                    child: ListTile(
                      leading: Image.asset(
                        'assets/bottomIcons/person.png',
                        height: 40,
                        width: 40,
                      ),
                      title: Text('Profile', style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: white))),
                      trailing: Icon(Icons.arrow_forward_ios, size: 22, color: white,),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
