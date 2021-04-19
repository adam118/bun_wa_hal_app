import 'package:bun_wa_hal/auth/Singup.dart';
import 'package:bun_wa_hal/main.dart';
import 'package:bun_wa_hal/map/map.dart';
import 'package:bun_wa_hal/model/cart.dart';
import 'package:bun_wa_hal/screens/turkt_coffe.dart';
import 'package:bun_wa_hal/style/styli.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart' as database;
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class checkout_Screen_final extends StatefulWidget {
  @override
  _checkout_Screen_finalState createState() => _checkout_Screen_finalState();
}

int i = 1;
database.DatabaseReference _counterRef;
DateTime pickedDate;

TextEditingController pass = TextEditingController();
String groupVal2 = "";
DateTime currentDate = DateTime.now();

FirebaseFirestore firestore =
    FirebaseFirestore.instance.collection('order').firestore;
String token;

// ignore: camel_case_types
class _checkout_Screen_finalState extends State<checkout_Screen_final> {
  @override
  void initState() {
    super.initState();
    setState(() {
      pickedDate = DateTime(2021, 12, 30);
    });
    Firebase.initializeApp().whenComplete(
      () {
        print("completed");
      },
    );
  }

  TextEditingController _birthController = TextEditingController(
    text: pickedDate.year.toString() +
        "   /   " +
        pickedDate.month.toString() +
        "   /   " +
        pickedDate.day.toString(),
  );
  TextEditingController _notsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Color colorbirth = Colors.grey;

    Future<void> _selectDate(BuildContext context) async {
      DatePicker.showDatePicker(context,
          showTitleActions: true,
          minTime: DateTime.now(),
          maxTime: DateTime(
              currentDate.year, currentDate.month, currentDate.day + 10),
          theme: DatePickerTheme(
              headerColor: Colora().green,
              backgroundColor: Colora().green,
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
    }

    Query query = FirebaseFirestore.instance.collection('users');
    var querydatabase =
        database.FirebaseDatabase.instance.reference().child('orders').push();

    return Consumer<Cart>(
      builder: (context, cart, child) {
        return Scaffold(
          appBar: AppBar(
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
            actions: <Widget>[],
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: query.snapshots(),
            builder: (context, stream) {
              if (stream.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (stream.hasError) {
                print(stream.error);
                return Center(child: Text(stream.error.toString()));
              }

              QuerySnapshot querySnapshot = stream.data;
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: Colors.brown, width: 2)),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  "عنوان التوصيل",
                                  style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 20),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      width: 140,
                                      child: TextFormField(
                                        textAlign: TextAlign.right,
                                        controller: TextEditingController(),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    ": اختر موقع التوصيل يديوي",
                                    style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontSize: 15),
                                  )
                                ],
                              ),
                              Text(
                                "او اختر من الخريطة",
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => map()));
                                    },
                                    child: Image.asset("Images/map.png")),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: TextFormField(
                        textAlign: TextAlign.right,
                        onTap: () {
                          _selectDate(context);
                          setState(() {
                            colorbirth = Colors.black;
                          });
                        },
                        readOnly: true,
                        textInputAction: TextInputAction.done,
                        cursorWidth: 0,
                        cursorColor: Colors.white,
                        cursorHeight: 0,
                        decoration: InputDecoration(
                          counterStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.7),
                          ),
                        ),
                        controller: _birthController,
                      ),
                      trailing: Text(
                        ":   تاريخ الاستلام",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cairo(
                          fontSize: 20,
                          color: Colora().black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: TextFormField(
                        textAlign: TextAlign.right,
                        onTap: () {
                          _selectDate(context);
                          setState(() {});
                        },
                        readOnly: true,
                        textInputAction: TextInputAction.done,
                        cursorWidth: 0,
                        cursorColor: Colors.white,
                        cursorHeight: 0,
                        decoration: InputDecoration(
                          counterStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.7),
                          ),
                        ),
                        controller: _notsController,
                      ),
                      trailing: Text(
                        ":   ملاحظات اضافية",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cairo(
                          fontSize: 20,
                          color: Colora().black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 70,
                          width: 150,
                          color: Colora().green,
                          child: Center(
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              child: Center(
                                child: Text(
                                  "ارسال الطلب",
                                  style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                              ),
                              onPressed: () async {
                                send(context, index);
                                setState(
                                  () {
                                    cart.basketItems.length = 0;
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyApp(),
                                      ),
                                    );
                                  },
                                );
                                // var firebaseUser =
                                //     FirebaseAuth.instance.currentUser;
                                // if (database.FirebaseDatabase.instance
                                //         .databaseURL('https://bun-wa-hal-app-default-rtdb.firebaseio.com/')
                                //         .child('Orders')
                                //         .child('i')
                                //         .child('status')
                                //         .toString() ==
                                //     'shipped') {
                                //   setState(() {
                                //     i++;
                                //   });
                                // } else {
                                //   FirebaseFirestore.instance
                                //       .collection("users")
                                //       .doc()
                                //       .update({}).then(
                                //     (_) {
                                //       print("success!");
                                //     },
                                //   );
                                // }
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  //void addpoints(QuerySnapshot querySnapshot, Cart cart) {
  //  setState(
  //    () {
  //      userPoints =
  //          userPoints + querySnapshot.docs[cart.basketItems.length]['points'];
  //    },
  //  );
  //}
}

void send(
  BuildContext context,
  index,
) async {
  Map<String, String> map = {
    'id': fbitem[index].itemId,
    'title': fbitem[index].title,
    'price': fbitem[index].price.toString(),
    'cookingLevel': fbitem[index].cookingLevel,
    'status': 'shipped',
    'containHeal': fbitem[index].containHeal.toString(),
    'size': size.toString(),
  };
  Map<String, String> info = {
    'id': token,
    'location': 'kju84ujv84',
    'phone': phone.text.toString(),
    'رقم العمارة': '2',
  };
  _counterRef = database.FirebaseDatabase.instance.reference().child('Orders');
  _counterRef.push().set(<String, Map<String, String>>{"i": map});
}
// void sendDataToFB(Map<String, String> map) {
//   // Map<String, String> map = {
//   //   'id': fbitem[0].itemId,
//   //   'title': fbitem[0].title,
//   //   'price': fbitem[0].price.toString(),
//   //   'cookingLevel': fbitem[0].cookingLevel,
//   //   'containHeal': fbitem[0].containHeal.toString(),
//   //   'size': size.toString(),
//   // };;lll
//   _counterRef = FirebaseDatabase.instance.reference().child('Orders');
//   _counterRef.push().set(<String, Map<String, String>>{'order': map});
// }

void lodingCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
      });
      return AlertDialog(
          title: Column(
        children: [
          Text("رجاء الانتظار"),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            backgroundColor: Colors.brown,
          )
        ],
      ));
    },
  );
}
