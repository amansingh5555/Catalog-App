import 'package:flutter/material.dart';
import 'package:firstproject/pages/manage_schemes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue, // Change this to match your app's theme color
      ),
      home: AdminPage(),
    );
  }
}

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildOptionCard(
              context,
              'Manage Schemes',
              'Add or remove assistance schemes.',
              Icons.extension,
              Colors.purple,
            ),
            buildOptionCard(
              context,
              'User Database',
              'View and manage user accounts.',
              Icons.people,
              Colors.teal,
            ),
            buildOptionCard(
              context,
              'Manage Grievances',
              'Handle user grievances and complaints.',
              Icons.warning,
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, String routeName) {
    if (routeName == 'Manage Schemes') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ManageSchemesPage()),
      );
    }
    // Add navigation logic for other options here if needed
  }

  Widget buildOptionCard(BuildContext context, String title, String description, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        _navigateToPage(context, title);
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(icon, size: 32.0, color: color),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8.0),
                    Text(description),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
