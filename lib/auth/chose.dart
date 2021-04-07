import 'package:bun_wa_hal/auth/Login.dart';
import 'package:bun_wa_hal/auth/Singup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class chose extends StatefulWidget {
  @override
  _choseState createState() => _choseState();
}

double elevation = 0;

// ignore: camel_case_types
class _choseState extends State<chose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, bottom: 120, left: 70, right: 70),
                child: Center(
                  child: Image.asset(
                    'Images/logo.png',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 200,
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          color: Color(0xff663A2B),
                          child: Center(
                            child: Text(
                              "انشــاء حساب",
                              style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {});
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Singup()));
                          },
                        ),
                      ),
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
                                "تسجيل الدخول",
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreenPage()));
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              //   Padding(
              //     padding: const EdgeInsets.all(18.0),
              //     child: Center(
              //       child: Text(
              //         "تسجيل الدخول باستخدام",
              //         style: GoogleFonts.cairo(
              //             fontWeight: FontWeight.w600,
              //             color: Colors.grey,
              //             fontSize: 20),
              //       ),
              //     ),
              //   ),
              //   Padding(
              //     padding: const EdgeInsets.all(5.0),
              //     child: Center(
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.all(0),
              //             child: Center(
              //               child: ClipRRect(
              //                 borderRadius: BorderRadius.circular(40),
              //                 child: Container(
              //                   width: 150,
              //                   height: 50,
              //                   child: FlatButton.icon(
              //                     icon: FaIcon(
              //                       FontAwesomeIcons.facebook,
              //                       color: Colors.white,
              //                     ),
              //                     color: Colors.blue,
              //                     label: Text(
              //                       "FACEBOOK",
              //                       style: TextStyle(color: Colors.white),
              //                     ),
              //                     onPressed: () {},
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.all(0),
              //             child: Center(
              //               child: ClipRRect(
              //                 borderRadius: BorderRadius.circular(40),
              //                 child: Container(
              //                   width: 150,
              //                   height: 50,
              //                   child: RaisedButton.icon(
              //                     color: Colors.red,
              //                     icon: FaIcon(
              //                       FontAwesomeIcons.google,
              //                       color: Colors.white,
              //                     ),
              //                     label: Text(
              //                       "GOOGLE",
              //                       style: TextStyle(color: Colors.white),
              //                     ),
              //                     onPressed: () {},
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   )
            ],
          ),
        ),
      ),
    );
  }
}
