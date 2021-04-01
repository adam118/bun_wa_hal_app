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
                    top: 0.0, bottom: 150, left: 70, right: 70),
                child: Center(
                  child: Image.asset(
                    'Images/logo.png',
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, bottom: 0, left: 50, right: 50),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        height: 60,
                        width: 120,
                        color: Colors.green,
                        child: TextButton(
                          child: Text("انشاء حساب",
                              style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              )),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Singup()));
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, bottom: 30, left: 50, right: 50),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        height: 60,
                        width: 120,
                        color: Colors.green,
                        child: TextButton(
                            child: Text(
                              "تسجيل الدخول",
                              style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreenPage()));
                            }),
                      ),
                    ),
                  )
                ],
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
