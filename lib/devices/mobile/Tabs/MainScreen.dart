import 'package:athelets/devices/mobile/Tabs/HomeScreen.dart';
import 'package:athelets/devices/mobile/Tabs/MeetingsScreen.dart';
import 'package:athelets/devices/mobile/Tabs/ProfileScreen.dart';
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
        body: tabs[user.selectedTab],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromRGBO(2, 13, 40, 1),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedLabelStyle: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
          unselectedLabelStyle: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
          onTap: (val) {
            user.setSelectedTab(val);
          },
          items: [
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  child: Image.asset(
                    'assets/bottomIcons/home.png',
                    height: 40,
                    width: 40,
                  ),
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  child: Image.asset(
                    'assets/bottomIcons/athletes.png',
                    height: 40,
                    width: 40,
                  ),
                ),
                label: 'Meeting'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 8, top: 5),
                  child: Image.asset(
                    'assets/bottomIcons/person.png',
                    height: 40,
                    width: 40,
                  ),
                ),
                label: 'Profile'),
          ],
        ),
    );
  }
}
