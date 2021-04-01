import 'package:bun_wa_hal/style/styli.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences localStorge;

class LoginScreenPage extends StatelessWidget {
  static Future init() async {
    localStorge = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

final _formKey = GlobalKey<FormState>();
TextEditingController phone = TextEditingController();
TextEditingController pass = TextEditingController();
bool showhide = false;

class _LoginState extends State<Login> {
  bool codeSent;
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  void dispose() {
    pass.dispose();
    super.dispose();
  }

  String virId;

  TextEditingController _phoneNumberController =
      TextEditingController(text: '+962');

  // Example code for registration.
  // Future<void> login() async {
  // final PhoneAuthProvider user = (await _auth.verifyPhoneNumber(
  // phoneNumber: phone.text,
  // codeSent: PhoneCodeSent(),
  // ));
  // if (user != null) {
  // setState(() {
  // _success = true;
  // _userphone = user.providerId;
  // });
  // } else {
  // _success = false;
  // }
  // }
//
  // Future<void> virifiId(phoneNo) async {
  // final PhoneVerificationCompleted verified = (AuthCredential UserCredential) {
  // AuthService().signIn(UserCredential);
  // };
//
  // final PhoneVerificationFailed verificationfailed =
  // (AuthException authException) {
  // print('${authException.message}');
  // };
//
  // final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
  // this.virId = verId;
  // setState(() {
  // this.codeSent = true;
  // });
  // };
//
  // final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
  // this.virId = verId;
  // };
//
  // await FirebaseAuth.instance.verifyPhoneNumber(
  // phoneNumber: phoneNo,
  // timeout: const Duration(seconds: 5),
  // verificationCompleted: verified,
  // verificationFailed: verificationfailed,
  // codeSent: smsSent,
  // codeAutoRetrievalTimeout: autoTimeout);
  // }

  bool autovalidatephone = false;

  @override
  Widget build(BuildContext context) {
    Pattern pattern = r'^(?:[+0]9)?[0-9]{10}$';
    RegExp regex = new RegExp(pattern);
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Center(
                      child: Text(
                    "تسجيل الدخول",
                    style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w600,
                        color: Colora().grey,
                        fontSize: 30),
                  )),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        child: ListTile(
                          trailing: Icon(Icons.call, color: Colors.brown),
                          title: TextFormField(
                            textAlign: TextAlign.right,
                            autovalidate: autovalidatephone,
                            onChanged: (_) {
                              setState(() {
                                autovalidatephone = true;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'هاذا الحقل مطلوب';
                              } else if (value.length < 13) {
                                return 'الرجاء ادخال رقم هاتف صحيح';
                              } else if (!regex.hasMatch(value)) {
                                return 'الرجاء ادخال رقم هاتف صحيح , عدم وضع احرف او رموز';
                              } else if (value.startsWith('+9620')) {
                                return 'الرجاء حذف ال 0 بعد +962';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                            expands: false,
                            maxLength: 13,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsetsDirectional.only(
                                    start: 6, end: 6, bottom: 0, top: 0),
                                hintStyle: GoogleFonts.cairo(
                                    fontSize: 20, color: Colors.brown),
                                hintText: "رقم الهاتف"),
                            controller: _phoneNumberController,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        child: ListTile(
                          leading: IconButton(
                            icon: Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                showhide = !showhide;
                              });
                            },
                          ),
                          trailing: Icon(Icons.lock, color: Colora().brown),
                          title: TextFormField(
                            textAlign: TextAlign.right,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'هاذا الحقل مطلوب';
                              } else if (value.length < 8) {
                                return 'كلمة السر قصيرة جدا';
                              }
                              return null;
                            },
                            obscureText: showhide,
                            expands: false,
                            maxLength: 16,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsetsDirectional.only(
                                    start: 6, end: 6, bottom: 0, top: 0),
                                hintStyle: GoogleFonts.cairo(
                                    fontSize: 20, color: Colora().brown),
                                hintText: "كلمة المرور"),
                            controller: pass,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0.0, bottom: 0, left: 30, right: 30),
                      child: Container(
                        width: 350,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: FlatButton(
                              color: Colora().green,
                              child: Text(
                                "تسجيل الدخول",
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    color: Colora().white,
                                    fontSize: 20),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  try {
                                    Login();
                                    print("ok");
                                    save();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreenPage()));
                                  } catch (error) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Text(
                                            "الرجاء ادخال كلمة سر او بريد الكتروني صحيح");
                                      },
                                    );
                                  }
                                } else {
                                  return null;
                                }
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

save() async {
  await LoginScreenPage.init();
  localStorge.setString('phone', phone.text.toString());
  localStorge.setString('password', pass.toString());
  print("ll");
}
