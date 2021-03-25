import 'package:bun_wa_hal/main.dart';
import 'package:bun_wa_hal/screens/turkt_coffe.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class getFromPlace extends StatefulWidget {
  @override
  _getFromPlaceState createState() => _getFromPlaceState();
}

TextEditingController pass = TextEditingController();
DatabaseReference _counterRef;
DateTime currentDate = DateTime.now();

// ignore: camel_case_types
class _getFromPlaceState extends State<getFromPlace> {
  String chose = "";
  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2022));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  @override
  Widget build(BuildContext context) {
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
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {});
                  })
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image.asset(
                "Images/logo.png",
                width: 52,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            ListTile(
              title: Text('home'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
            ),
            ListTile(
              title: Text('cart'),
              onTap: () {
                // Update the state of the app.
                // ...

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => check_out()));
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: Text("الرجاء الاختيارمن احد هذه الافرع",
                  style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 25)),
            ),
          ),
          Container(
            height: 200,
            child: ListView(
              children: [
                Container(
                  color:
                      chose == "الهاشمي الشمالي" ? Colors.green : Colors.white,
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        chose = "الهاشمي الشمالي";
                      });
                    },
                    title: Text("فرع الهاشمي الشمالي",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cairo(
                            fontWeight: FontWeight.w600,
                            color: chose == "الهاشمي الشمالي"
                                ? Colors.white
                                : Colors.black,
                            fontSize: chose == "الهاشمي الشمالي" ? 20 : 15)),
                    trailing: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.mapMarked,
                        color: chose == "الهاشمي الشمالي"
                            ? Colors.white
                            : Colors.grey,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                Container(
                  color:
                      chose == "بيادر وادي السير" ? Colors.green : Colors.white,
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        chose = "بيادر وادي السير";
                      });
                    },
                    title: Text("فرع بيادر وادي السير",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cairo(
                            fontWeight: FontWeight.w600,
                            color: chose == "بيادر وادي السير"
                                ? Colors.white
                                : Colors.black,
                            fontSize: chose == "بيادر وادي السير" ? 30 : 20)),
                    trailing: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.mapMarked,
                        color: chose == "بيادر وادي السير"
                            ? Colors.white
                            : Colors.grey,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                Container(
                  color: chose == "مكة مول" ? Colors.green : Colors.white,
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        chose = "مكة مول";
                      });
                    },
                    title: Text("فرع مكة مول",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cairo(
                            fontWeight: FontWeight.w600,
                            color: chose == "مكة مول"
                                ? Colors.white
                                : Colors.black,
                            fontSize: chose == "مكة مول" ? 30 : 20)),
                    trailing: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.mapMarked,
                        color: chose == "مكة مول" ? Colors.white : Colors.grey,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
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
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 18.0, bottom: 18.0, left: 10),
                          child: Container(
                            width: 220,
                            child: TextFormField(
                                textAlign: TextAlign.right,
                                expands: false,
                                readOnly: true,
                                onTap: () {
                                  _selectDate(context);
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsetsDirectional.only(
                                      start: 6, end: 6, bottom: 0, top: 0),
                                  hintStyle: GoogleFonts.cairo(
                                      fontSize: 20, color: Colors.brown),
                                ),
                                controller: pass),
                          ),
                        ),
                        Text(
                          ": تاريخ الاستلام",
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
          chose == ""
              ? Container(
                  height: 1,
                  width: 1,
                )
              : Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0, bottom: 0, right: 30, left: 30),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              "ارسال الطلب",
                              style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ),
                          onPressed: () {
                            print("completd to send order");
                            Map<String, String> map = {
                              'id': fbitem[0].itemId,
                              'title': fbitem[0].title,
                              'price': fbitem[0].price.toString(),
                              'cookingLevel': fbitem[0].cookingLevel,
                              'containHeal': fbitem[0].containHeal.toString(),
                              'size': size.toString(),
                            };
                            _counterRef = FirebaseDatabase.instance
                                .reference()
                                .child('Orders');
                            _counterRef.push().set(
                                <String, Map<String, String>>{'order': map});
                            showDialog(
                              context: context,
                              builder: (context) {
                                Future.delayed(Duration(seconds: 3), () {
                                  Navigator.of(context).pop(true);
                                });
                                return AlertDialog(
                                  actions: [
                                    Text("Made by : Beejo.co"),
                                    IconButton(
                                        icon: Icon(Icons.developer_mode),
                                        onPressed: () {})
                                  ],
                                  title: Text(
                                      "please wait until your order is sinding"),
                                );
                              },
                            );

                            //         .child('code');
                            // ref.putString('flutter');
                            print("i am hero tonight");
                          }),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
