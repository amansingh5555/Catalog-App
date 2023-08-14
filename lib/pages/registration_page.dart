import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';


class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late FlutterTts flutterTts;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _beneficiaryIdController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isAgreedToTerms = false;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    _initTts();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _pincodeController.dispose();
    _beneficiaryIdController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    flutterTts.stop();
    super.dispose();
  }

  Future<void> _initTts() async {
    flutterTts = FlutterTts();
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.8);
  }

  Future<void> _speakWithPitch(String text) async {
    await flutterTts.speak(text);
  }

  void _showToast(String message) {
    Flushbar(
      message: message,
      duration: Duration(seconds: 2),
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor: Colors.black.withOpacity(0.8),
      routeColor: Colors.white,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            _buildInputField(
              controller: _nameController,
              labelText: 'Name',
              hintText: 'Enter your name',
              icon: Icons.person,
              speakLabel: 'Enter your name',
            ),
            SizedBox(height: 16.0),
            _buildInputField(
              controller: _phoneNumberController,
              labelText: 'Phone Number',
              hintText: 'Enter your phone number',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
              speakLabel: 'Enter your phone number',
            ),
            SizedBox(height: 16.0),
            _buildInputField(
              controller: _addressController,
              labelText: 'Address',
              hintText: 'Enter your address',
              icon: Icons.home,
              speakLabel: 'Enter your address',
            ),
            SizedBox(height: 16.0),
            _buildInputField(
              controller: _pincodeController,
              labelText: 'Pincode',
              hintText: 'Enter your pincode',
              icon: Icons.location_on,
              keyboardType: TextInputType.number,
              speakLabel: 'Enter your pincode',
            ),
            SizedBox(height: 16.0),
            _buildInputField(
              controller: _beneficiaryIdController,
              labelText: 'Beneficiary ID',
              hintText: 'Enter your beneficiary ID',
              icon: Icons.person_pin,
              speakLabel: 'Enter your beneficiary ID',
            ),
            SizedBox(height: 16.0),
            _buildInputField(
              controller: _emailController,
              labelText: 'Email',
              hintText: 'Enter your email',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              speakLabel: 'Enter your email',
            ),
            SizedBox(height: 16.0),
            _buildInputField(
              controller: _passwordController,
              labelText: 'Password',
              hintText: 'Choose a password',
              icon: Icons.lock,
              obscureText: true,
              speakLabel: 'Choose a password',
            ),
            SizedBox(height: 16.0),
            CheckboxListTile(
              title: Text(
                'I agree to the terms and conditions',
                style: TextStyle(fontSize: 16.0),
              ),
              value: _isAgreedToTerms,
              onChanged: (value) {
                setState(() {
                  _isAgreedToTerms = value ?? false;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isAgreedToTerms ? _submitForm : null,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(
                'Register',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? speakLabel,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
              prefixIcon: Icon(icon),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                _speakWithPitch('Please enter $labelText');
                return 'Please enter $labelText';
              }
              return null;
            },
          ),
        ),
        SizedBox(width: 8.0),
        if (speakLabel != null)
          IconButton(
            onPressed: () {
              _speakWithPitch(speakLabel);
            },
            icon: Icon(Icons.volume_up),
            tooltip: 'Speak $labelText',
          ),
      ],
    );
  }

  void _submitForm() {
    // Perform registration logic here
    String name = _nameController.text;
    String phoneNumber = _phoneNumberController.text;
    String address = _addressController.text;
    String pincode = _pincodeController.text;
    String beneficiaryId = _beneficiaryIdController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // Validation
    if (phoneNumber.length != 10) {
      _showToast('Phone number should be 10 digits');
      return;
    }

    if (beneficiaryId.length != 10) {
      _showToast('Beneficiary ID should be 10 digits');
      return;
    }

    // Print the values for demonstration purposes
    print('Name: $name');
    print('Phone Number: $phoneNumber');
    print('Address: $address');
    print('Pincode: $pincode');
    print('Beneficiary ID: $beneficiaryId');
    print('Email: $email');
    print('Password: $password');

    _showToast('Registration Successful!');
  }
}

