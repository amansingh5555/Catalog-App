import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:firstproject/pages/grievance_page.dart';
import 'package:firstproject/pages/schemes_page.dart';
import 'package:firstproject/pages/applied_schemes_page.dart';
import 'package:firstproject/pages/help_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserDashboardPage(),
  ));
}

class UserDashboardPage extends StatefulWidget {
  @override
  _UserDashboardPageState createState() => _UserDashboardPageState();
}

class _UserDashboardPageState extends State<UserDashboardPage> {
  final List<String> images = [
    'assests/image/image1.jpg',
    'assests/image/image2.jpg',
  ];

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;
  Timer? _timer;

  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    flutterTts.stop();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPageIndex < images.length - 1) {
        _currentPageIndex++;
      } else {
        _currentPageIndex = 0;
      }
      _pageController.animateToPage(
        _currentPageIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  Future<void> _speak(String text) async {
    await flutterTts.speak(text);
  }

  void _navigateToPage(String pageTitle) {
    _speak(pageTitle);
    if (pageTitle == 'Grievance Page') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GrievancePage(),
        ),
      );
    } else if (pageTitle == 'Schemes Page') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SchemePage(),
        ),
      );
    } else if (pageTitle == 'Applied Schemes') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AppliedSchemesPage(),
        ),
      );
    } else if (pageTitle == 'Need Help') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HelpPage(),
        ),
      );
    }
    // Add more navigation conditions for other pages here
  }

  Widget _buildOptionCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String pageTitle,
  }) {
    return GestureDetector(
      onTap: () {
        _speak(title);
        _navigateToPage(pageTitle);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4,
        child: ListTile(
          contentPadding: EdgeInsets.all(16.0),
          leading: Icon(
            icon,
            color: iconColor,
            size: 40,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: GestureDetector(
            onTap: () {
              _speak(title);
            },
            child: Icon(
              Icons.volume_up,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Dashboard'),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.indigo, // Change the drawer background color
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.indigo,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/user_avatar.jpg'),
                      radius: 30,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'John Doe',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold, // Make the name bold
                      ),
                    ),
                    Text(
                      'john.doe@example.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  'Schemes',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold, // Make the title bold
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _navigateToPage('Schemes Page');
                },
              ),
              ListTile(
                title: Text(
                  'Applied Schemes',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold, // Make the title bold
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _navigateToPage('Applied Schemes');
                },
              ),
              ListTile(
                title: Text(
                  'Grievance',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold, // Make the title bold
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _navigateToPage('Grievance Page');
                },
              ),
              ListTile(
                title: Text(
                  'Need Help',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold, // Make the title bold
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _navigateToPage('Need Help');
                },
              ),
              // Add more list tiles for additional options
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.30,
            child: PageView.builder(
              controller: _pageController,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16.0),
          _buildOptionCard(
            icon: Icons.assignment,
            iconColor: Colors.green,
            title: 'Schemes',
            pageTitle: 'Schemes Page',
          ),
          SizedBox(height: 16.0),
          _buildOptionCard(
            icon: Icons.event_available_outlined,
            iconColor: Colors.blueGrey,
            title: 'Applied Schemes',
            pageTitle: 'Applied Schemes',
          ),
          SizedBox(height: 24.0),
          _buildOptionCard(
            icon: Icons.message_outlined,
            iconColor: Colors.purple,
            title: 'Grievance',
            pageTitle: 'Grievance Page',
          ),
          SizedBox(height: 16.0),
          _buildOptionCard(
            icon: Icons.help,
            iconColor: Colors.brown,
            title: 'Need Help',
            pageTitle: 'Need Help',
          ),
          // Add more option cards here
        ],
      ),
    );
  }
}
