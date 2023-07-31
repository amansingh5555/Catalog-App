import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:firstproject/pages/grievance_page.dart';

class UserDashboardPage extends StatefulWidget {
  get theme => null;

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

  //void _navigateToSubmitGrievancePage() {
    //Navigator.push(
      //context,
      //MaterialPageRoute(
       // builder: (context) => SubmitGrievancePage(theme: widget.theme),
     // ),
   // );
 // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'User Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // Add more list tiles for additional options
          ],
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
          Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(

                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Colors.blue[900],
                    child: ListTile(
                      leading: Icon(
                        Icons.error,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Grievance',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    _speak('Applicable Schemes');
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Colors.blue[900],
                    child: ListTile(
                      leading: Icon(
                        Icons.assignment,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Applicable Schemes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserDashboardPage(),
  ));
}
