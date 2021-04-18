import 'package:bun_wa_hal/style/styli.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class getFromPlace extends StatefulWidget {
  @override
  _getFromPlaceState createState() => _getFromPlaceState();
}

String selected;
String val = '';
String groubVal2 = '';

class _getFromPlaceState extends State<getFromPlace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colora().brown,
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.brown),
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'Images/logo.png',
            scale: 10,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "الرجاء الاختيار من احد الافرع التالية",
                  style: GoogleFonts.cairo(
                    fontSize: 20,
                    color: Colora().black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: Colora().brown,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      RadioListTile(
                        activeColor: Colors.brown,
                        title: Text("فرع بيادر وادي السير"),
                        value: '1',
                        groupValue: groubVal2,
                        onChanged: (val) {
                          groubVal2 = val;
                          setState(() {});
                        },
                      ),
                      RadioListTile(
                        activeColor: Colors.brown,
                        title: Text("فرع شارع اليرموك"),
                        value: '2',
                        groupValue: groubVal2,
                        onChanged: (val) {
                          groubVal2 = val;
                          setState(() {});
                        },
                      ),
                      RadioListTile(
                        activeColor: Colors.brown,
                        title: Text("فرع الهاشمي الشمالي"),
                        value: '3',
                        groupValue: groubVal2,
                        onChanged: (val) {
                          groubVal2 = val;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:bun_wa_hal/main.dart';
// import 'package:bun_wa_hal/screens/turkt_coffe.dart';
// import 'package:bun_wa_hal/style/styli.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// // ignore: camel_case_types
// class getFromPlace extends StatefulWidget {
//   @override
//   _getFromPlaceState createState() => _getFromPlaceState();
// }
//
// DateTime pickedDate;
// TextEditingController pass = TextEditingController();
// DatabaseReference _counterRef;
// DateTime currentDate = DateTime.now();
//
// // ignore: camel_case_types
// class _getFromPlaceState extends State<getFromPlace> {
//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       pickedDate = DateTime(2021, 12, 30);
//     });
//     Firebase.initializeApp().whenComplete(
//           () {
//         print("completed");
//       },
//     );
//   }
//
//   String chose = "";
//   Color colorbirth = Colors.grey;
//
//   Future<void> _selectDate(BuildContext context) async {
//     DatePicker.showDatePicker(context,
//         showTitleActions: true,
//         minTime: DateTime(1900),
//         maxTime: DateTime(2005 ?? 1),
//         theme: DatePickerTheme(
//             headerColor: Colors.green.withOpacity(0.7),
//             backgroundColor: Colors.green.withOpacity(0.7),
//             itemStyle: TextStyle(
//                 color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
//             doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
//         onChanged: (date) {
//           if (date != null) {
//             setState(() {
//               colorbirth = Colors.black;
//               pickedDate = date;
//             });
//           }
//         }, onConfirm: (date) {
//           if (date != null) {
//             setState(() {
//               pickedDate = date;
//             });
//           }
//         }, currentTime: DateTime.now(), locale: LocaleType.en);
//     // final DateTime pickedDate = await showDatePicker(
//     //     context: context,
//     //     initialDate: currentDate,
//     //     lastDate: new DateTime.now().add(new Duration(days: currentDate.day)),
//     //     firstDate: DateTime(1900));
//     // if (pickedDate != null && pickedDate != currentDate) {
//     //   setState(() {
//     //     currentDate = pickedDate;
//     //   });
//   }
//
//   TextEditingController _birthController = TextEditingController(
//     text: pickedDate.year.toString() +
//         "/" +
//         pickedDate.month.toString() +
//         "/" +
//         pickedDate.day.toString(),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     Color colorbirth = Colors.grey;
//     TextEditingController _birthController = TextEditingController(
//       text: pickedDate.year.toString() +
//           "/" +
//           pickedDate.month.toString() +
//           "/" +
//           pickedDate.day.toString(),
//     );
//     Future<void> _selectDate(BuildContext context) async {
//       DatePicker.showDatePicker(context,
//           showTitleActions: true,
//           minTime: DateTime(1900),
//           maxTime: DateTime(2005 ?? 1),
//           theme: DatePickerTheme(
//               headerColor: Colors.green.withOpacity(0.7),
//               backgroundColor: Colors.green.withOpacity(0.7),
//               itemStyle: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18),
//               doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
//           onChanged: (date) {
//             if (date != null) {
//               setState(() {
//                 colorbirth = Colors.black;
//                 pickedDate = date;
//               });
//             }
//           }, onConfirm: (date) {
//             if (date != null) {
//               setState(() {
//                 pickedDate = date;
//               });
//             }
//           }, currentTime: DateTime.now(), locale: LocaleType.en);
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color: Colors.brown),
//         elevation: 0,
//         title: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Image.asset(
//             'Images/logo.png',
//             scale: 10,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       drawer: Drawer(
//         child: ListView(
//           // Important: Remove any padding from the ListView.
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               child: Image.asset(
//                 "Images/logo.png",
//                 width: 52,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//               ),
//             ),
//             ListTile(
//               title: Text('home'),
//               onTap: () {
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (context) => MyApp()));
//               },
//             ),
//             ListTile(
//               title: Text('cart'),
//               onTap: () {
//                 // Update the state of the app.
//                 // ...
//
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => check_out()));
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(18.0),
//             child: Center(
//               child: Text("الرجاء الاختيارمن احد هذه الافرع",
//                   style: GoogleFonts.cairo(
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black,
//                       fontSize: 25)),
//             ),
//           ),
//           Container(
//             height: 200,
//             child: ListView(
//               children: [
//                 Container(
//                   color:
//                   chose == "الهاشمي الشمالي" ? Colors.green : Colors.white,
//                   child: ListTile(
//                     onTap: () {
//                       setState(() {
//                         chose = "الهاشمي الشمالي";
//                       });
//                     },
//                     title: Text("فرع الهاشمي الشمالي",
//                         textAlign: TextAlign.right,
//                         style: GoogleFonts.cairo(
//                             fontWeight: FontWeight.w600,
//                             color: chose == "الهاشمي الشمالي"
//                                 ? Colors.white
//                                 : Colors.black,
//                             fontSize: 20)),
//                     trailing: IconButton(
//                       icon: FaIcon(
//                         FontAwesomeIcons.mapMarked,
//                         color: chose == "الهاشمي الشمالي"
//                             ? Colors.white
//                             : Colors.grey,
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//                 ),
//                 Container(
//                   color:
//                   chose == "بيادر وادي السير" ? Colors.green : Colors.white,
//                   child: ListTile(
//                     onTap: () {
//                       setState(() {
//                         chose = "بيادر وادي السير";
//                       });
//                     },
//                     title: Text("فرع بيادر وادي السير",
//                         textAlign: TextAlign.right,
//                         style: GoogleFonts.cairo(
//                             fontWeight: FontWeight.w600,
//                             color: chose == "بيادر وادي السير"
//                                 ? Colors.white
//                                 : Colors.black,
//                             fontSize: 20)),
//                     trailing: IconButton(
//                       icon: FaIcon(
//                         FontAwesomeIcons.mapMarked,
//                         color: chose == "بيادر وادي السير"
//                             ? Colors.white
//                             : Colors.grey,
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//                 ),
//                 Container(
//                   color: chose == "مكة مول" ? Colors.green : Colors.white,
//                   child: ListTile(
//                     onTap: () {
//                       setState(() {
//                         chose = "مكة مول";
//                       });
//                     },
//                     title: Text("فرع مكة مول",
//                         textAlign: TextAlign.right,
//                         style: GoogleFonts.cairo(
//                             fontWeight: FontWeight.w600,
//                             color: chose == "مكة مول"
//                                 ? Colors.white
//                                 : Colors.black,
//                             fontSize: 20)),
//                     trailing: IconButton(
//                       icon: FaIcon(
//                         FontAwesomeIcons.mapMarked,
//                         color: chose == "مكة مول" ? Colors.white : Colors.grey,
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               child: Card(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       side: BorderSide(color: Colors.brown, width: 2)),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 5, right: 25, left: 25, bottom: 5),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     "تاريخ الميلاد(إختياري)",
//                                     textAlign: TextAlign.right,
//                                     style: GoogleFonts.cairo(
//                                         fontWeight: FontWeight.w600,
//                                         color: Colora().brown,
//                                         fontSize: 15),
//                                   ),
//                                 ),
//                                 Card(
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20),
//                                       side: BorderSide(
//                                           color: Color(0xff663A2B), width: 1)),
//                                   child: ListTile(
//                                     trailing:
//                                     Icon(Icons.cake, color: Colors.brown),
//                                     title: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Directionality(
//                                         textDirection: TextDirection.rtl,
//                                         child: TextFormField(
//                                           style: TextStyle(
//                                               color: colorbirth,
//                                               decorationColor: colorbirth),
//                                           textAlign: TextAlign.right,
//                                           onTap: () {
//                                             _selectDate(context);
//                                             setState(() {
//                                               colorbirth = Colors.black;
//                                             });
//                                           },
//                                           readOnly: true,
//                                           cursorWidth: 0,
//                                           cursorColor: Colors.white,
//                                           cursorHeight: 0,
//                                           expands: false,
//                                           decoration: InputDecoration(
//                                             counterStyle: TextStyle(
//                                               color:
//                                               Colors.grey.withOpacity(0.7),
//                                             ),
//                                             // border: OutlineInputBorder(
//                                             //     borderRadius: BorderRadius.circular(20),
//                                             //     borderSide: BorderSide(width: 2),
//                                             //     gapPadding: 10),
//                                             //
//                                             //
//                                             counterText: "",
//                                             contentPadding:
//                                             EdgeInsetsDirectional.only(
//                                                 start: 20,
//                                                 end: 6,
//                                                 bottom: 0,
//                                                 top: 0),
//                                             border: InputBorder.none,
//                                             hintStyle: GoogleFonts.cairo(
//                                                 fontSize: 15,
//                                                 color: Colors.grey),
//                                           ),
//                                           controller: _birthController,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Text(
//                                   ": تاريخ الاستلام",
//                                   style: GoogleFonts.cairo(
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black,
//                                       fontSize: 15),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   )),
//             ),
//           ),
//           chose == ""
//               ? Container(
//             height: 1,
//             width: 1,
//           )
//               : Padding(
//             padding: const EdgeInsets.only(
//                 top: 0.0, bottom: 0, right: 30, left: 30),
//             child: Center(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(30),
//                 // ignore: deprecated_member_use
//                 child: FlatButton(
//                   color: Colors.green,
//                   child: Center(
//                     child: Text(
//                       "ارسال الطلب",
//                       style: GoogleFonts.cairo(
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                           fontSize: 20),
//                     ),
//                   ),
//                   onPressed: () {
//                     print("completed to send order");
//                     Map<String, String> map = {
//                       'id': fbitem[0].itemId,
//                       'title': fbitem[0].title,
//                       'price': fbitem[0].price.toString(),
//                       'cookingLevel': fbitem[0].cookingLevel,
//                       'containHeal': fbitem[0].containHeal.toString(),
//                       'size': size.toString(),
//                     };
//                     _counterRef = FirebaseDatabase.instance
//                         .reference()
//                         .child('Orders');
//                     _counterRef
//                         .push()
//                         .set(<String, Map<String, String>>{'order': map});
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         Future.delayed(Duration(seconds: 3), () {
//                           Navigator.of(context).pop(true);
//                         });
//                         return AlertDialog(
//                           actions: [
//                             Text("Made by : Beejo.co"),
//                             IconButton(
//                                 icon: Icon(Icons.developer_mode),
//                                 onPressed: () {})
//                           ],
//                           title: Text(
//                               "please wait until your order is sinding"),
//                         );
//                       },
//                     );
//
//                     //         .child('code');
//                     // ref.putString('flutter');
//                     print("i am hero tonight");
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
