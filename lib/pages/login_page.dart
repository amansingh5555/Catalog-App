import 'package:firstproject/pages/registration_page.dart';
import 'package:firstproject/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  final _formKey = GlobalKey<FormState>();
  FlutterTts flutterTts = FlutterTts();
  stt.SpeechToText speech = stt.SpeechToText();
  String recognizedText = "";

  @override
  void initState() {
    super.initState();
    initSpeechRecognition();
  }

  @override
  void dispose() {
    speech.stop();
    flutterTts.stop();
    super.dispose();
  }

  Future<void> initSpeechRecognition() async {
    bool available = await speech.initialize();
    if (available) {
      speech.listen(
        onResult: (result) {
          if (result.finalResult) {
            setState(() {
              recognizedText = result.recognizedWords;
            });
          }
        },
        listenFor: Duration(seconds: 5), // Set the duration to listen
      );
    } else {
      print('Speech recognition not available');
    }
  }

  Future<void> toggleSpeechRecognition() async {
    if (!speech.isListening) {
      bool available = await speech.initialize();
      if (available) {
        speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              setState(() {
                recognizedText = result.recognizedWords;
              });
            }
          },
          listenFor: Duration(seconds: 5), // Set the duration to listen
        );
      } else {
        print('Speech recognition not available');
      }
    } else {
      speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                "assests/image/login_page.jpg",
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20.0),
              Text(
                "Welcome $name",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Enter UserName",
                              labelText: "UserName",
                            ),
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                _speakWithPitch("Please enter UserName", 1);
                                return "UserName cannot be empty";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                name = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 8.0),
                        IconButton(
                          onPressed: () {
                            _speakWithPitch("Enter UserName", 1);
                          },
                          icon: Icon(Icons.volume_up),
                          tooltip: "Speak UserName",
                        ),
                        IconButton(
                          onPressed: toggleSpeechRecognition,
                          icon: Icon(Icons.mic),
                          tooltip: "Toggle Speech Recognition",
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Enter Password",
                              labelText: "Password",
                            ),
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                _speakWithPitch("Please enter username and Password", 1.0);
                                return "Password cannot be empty";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 8.0),
                        IconButton(
                          onPressed: () {
                            _speakWithPitch("Enter Password", 1.0);
                          },
                          icon: Icon(Icons.volume_up),
                          tooltip: "Speak Password",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _speakWithPitch("Login", 1.0);
                    Navigator.pushNamed(context, MyRoutes.UserRoute);
                  }
                },
                style: ElevatedButton.styleFrom(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.login),
                    SizedBox(width: 8.0),
                    Text("Login"),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.RegistrationRoute);
                },
                child: Text(
                  "Not registered yet? Sign up",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text("Recognized Text: $recognizedText"),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _speakWithPitch(String text, double pitch) async {
    await flutterTts.setPitch(pitch);
    await flutterTts.speak(text);
  }
}