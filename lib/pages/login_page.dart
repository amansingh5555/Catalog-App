import 'package:firstproject/util/routes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  final _formKey = GlobalKey<FormState>();
  moveTOHome(BuildContext context){}

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
                "assests/image/login_page.png",
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text (
                "Welcome $name",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16,horizontal:32 ),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter UserName",
                        labelText: "UserName",
                      ),
                      validator: (value){
                        if(value != null && value.isEmpty){
                          return "UserName cannot be empty";
                        }
                        return null;
                      },

                      onChanged: (value){
                        name = value ;
                        setState(() {

                        });
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter PassWord",
                        labelText: "Password",
                      ),
                      validator: (value){
                        if(value != null && value.isEmpty){
                          return "Password cannot be empty";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),

              Builder(
                builder: (BuildContext context) {
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamed(context, MyRoutes.HomeRoute);
                      }
                    },
                    style: ElevatedButton.styleFrom(),
                    child: Text("Login"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}