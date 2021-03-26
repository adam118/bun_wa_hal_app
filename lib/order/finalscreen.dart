import 'package:bun_wa_hal/auth/Singup.dart';
import 'package:bun_wa_hal/main.dart';
import 'package:bun_wa_hal/map/map.dart';
import 'package:bun_wa_hal/model/cart.dart';
import 'package:bun_wa_hal/screens/turkt_coffe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart' as database;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

int userPoints;

// ignore: camel_case_types
class checkout_Screen_final extends StatefulWidget {
  @override
  _checkout_Screen_finalState createState() => _checkout_Screen_finalState();
}

database.DatabaseReference _counterRef;
String token;
DateTime currentDate = DateTime.now();

// ignore: camel_case_types
class _checkout_Screen_finalState extends State<checkout_Screen_final> {
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

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection('Items');

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
          body: StreamBuilder(
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
              setState(() {});
              return SingleChildScrollView(
                child: Column(
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: Colors.brown, width: 2)),
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  _selectDate(context);
                                },
                                title: Text(
                                  currentDate.year.toString() +
                                      "/" +
                                      currentDate.month.toString() +
                                      "/" +
                                      currentDate.day.toString(),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 18.0, bottom: 18.0, left: 10),
                                    child: Container(
                                      width: 300,
                                      child: TextFormField(
                                        textAlign: TextAlign.right,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsetsDirectional.only(
                                                    start: 10,
                                                    end: 10,
                                                    bottom: 0,
                                                    top: 10),
                                            labelStyle: GoogleFonts.cairo(
                                                fontSize: 20,
                                                color: Colors.brown),
                                            hintStyle: GoogleFonts.cairo(
                                                fontSize: 20,
                                                color: Colors.brown),
                                            hintText:
                                                "مثل رجاءا لا تقرع الجرس"),
                                        controller: TextEditingController(),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    ": ملاحظات",
                                    style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontSize: 15),
                                  )
                                ],
                              ),
                            ],
                          ),
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
                          color: Colors.green,
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
                                await send(context);
                                setState(
                                  () {
                                    userPoints = userPoints +
                                        querySnapshot
                                                .docs[cart.basketItems.length]
                                            ['points'];
                                  },
                                );
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
}

void send(BuildContext context) async {
  Map<String, String> map = {
    'id': fbitem[0].itemId,
    'title': fbitem[0].title,
    'price': fbitem[0].price.toString(),
    'cookingLevel': fbitem[0].cookingLevel,
    'containHeal': fbitem[0].containHeal.toString(),
    'size': size.toString(),
  };
  Map<String, String> info = {
    'id': token,
    'location': 'kju84ujv84',
    'phone': phone.text.toString(),
    'رقم العمارة': '2',
  };
  _counterRef = database.FirebaseDatabase.instance.reference().child('Orders');
  _counterRef
      .push()
      .set(<String, Map<String, String>>{'order': map, 'info': info});
}

// void sendDataToFB(Map<String, String> map) {
//   // Map<String, String> map = {
//   //   'id': fbitem[0].itemId,
//   //   'title': fbitem[0].title,
//   //   'price': fbitem[0].price.toString(),
//   //   'cookingLevel': fbitem[0].cookingLevel,
//   //   'containHeal': fbitem[0].containHeal.toString(),
//   //   'size': size.toString(),
//   // };
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
