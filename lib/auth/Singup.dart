import 'dart:async';

import 'package:bun_wa_hal/auth/Login.dart';
import 'package:bun_wa_hal/main.dart';
import 'package:bun_wa_hal/style/styli.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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

String makeacount = "إنشـاء حساب";

//var
bool showhide = true;
DatabaseReference user;
DatabaseReference userinfo;

//firebase

//key
final _formKdey = GlobalKey<FormState>();

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
  TextEditingController _phoneNumberController = TextEditingController();

  TextEditingController _smsController = TextEditingController();

  //sms
  @override
  void initState() {
    super.initState();
    _auth.setLanguageCode("en-ch");
    setState(() {
      pickedDate = DateTime(2000, 12, 30);
    });
    Firebase.initializeApp().whenComplete(() {
      print("completed");
    });
  }

  DateTime pickedDate;
  // Example code for registration.
  bool showhiderep = true;

  void addusertofirebase() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection("users").add({
      "name": name.text.toString(),
      "phone": _phoneNumberController.text,
      "birtday": pickedDate.day.toString() +
          "/" +
          pickedDate.month.toString() +
          "/" +
          pickedDate.year.toString(),
      "points": 1,
      "savedlocation": null,
      "email": email.text.toString() ?? 'No email user dont add',
    }).then((_) {
      print("success!");
    });
  }

  final FirebaseAuth _authlog = FirebaseAuth.instance;
  bool autovalidatephone = false;
  bool autovalidatepassword = false;
  bool autovalidatepasswordrepeat = false;
  bool autovalidatename = false;
  Color namecolor = Colors.grey;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: new Text(value)));
  }

  void signInWithPhoneNumber() async {
    try {
      // ignore: unused_local_variable
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _smsController.text,
      );

      // UserCredential logcredential =
      //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //   email: _phoneNumberController.text.toString(),
      //   password: pass.text.toString(),
      // );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyApp(),
        ),
      );
    } catch (e) {
      SnackBar(
        content: Text("error , pleas try again $e"),
      );
    }
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
        _verificationId = forceResendingToken.toString();
      });
    };

    print(_verificationId);

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
          phoneNumber: "+962" + _phoneNumberController.text,
          timeout: Duration(minutes: 2),
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
    Color colorbirth = Colors.grey;

    Future<void> _selectDate(BuildContext context) async {
      DatePicker.showDatePicker(context,
          showTitleActions: true,
          minTime: DateTime(1900),
          maxTime: DateTime(2005 ?? 1),
          theme: DatePickerTheme(
              headerColor: Colors.green.withOpacity(0.7),
              backgroundColor: Colors.green.withOpacity(0.7),
              itemStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
          onChanged: (date) {
        if (date != null) {
          setState(() {
            colorbirth = Colors.black;
            pickedDate = date;
          });
        }
      }, onConfirm: (date) {
        if (date != null) {
          setState(() {
            pickedDate = date;
          });
        }
      }, currentTime: DateTime.now(), locale: LocaleType.en);
      // final DateTime pickedDate = await showDatePicker(
      //     context: context,
      //     initialDate: currentDate,
      //     lastDate: new DateTime.now().add(new Duration(days: currentDate.day)),
      //     firstDate: DateTime(1900));
      // if (pickedDate != null && pickedDate != currentDate) {
      //   setState(() {
      //     currentDate = pickedDate;
      //   });
    }

    TextEditingController _birthController = TextEditingController(
      text: pickedDate.year.toString() +
          "/" +
          pickedDate.month.toString() +
          "/" +
          pickedDate.day.toString(),
    );

    ScrollController controller = ScrollController();
    return Form(
      key: _formKdey,
      child: Container(
        height: MediaQuery.of(context).size.height - 20,
        width: MediaQuery.of(context).size.width - 20,
        child: Scaffold(
          key: _scaffoldKey,
          body: SingleChildScrollView(
            controller: controller,
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
                      makeacount,
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 30),
                    )),
                  ),
                  Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, right: 25, left: 25, bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "الإسم",
                                    textAlign: TextAlign.right,
                                    style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.w600,
                                        color: Colora().brown,
                                        fontSize: 15),
                                  ),
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                          color: Color(0xff663A2B), width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.account_circle,
                                          color: Colors.brown,
                                        ),
                                        title: TextFormField(
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'هاذا الحقل مطلوب';
                                            }
                                            return null;
                                          },
                                          textAlign: TextAlign.right,
                                          autovalidate: autovalidatename,
                                          onChanged: (_) {
                                            setState(() {
                                              autovalidatename = true;
                                            });
                                          },
                                          maxLength: 15,
                                          decoration: InputDecoration(
                                            // border: OutlineInputBorder(
                                            //     borderRadius: BorderRadius.circular(20),
                                            //     borderSide: BorderSide(width: 2),
                                            //     gapPadding: 10),

                                            counterText: "",
                                            border: InputBorder.none,
                                          ),
                                          controller: name,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5, right: 25, left: 25, bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "رقم الهاتف",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w600,
                                    color: Colora().brown,
                                    fontSize: 15),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      color: Color(0xff663A2B), width: 1)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.call,
                                      color: Colors.brown,
                                    ),
                                    trailing: Text("962+"),
                                    title: TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'هاذا الحقل مطلوب';
                                        } else if (value.startsWith('0')) {
                                          return 'الرداء حذف ال 0 بعد +962';
                                        } else if (value.length < 9) {
                                          return 'الرجاء ادخال رقم هاتف صحيح';
                                        } else if (regex.hasMatch(value)) {
                                          return 'الرجاء ادخال رقم هاتف صحيح';
                                        } else if (value.startsWith('0')) {
                                          return 'الرجاء حذف ال 0 بعد +962';
                                        }
                                        return null;
                                      },
                                      textAlign: TextAlign.left,
                                      autovalidate: autovalidatephone,
                                      onSaved: (_) {
                                        setState(() {
                                          autovalidatephone = true;
                                        });
                                      },
                                      onEditingComplete: () {
                                        setState(() {
                                          autovalidatephone = true;
                                        });
                                      },
                                      maxLength: 9,
                                      decoration: InputDecoration(
                                        // border: OutlineInputBorder(
                                        //     borderRadius: BorderRadius.circular(20),
                                        //     borderSide: BorderSide(width: 2),
                                        //     gapPadding: 10),

                                        counterText: "",
                                        border: InputBorder.none,
                                      ),
                                      controller: _phoneNumberController,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5, right: 25, left: 25, bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "كلمة المرور",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w600,
                                    color: Colora().brown,
                                    fontSize: 15),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      color: Color(0xff663A2B), width: 1)),
                              child: ListTile(
                                leading: IconButton(
                                  icon: Icon(Icons.visibility),
                                  color: Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      showhide = !showhide;
                                    });
                                  },
                                ),
                                trailing: Icon(Icons.lock, color: Colors.brown),
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      autovalidate: autovalidatepassword,
                                      onSaved: (_) {
                                        setState(() {
                                          autovalidatepassword = true;
                                        });
                                      },
                                      onEditingComplete: () {
                                        setState(() {
                                          autovalidatepassword = true;
                                        });
                                      },
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
                                        counterStyle: TextStyle(
                                          color: Colors.grey.withOpacity(0.7),
                                        ),
                                        // border: OutlineInputBorder(
                                        //     borderRadius: BorderRadius.circular(20),
                                        //     borderSide: BorderSide(width: 2),
                                        //     gapPadding: 10),
                                        //
                                        //
                                        counterText: "",
                                        contentPadding:
                                            EdgeInsetsDirectional.only(
                                                start: 20,
                                                end: 6,
                                                bottom: 0,
                                                top: 0),
                                        border: InputBorder.none,
                                        hintStyle: GoogleFonts.cairo(
                                            fontSize: 15, color: Colors.grey),
                                      ),
                                      controller: pass,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5, right: 25, left: 25, bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "تأكيد كلمة المرور",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w600,
                                    color: Colora().brown,
                                    fontSize: 15),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      color: Color(0xff663A2B), width: 1)),
                              child: ListTile(
                                leading: IconButton(
                                  icon: Icon(Icons.visibility),
                                  color: Colors.grey,
                                  onPressed: () {
                                    setState(() {
                                      showhiderep = !showhiderep;
                                    });
                                  },
                                ),
                                trailing:
                                    Icon(Icons.repeat, color: Colors.brown),
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      autovalidate: autovalidatepasswordrepeat,
                                      onSaved: (_) {
                                        setState(() {
                                          autovalidatepasswordrepeat = true;
                                        });
                                      },
                                      onEditingComplete: () {
                                        setState(() {
                                          autovalidatepasswordrepeat = true;
                                        });
                                      },
                                      textAlign: TextAlign.right,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'هاذا الحقل مطلوب';
                                        } else if (value.length < 8) {
                                          return 'كلمة السر قصيرة جدا';
                                        } else if (value != pass.text) {
                                          return 'لا يوجد تطابق في كلمة السر';
                                        }
                                        return null;
                                      },
                                      obscureText: showhiderep,
                                      expands: false,
                                      maxLength: 16,
                                      decoration: InputDecoration(
                                        counterStyle: TextStyle(
                                          color: Colors.grey.withOpacity(0.7),
                                        ),
                                        // border: OutlineInputBorder(
                                        //     borderRadius: BorderRadius.circular(20),
                                        //     borderSide: BorderSide(width: 2),
                                        //     gapPadding: 10),
                                        //
                                        //
                                        counterText: "",
                                        contentPadding:
                                            EdgeInsetsDirectional.only(
                                                start: 20,
                                                end: 6,
                                                bottom: 0,
                                                top: 0),
                                        border: InputBorder.none,
                                        hintStyle: GoogleFonts.cairo(
                                            fontSize: 15, color: Colors.grey),
                                      ),
                                      controller: passrep,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5, right: 25, left: 25, bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "تاريخ الميلاد(إختياري)",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w600,
                                    color: Colora().brown,
                                    fontSize: 15),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      color: Color(0xff663A2B), width: 1)),
                              child: ListTile(
                                trailing: Icon(Icons.cake, color: Colors.brown),
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      style: TextStyle(
                                          color: Colors.black,
                                          decorationColor: colorbirth),
                                      textAlign: TextAlign.right,
                                      onTap: () {
                                        _selectDate(context);
                                        setState(() {
                                          colorbirth = Colors.black;
                                        });
                                      },
                                      readOnly: true,
                                      cursorWidth: 0,
                                      cursorColor: Colors.white,
                                      cursorHeight: 0,
                                      expands: false,
                                      decoration: InputDecoration(
                                        counterStyle: TextStyle(
                                          color: Colors.grey.withOpacity(0.7),
                                        ),
                                        // border: OutlineInputBorder(
                                        //     borderRadius: BorderRadius.circular(20),
                                        //     borderSide: BorderSide(width: 2),
                                        //     gapPadding: 10),
                                        //
                                        //
                                        counterText: "",
                                        contentPadding:
                                            EdgeInsetsDirectional.only(
                                                start: 20,
                                                end: 6,
                                                bottom: 0,
                                                top: 0),
                                        border: InputBorder.none,
                                        hintStyle: GoogleFonts.cairo(
                                            fontSize: 15, color: Colors.grey),
                                      ),
                                      controller: _birthController,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      OTP == true
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, right: 25, left: 25, bottom: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "رمز التحقق",
                                            textAlign: TextAlign.right,
                                            style: GoogleFonts.cairo(
                                                fontWeight: FontWeight.w600,
                                                color: Colora().brown,
                                                fontSize: 15),
                                          )),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            side: BorderSide(
                                                color: Color(0xff663A2B),
                                                width: 1)),
                                        child: ListTile(
                                          trailing: Icon(Icons.lock,
                                              color: Colors.brown),
                                          title: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: TextFormField(
                                                textAlign: TextAlign.right,
                                                readOnly: false,
                                                cursorWidth: 0,
                                                cursorColor: Colors.white,
                                                cursorHeight: 0,
                                                expands: false,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'هاذا الحقل مطلوب';
                                                  } else if (value.length < 6) {
                                                    return 'الرجاء ادخال رمز تحقق صحيح';
                                                  }
                                                  return null;
                                                },
                                                onSaved: (value) {},
                                                maxLength: 6,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  counterStyle: TextStyle(
                                                    color: Colors.grey
                                                        .withOpacity(0.7),
                                                  ),
                                                  // border: OutlineInputBorder(
                                                  //     borderRadius: BorderRadius.circular(20),
                                                  //     borderSide: BorderSide(width: 2),
                                                  //     gapPadding: 10),
                                                  //
                                                  //
                                                  counterText: "",
                                                  contentPadding:
                                                      EdgeInsetsDirectional
                                                          .only(
                                                              start: 20,
                                                              end: 6,
                                                              bottom: 0,
                                                              top: 0),
                                                  border: InputBorder.none,
                                                  hintStyle: GoogleFonts.cairo(
                                                      fontSize: 15,
                                                      color: Colors.grey),
                                                ),
                                                controller: _smsController,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
                                        child: Text(
                                          "اعادة الارسال؟         ",
                                          style: TextStyle(color: Colors.grey),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            )
                          : Container(
                              height: 1,
                              width: 1,
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 200,
                          height: 50,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            color: Color(0xff789C3B),
                            child: Center(
                              child: Text(
                                makeacount,
                                style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKdey.currentState.validate()) {
                                if (OTP == false) {
                                  try {
                                    // ignore: await_only_futures
                                    await verifyPhoneNumber();
                                    showInSnackBar('سيتم ارسال رمز تحقق');
                                    sharedPreferences(context);
                                    addusertofirebase();
                                    setState(() {
                                      makeacount = "ادخال الرمز";
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
                                            "الرجاء ادخال كلمة مرور او بريد صحيح" +
                                                error.toString(),
                                          ),
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
                                          title:
                                              Text("Something went wrong $e"),
                                        );
                                      },
                                    );
                                  }
                                }
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Row(
                          children: [
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoginScreenPage()));
                              },
                              child: Text(
                                "تملك حسابا ؟ سجل دخول",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  codewellsent() {
    return SnackBar(
      content: Text("not supported yet"),
    );
  }

  sharedPreferences(BuildContext context) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    sharedPreferences.setString(
        'phone', "+962" + _phoneNumberController.text.toString());
    sharedPreferences.setString('password', pass.text.toString());
    sharedPreferences.setString('name', name.text.toString());

    // Navigator.pushReplacement(
    // context, MaterialPageRoute(builder: (context) => MyApp()));
  }
}

Future<void> send(BuildContext context) async {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore.instance.collection("users").add({
    'الاسم': name.text,
    'البريد الالكتروني': email.text,
    'رقم الهاتف': "+" + phone.text,
    'عدد النقاط': 1
  });
}
