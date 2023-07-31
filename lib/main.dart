import 'package:firstproject/pages/home_page.dart';
import 'package:firstproject/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:firstproject/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firstproject/pages/registration_page.dart';
import 'package:firstproject/pages/user_dashboard.dart';
import 'package:firstproject/pages/grievance_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
        fontFamily: GoogleFonts.lato().fontFamily,
        primarySwatch: Colors.indigo, // Updated primarySwatch to indigo
        primaryColorDark: Colors.indigo[900], // Added primaryColorDark for dark variant
      ),
      routes: {
        "/": (context) => LoginPage(),
        MyRoutes.UserRoute: (context) => UserDashboardPage(),
        MyRoutes.HomeRoute: (context) => HomePage(),
        MyRoutes.LoginRoute: (context) => LoginPage(),
        MyRoutes.RegistrationRoute: (context) => RegistrationPage(),
     //    MyRoutes.GrievanceRoute:(context) => SubmitGrievancePage(),
      },
    );
  }
}
