import 'dart:async';

import 'package:bun_wa_hal/auth/Singup.dart';
import 'package:bun_wa_hal/style/styli.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Future<void> Log() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LoginScreen());
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "phone auth",
      home: LoginScreenPage(),
    );
  }
}

class LoginScreenPage extends StatefulWidget {
  LoginScreenPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginScreenPageState createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  //Key
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Controller
  TextEditingController _phoneNumberController =
      TextEditingController(text: '+962');
  TextEditingController _smsController = TextEditingController();

  //sms

  @override
  void initState() {
    super.initState();
    _auth.setLanguageCode("en-ch");
  }

  //wighet bulid
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colora().brown),
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Image.asset(
              'Images/logo.png',
              scale: 10,
            ),
          ),
          centerTitle: true,
        ),
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(labelText: 'phone'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.center,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      color: Colora().brown,
                      child: Text(
                        'التحقق من الرقم',
                        style: TextStyle(color: Colora().white),
                      ),
                      onPressed: () async {
                        // verifyPhoneNumber();
                      },
                    ),
                  ),
                  TextField(
                    controller: _smsController,
                    decoration:
                        const InputDecoration(labelText: 'Verification code'),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16.0),
                    alignment: Alignment.center,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                        color: Colors.greenAccent[200],
                        onPressed: () async {
                          // signInWithPhoneNumber();
                        },
                        child: Text("Log in")),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      InkWell(
                          onTap: () {}, child: Text("اعادة الارسال؟         ")),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Sing()));
                          },
                          child: Text("الا تملك حسابا ؟ انشئ حساب        ")),
                    ],
                  )
                ],
              ),),
        ),);
  }
}
