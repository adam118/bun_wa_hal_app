import 'package:badges/badges.dart';
import 'package:bun_wa_hal/main.dart';
import 'package:bun_wa_hal/model/cart.dart';
import 'package:bun_wa_hal/screens/turkt_coffe.dart';
import 'package:bun_wa_hal/style/styli.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

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
String phone;
final _scaffoldKey = GlobalKey<ScaffoldState>();
String name;

class _MyAccountState extends State<MyAccount> {
  Future getValiducation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainEmail = sharedPreferences.getString('email');
    var obtainname = sharedPreferences.getString('name');
    var obtainPassword = sharedPreferences.getString('password');
    var obtainPhone = sharedPreferences.getString('phone');
    setState(() {
      email = obtainEmail;

      password = obtainPassword;
      phone = obtainPhone;
      name = obtainname;
    });
  }

  @override
  void initState() {
    super.initState();
    getValiducation();
  }

  Query query = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
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
          IconButton(
              icon: isDark ? dark : light,
              onPressed: () {
                setState(() {
                  isDark = !isDark;
                });
              })
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
                      color: Colors.green,
                      child: Column(
                        children: [
                          ListTile(
                            trailing: IconButton(
                                icon: Icon(Icons.edit),
                                color: Colors.white,
                                onPressed: () {
                                  _scaffoldKey.currentState
                                      // ignore: deprecated_member_use
                                      .showSnackBar(nutSupportYet());
                                }),
                            subtitle: Text(
                              name.toString(),
                              style: GoogleFonts.cairo(
                                fontWeight: FontWeight.w600,
                                color: Colora().white,
                              ),
                            ),
                            title: Text(
                              "name",
                              style: GoogleFonts.cairo(
                                fontWeight: FontWeight.w600,
                                color: Colora().white,
                              ),
                            ),
                          ),
                          ListTile(
                            trailing: IconButton(
                                icon: Icon(Icons.edit),
                                color: Colors.white,
                                onPressed: () {
                                  _scaffoldKey.currentState
                                      // ignore: deprecated_member_use
                                      .showSnackBar(nutSupportYet());
                                }),
                            subtitle: Text(
                              phone.toString(),
                              style: GoogleFonts.cairo(
                                fontWeight: FontWeight.w600,
                                color: Colora().white,
                              ),
                            ),
                            title: Text(
                              "phone",
                              style: GoogleFonts.cairo(
                                fontWeight: FontWeight.w600,
                                color: Colora().white,
                              ),
                            ),
                          ),
                          ListTile(
                            trailing: IconButton(
                                icon: Icon(Icons.edit),
                                color: Colors.white,
                                onPressed: () {
                                  _scaffoldKey.currentState
                                      // ignore: deprecated_member_use
                                      .showSnackBar(nutSupportYet());
                                }),
                            subtitle: Text(
                              password.toString(),
                              style: GoogleFonts.cairo(
                                fontWeight: FontWeight.w600,
                                color: Colora().white,
                              ),
                            ),
                            title: Text(
                              "password",
                              style: GoogleFonts.cairo(
                                fontWeight: FontWeight.w600,
                                color: Colora().white,
                              ),
                            ),
                          ),
                          ExpansionTile(
                            title: Text(
                              "نقاطي",
                              style: GoogleFonts.cairo(
                                fontWeight: FontWeight.w600,
                                color: Colora().white,
                              ),
                            ),
                            children: [
                              ListTile(
                                title: Text(
                                  "المجموع",
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w600,
                                    color: Colora().white,
                                  ),
                                ),
                                subtitle: Text(
                                  querySnapshot.docs[index]['points']
                                      .toString(),
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w600,
                                    color: Colora().white,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "مستبدل",
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w600,
                                    color: Colora().white,
                                  ),
                                ),
                                subtitle: Text("13"),
                              ),
                              ListTile(
                                title: Text(
                                  "منتهية",
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w600,
                                    color: Colora().white,
                                  ),
                                ),
                                subtitle: Text("52"),
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

  nutSupportYet() {
    return SnackBar(
      content: Text("not supported yet"),
    );
  }
}
