import 'dart:async';

import 'package:bun_wa_hal/auth/Login.dart';
import 'package:bun_wa_hal/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Singup(),
    );
  }
}

class Singup extends StatefulWidget {
  @override
  _SingupState createState() => _SingupState();
}

//var
bool showhide = false;
DatabaseReference user;
DatabaseReference userinfo;
//firebase

//key
final _formKdey = GlobalKey<FormState>();

//Time
DateTime currentDate = DateTime.now();
// ignore: non_constant_identifier_names
bool OTP = false;
//TextEditing controllers
final TextEditingController name = TextEditingController();
final TextEditingController email = TextEditingController();
final TextEditingController birth = TextEditingController();
final TextEditingController phone = TextEditingController();
final TextEditingController pass = TextEditingController();
final TextEditingController passrep = TextEditingController();
Pattern pattern = r'^\+[1-9]{1}[0-9]{3,14}$';
RegExp regex = new RegExp(pattern);

class _SingupState extends State<Singup> {
  //Key

  //auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _verificationId;

  //Controller
  TextEditingController _phoneNumberController =
      TextEditingController(text: '+962');
  TextEditingController _smsController = TextEditingController();

  //sms
  @override
  void initState() {
    super.initState();
    _auth.setLanguageCode("en-ch");

    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  // Example code for registration.

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        lastDate: new DateTime.now().add(new Duration(days: currentDate.day)),
        firstDate: DateTime(1900));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  void signInWithPhoneNumber() async {
    try {
      // ignore: unused_local_variable
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _smsController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyApp(),
        ),
      );
    } catch (e) {}
  }

  void verifyPhoneNumber() async {
    //Veification complet
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
    };

    //Code
    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      setState(() {
        _verificationId = verificationId;
      });
    };

    //autou timeout
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    //on Failed
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {};

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: _phoneNumberController.text,
          timeout: const Duration(minutes: 2),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(e),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKdey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              textDirection: TextDirection.rtl,
              textBaseline: TextBaseline.ideographic,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 18),
                  child: Center(
                      child: Text(
                    "انشاء الحساب",
                    style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 30),
                  )),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        child: ListTile(
                          trailing: Icon(
                            Icons.account_circle,
                            color: Colors.brown,
                          ),
                          title: TextFormField(
                            textAlign: TextAlign.right,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'هاذا الحقل مطلوب';
                              }
                              return null;
                            },
                            expands: false,
                            maxLength: 15,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsetsDirectional.only(
                                  start: 6, end: 6, bottom: 0, top: 0),
                              hintStyle: GoogleFonts.cairo(
                                  fontSize: 20, color: Colors.brown),
                              hintText: "الأسم",
                            ),
                            controller: name,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        child: ListTile(
                          trailing: Icon(Icons.mail, color: Colors.brown),
                          title: TextFormField(
                            textAlign: TextAlign.right,
                            onSaved: (value) {},
                            expands: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsetsDirectional.only(
                                    start: 6, end: 6, bottom: 0, top: 0),
                                hintStyle: GoogleFonts.cairo(
                                    fontSize: 20, color: Colors.brown),
                                hintText: "البريد الالكتروني(اختياري)"),
                            controller: email,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        child: ListTile(
                          trailing: Icon(Icons.call, color: Colors.brown),
                          title: TextFormField(
                            textAlign: TextAlign.right,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'هاذا الحقل مطلوب';
                              } else if (value.length < 10) {
                                return 'الرجاء ادخال رقم هاتف صحيح';
                              } else if (!regex.hasMatch(value)) {
                                return 'الرجاء ادخال رقم هاتف صحيح , عدم وضع احرف او رموز';
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
                    Container(
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              showhide = !showhide;
                            });
                          },
                        ),
                        trailing: Icon(Icons.lock, color: Colors.brown),
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
                                  fontSize: 20, color: Colors.brown),
                              hintText: "كلمة المرور"),
                          controller: pass,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        child: ListTile(
                          trailing: Icon(Icons.repeat, color: Colors.brown),
                          title: TextFormField(
                            textAlign: TextAlign.right,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'هاذا الحقل مطلوب';
                              } else if (value.length < 8) {
                                return 'كلمة السر قصيرة جدا';
                              } else if (value != pass.text) {
                                return 'لا يوجد تتطابق';
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
                                    fontSize: 20, color: Colors.brown),
                                hintText: "تاكيد كلمة المرور"),
                            controller: passrep,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                          child: ListTile(
                            trailing: Icon(Icons.cake, color: Colors.brown),
                            title: Container(
                              child: Text(
                                currentDate.year.toString() +
                                    "/" +
                                    currentDate.month.toString() +
                                    "/" +
                                    currentDate.day.toString(),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    OTP == true
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  child: ListTile(
                                    trailing: Icon(
                                      Icons.verified,
                                      color: Colors.brown,
                                    ),
                                    title: TextFormField(
                                      textAlign: TextAlign.right,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'هاذا الحقل مطلوب';
                                        } else if (value.length < 6) {
                                          return 'الرجاء ادخال رقم تحقق صحيح';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {},
                                      expands: false,
                                      maxLength: 6,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsetsDirectional.only(
                                                  start: 6,
                                                  end: 6,
                                                  bottom: 0,
                                                  top: 0),
                                          hintStyle: GoogleFonts.cairo(
                                              fontSize: 20,
                                              color: Colors.brown),
                                          hintText: "رمز التحقق"),
                                      controller: _smsController,
                                    ),
                                  ),
                                ),
                              ),
                              // ignore: deprecated_member_use
                              Row(
                                children: [
                                  Spacer(),
                                  InkWell(
                                      onTap: () {
                                        verifyPhoneNumber();
                                      },
                                      child: Text("اعادة الارسال؟         ")),
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
                                                builder: (context) =>
                                                    LoginScreen()));
                                      },
                                      child: Text(
                                          " تملك حسابا ؟ سجل دخول        ")),
                                ],
                              )
                            ],
                          )
                        : Container(
                            height: 1,
                            width: 1,
                          ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 24.0, bottom: 0, left: 30, right: 30),
                      child: Container(
                        width: 350,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          // ignore: deprecated_member_use
                          child: FlatButton(
                              color: Colors.green,
                              child: Text(
                                "انشاء حساب",
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                              onPressed: () async {
                                if (_formKdey.currentState.validate()) {
                                  if (OTP == false) {
                                    try {
                                      // ignore: await_only_futures
                                      await verifyPhoneNumber();
                                      sharedPreferences(context);
                                      setState(() {
                                        OTP = true;
                                      });
                                      // Navigator.of(context).pushReplacement(
                                      // MaterialPageRoute(
                                      // builder: (context) => chose()));
                                    } catch (error) {
                                      print(error);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                                "الرجاء ادخال كلمة مرور او بريد صحيح"),
                                          );
                                        },
                                      );
                                    }
                                  } else {
                                    try {
                                      // ignore: await_only_futures
                                      await signInWithPhoneNumber();
                                      sharedPreferences(context);
                                    } catch (e) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  "Something went wrong $e"),
                                            );
                                          });
                                    }
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

  sharedPreferences(BuildContext context) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('phone', _phoneNumberController.text);
    sharedPreferences.setString('password', pass.text.toString());
    sharedPreferences.setString('name', name.text.toString());

    // Navigator.pushReplacement(
    // context, MaterialPageRoute(builder: (context) => MyApp()));
  }
}

Future<void> send(BuildContext context) async {
  user = FirebaseDatabase.instance.reference().child('user');
  userinfo = FirebaseDatabase.instance.reference().child('user_info');
  user.push().set(<String, String>{
    'الاسم': name.text,
    'البريد الالكتروني': email.text,
    'رقم الهاتف': phone.text,
  });
  userinfo.push().set(<String, dynamic>{
    'الرقم التسلسلي': '76162846830',
    'تاريخ انشاء الحساب': DateTime.now().toString(),
  }).whenComplete(() => print("sent successfully"));
}
