import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final String title;

  LoginScreen({
    Key key, 
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 100,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  obscureText: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
