import 'package:firstproject/pages/home_page.dart';
import 'package:firstproject/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:firstproject/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: GoogleFonts.lato().fontFamily,

      ),
      routes: {
        "/":(context) => LoginPage(),
        MyRoutes.HomeRoute:(context)=>HomePage(),
        MyRoutes.LoginRoute:(context)=>LoginPage(),

      //  "/login":(context) =>LoginPage(),
      },
    );
  }
}
