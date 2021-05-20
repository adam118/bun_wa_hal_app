import 'package:badges/badges.dart';
import 'package:bun_wa_hal/custom_expansion_tile.dart' as custom;
import 'package:bun_wa_hal/model/cart.dart';
import 'package:bun_wa_hal/screens/turkt_coffe.dart';
import 'package:bun_wa_hal/style/styli.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

Pattern pattern = r'^\+[1-9]{1}[0-9]{3,14}$';
RegExp regex = new RegExp(pattern);

Widget _shoppingCartBadge() {
  return Consumer<Cart>(builder: (context, cart, child) {
    return Badge(
        position: BadgePosition.topEnd(top: 0, end: 3),
        animationDuration: Duration(milliseconds: 3),
        animationType: BadgeAnimationType.scale,
        badgeContent: Text(
          cart.basketItems.length.toString(),
          style: TextStyle(color: Colors.white),
        ),
        child: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => check_out()));
            }));
  });
}

String email;

String password;
String phonede;
final _scaffoldKey = GlobalKey<ScaffoldState>();
String name;
var obtainEmail;
var obtainname;
var obtainPassword;
bool autovalidatephoneedited = false;

var obtainPhone;

TextEditingController _editedphonenumber =
    TextEditingController(text: "+962790906363  ");

class _MyAccountState extends State<MyAccount> {
  Future getValiducation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    obtainEmail = sharedPreferences.getString('email');
    obtainname = sharedPreferences.getString('name');
    obtainPassword = sharedPreferences.getString('password');
    obtainPhone = sharedPreferences.getString('phone');
    setState(() {
      email = obtainEmail;

      password = obtainPassword;
      phonede = obtainPhone;
      name = obtainname;
    });
  }

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;

  @override
  void initState() {
    super.initState();
    getValiducation();
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress = "${place.locality},${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  Key key;

  @override
  Widget build(BuildContext context) {
    var firebaseUser = FirebaseAuth.instance.currentUser;

    Query query = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colora().brown),
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
          Cart().basketItems.length == 0
              ? IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => check_out()));
                  })
              : _shoppingCartBadge(),
        ],
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
                  padding: const EdgeInsets.all(18.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Colora().green,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "معلوماتي",
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Colora().white),
                              ),
                            ),
                          ),
                          ListTile(
                            subtitle: Text(
                              name.toString(),
                              textAlign: TextAlign.right,
                              style: GoogleFonts.cairo(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colora().white,
                              ),
                            ),
                            title: Text(
                              "الاسم",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.cairo(
                                fontWeight: FontWeight.w600,
                                color: Colora().white,
                              ),
                            ),
                          ),
                          Text(
                            'ـــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــ',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ),
                          ListTile(
                            leading: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            actions: [
                                              FlatButton(
                                                onPressed: () {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "مش عارف سويها هي و التسجيل بالرقم رح اسأل استا فتيبة",
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      fontSize: 10,
                                                      toastLength:
                                                          Toast.LENGTH_SHORT);
                                                },
                                                color: Colora().green,
                                                child: Text(
                                                  "تغيير",
                                                  style: GoogleFonts.cairo(
                                                      color: Colora().white),
                                                ),
                                              ),
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "الغاء",
                                                  style: GoogleFonts.cairo(
                                                      color: Colora().green),
                                                ),
                                              ),
                                            ],
                                            title: Column(
                                              children: [
                                                Text(
                                                  "الرجاء ادخال الرقم الجديد",
                                                  style: GoogleFonts.cairo(
                                                      fontSize: 15,
                                                      color: Colora().green),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: TextFormField(
                                                    textAlign: TextAlign.right,
                                                    autovalidate:
                                                        autovalidatephoneedited,
                                                    onChanged: (_) {
                                                      setState(() {
                                                        autovalidatephoneedited =
                                                            true;
                                                      });
                                                    },
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'هاذا الحقل مطلوب';
                                                      } else if (value.length <
                                                          13) {
                                                        return 'الرجاء ادخال رقم هاتف صحيح';
                                                      } else if (!regex
                                                          .hasMatch(value)) {
                                                        return 'الرجاء ادخال رقم هاتف صحيح , عدم وضع احرف او رموز';
                                                      } else if (value
                                                          .startsWith(
                                                              '+9620')) {
                                                        return 'الرجاء حذف ال 0 بعد +962';
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (value) {},
                                                    expands: false,
                                                    maxLength: 13,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsetsDirectional
                                                                .only(
                                                                    start: 6,
                                                                    end: 6,
                                                                    bottom: 0,
                                                                    top: 0),
                                                        hintStyle:
                                                            GoogleFonts.cairo(
                                                                fontSize: 15,
                                                                color: Colora()
                                                                    .green),
                                                        hintText: "رقم الهاتف"),
                                                    controller:
                                                        _editedphonenumber,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ));
                                }),
                            subtitle: Text(
                              phonede ?? 'خطأ',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.cairo(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colora().white,
                              ),
                            ),
                            title: Text(
                              "رقم الهاتف",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.cairo(
                                fontWeight: FontWeight.w600,
                                color: Colora().white,
                              ),
                            ),
                          ),
                          Text(
                            'ـــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــ',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ),
                          ListTile(
                            subtitle: GestureDetector(
                                onTap: () {
                                  LocationPermissions().openAppSettings().then(
                                      (bool hasOpened) => debugPrint(
                                          'App Settings opened: ' +
                                              hasOpened.toString()));
                                },
                                child: Text(
                                  _currentAddress ??
                                      "pleas allow the location press to allow",
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.cairo(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colora().white,
                                  ),
                                )),
                            title: Text(
                              "الموقع",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.cairo(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colora().white,
                              ),
                            ),
                          ),
                          custom.ExpansionTile(
                            iconColor: Colora().brown,
                            headerBackgroundColor: Colora().green,
                            title: Center(
                              child: Text(
                                "       نقاطي",
                                style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w600,
                                  color: Colora().white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            children: [
                              ListTile(
                                title: Text(
                                  "المجموع",
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.cairo(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colora().white,
                                  ),
                                ),
                                subtitle: Text(
                                  querySnapshot.docs[index]['points']
                                      .toString(),
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w600,
                                    color: Colora().white,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "مستبدل",
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w600,
                                    color: Colora().white,
                                  ),
                                ),
                                subtitle: Text(
                                  "0",
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.cairo(
                                      fontSize: 15, color: Colora().white),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "منتهية",
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w600,
                                    color: Colora().white,
                                  ),
                                ),
                                subtitle: Text(
                                  "0",
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.cairo(
                                      fontSize: 15, color: Colora().white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
