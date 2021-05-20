import 'package:bun_wa_hal/order/finalscreen.dart';
import 'package:bun_wa_hal/style/styli.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// ignore: camel_case_types
class addlocationfrommap extends StatefulWidget {
  @override
  _addlocationfrommapState createState() => _addlocationfrommapState();
}

String poslat, poslong;
GoogleMapController mapController;
final _addlocationformkey = GlobalKey<FormState>();

final TextEditingController _nameoflocationcontroller = TextEditingController();
final TextEditingController _buildingnumbercontroller = TextEditingController();
final TextEditingController _flornumbercontroller = TextEditingController();
final TextEditingController _apartmentnumbercontroller =
    TextEditingController();

// ignore: camel_case_types
class _addlocationfrommapState extends State<addlocationfrommap> {
  LatLng _initialcameraposition = LatLng(31.9539, 35.9106);
  GoogleMapController _controller;
  Location _location = Location();
  bool _gohint = false;
  void onMapCreated(GoogleMapController _mapController) {
    _controller = _mapController;

    // _location.onLocationChanged.listen((l) {
    //   _controller.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
    //     ),
    //   );
    // });
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    setState(() {});
    super.initState();
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
      context: context,
      builder: (builder) {
        return Form(
          key: _addlocationformkey,
          child: Container(
            height: 550.0,
            color: Colors.transparent, //could change this to Color(0xFFAB2828),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        title: TextFormField(
                          textAlign: TextAlign.right,
                          onTap: () {},
                          textInputAction: TextInputAction.done,
                          cursorWidth: 0,
                          cursorColor: Colors.white,
                          cursorHeight: 0,
                          decoration: InputDecoration(
                            hintText: "مثل المنزل او العمل",
                            counterStyle: TextStyle(
                              color: Colors.grey.withOpacity(0.7),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'هاذا الحقل مطلوب';
                            }
                            return null;
                          },
                          controller: _nameoflocationcontroller,
                        ),
                        trailing: Text(
                          ": اسم العنوان",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.cairo(
                            fontSize: 20,
                            color: Colora().black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        title: TextFormField(
                          textAlign: TextAlign.right,
                          onTap: () {},
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          cursorWidth: 0,
                          cursorColor: Colors.white,
                          cursorHeight: 0,
                          decoration: InputDecoration(
                            counterStyle: TextStyle(
                              color: Colors.grey.withOpacity(0.7),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'هاذا الحقل مطلوب';
                            }
                            return null;
                          },
                          controller: _buildingnumbercontroller,
                        ),
                        trailing: Text(
                          ": رقم العمارة",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.cairo(
                            fontSize: 20,
                            color: Colora().black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        title: TextFormField(
                          textAlign: TextAlign.right,
                          onTap: () {},
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          cursorWidth: 0,
                          cursorColor: Colors.white,
                          cursorHeight: 0,
                          decoration: InputDecoration(
                            counterStyle: TextStyle(
                              color: Colors.grey.withOpacity(0.7),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'هاذا الحقل مطلوب';
                            }
                            return null;
                          },
                          controller: _flornumbercontroller,
                        ),
                        trailing: Text(
                          ": رقم الطابق",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.cairo(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        title: TextFormField(
                          textAlign: TextAlign.right,
                          onTap: () {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'هاذا الحقل مطلوب';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          cursorWidth: 0,
                          cursorColor: Colors.white,
                          cursorHeight: 0,
                          decoration: InputDecoration(
                            counterStyle: TextStyle(
                              color: Colors.grey.withOpacity(0.7),
                            ),
                          ),
                          controller: _apartmentnumbercontroller,
                        ),
                        trailing: Text(
                          ": رقم الشقة",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.cairo(
                            fontSize: 20,
                            color: Colora().black,
                          ),
                        ),
                      ),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        if (_addlocationformkey.currentState.validate()) {
                          addlocationtofirebase();
                        } else {
                          return null;
                        }
                      },
                      color: Colora().green,
                      child: Text(
                        "اضافة الموقع",
                        style: GoogleFonts.cairo(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.transparent,
      ),
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colora().green,
          onPressed: () {
            _modalBottomSheetMenu();
          },
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialcameraposition, zoom: 50),
              mapType: MapType.normal,
              onCameraMove: (CameraPosition position) {
                setState(() {
                  poslat = "${position.target.latitude}";
                  poslong = "${position.target.longitude}";
                });
              },
              onMapCreated: onMapCreated,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
            ),
            Positioned(
                top: 20,
                left: 200,
                child: Visibility(
                  visible: _gohint,
                  child: Tab(
                    icon: Icon(Icons.arrow_right_alt),
                    text: "انقر هنا لذهاب لموقعك الحالي",
                  ),
                )),
            Center(
              child: Icon(
                Icons.location_on,
                size: 30,
                color: Colora().green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addlocationtofirebase() {
    Map<String, String> map = {
      'building number': _buildingnumbercontroller.text.toString(),
      'flor number': _flornumbercontroller.text.toString(),
      'apartment number': _apartmentnumbercontroller.text.toString(),
      'google maps url':
          'https://www.google.com/maps/dir//$poslat/@$poslong,12z',
    };

    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid)
        .update({
      "savedlocation": <String, Map<String, String>>{
        _nameoflocationcontroller.text.toString(): map
      }
    }).then((_) {
      print("success!");
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => checkout_Screen_final(),
      ),
    );
  }
}
