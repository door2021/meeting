import 'package:athelets/Utils/routes.dart';
import 'package:athelets/Utils/routes2.dart';
import 'package:athelets/Utils/routes_names.dart';
import 'package:athelets/constants.dart';
import 'package:athelets/devices/desktop/Authentication/SignInScreen.dart';
import 'package:athelets/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Meetings',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        initialRoute: RouteName.Splash,
        onGenerateRoute:  Routes2.generateRoute,
      ),
    );
  }
}
