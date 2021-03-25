import 'package:bun_wa_hal/screens/turkt_coffe.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// ignore: camel_case_types
class map extends StatefulWidget {
  @override
  _mapState createState() => _mapState();
}

DatabaseReference _counterRef;

Position position;
GoogleMapController mapController;

// ignore: camel_case_types
class _mapState extends State<map> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 300,
                  width: double.infinity,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: _initialcameraposition, zoom: 20),
                    mapType: MapType.hybrid,
                    onMapCreated: _onMapCreated,
                    myLocationEnabled: true,
                  ),
                ),
              ),
            ),
            Text("شارع عبد الله غوشة",
                style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 20)),
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
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
                              width: 210,
                              child: TextFormField(
                                keyboardType: TextInputType.datetime,
                                controller: TextEditingController(),
                              ),
                            ),
                          ),
                          Text(
                            ": رقم العمارة",
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
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
                              width: 210,
                              child: TextFormField(
                                keyboardType: TextInputType.datetime,
                                controller: TextEditingController(),
                              ),
                            ),
                          ),
                          Text(
                            ": رقم الهاتف",
                            style: GoogleFonts.cairo(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 15),
                          )
                        ],
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
                                      "اضافة الموقع",
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
                                      'containHeal':
                                          fbitem[0].containHeal.toString(),
                                      'size': size.toString(),
                                    };
                                    _counterRef = FirebaseDatabase.instance
                                        .reference()
                                        .child('Orders');
                                    _counterRef
                                        .push()
                                        .set(<String, Map<String, String>>{
                                      'order': map
                                    });
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        Future.delayed(Duration(seconds: 3),
                                            () {
                                          Navigator.of(context).pop(true);
                                        });
                                        return AlertDialog(
                                          actions: [
                                            Text("Made by : Beejo.co"),
                                            IconButton(
                                                icon:
                                                    Icon(Icons.developer_mode),
                                                onPressed: () {})
                                          ],
                                          title: Text(
                                              "please wait until your order is sinding"),
                                        );
                                      },
                                    );

                                    //         .child('code');
                                    // ref.putString('flutter');
                                  }),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
