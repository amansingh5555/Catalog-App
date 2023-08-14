
import 'package:firstproject/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:firstproject/pages/user_dashboard.dart';
import 'package:firstproject/pages/admin_dashboard.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Role'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Grievance Department page
              },
              child: Text('Grievance Department'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.UserRoute);
                // Navigate to User page
              },
              child: Text('User'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.AdminRoute);
              },
              child: Text('Admin'),
            ),
          ],
        ),
      ),
    );
  }
}

