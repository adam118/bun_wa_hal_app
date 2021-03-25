import 'package:bun_wa_hal/auth/chose.dart';
import 'package:bun_wa_hal/main.dart';
import 'package:bun_wa_hal/screens/turkt_coffe.dart';
import 'package:bun_wa_hal/style/styli.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<ScaffoldState> _scafcfoldKey = new GlobalKey<ScaffoldState>();

class Loyalty extends StatefulWidget {
  @override
  _LoyaltyState createState() => _LoyaltyState();
}

class _LoyaltyState extends State<Loyalty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafcfoldKey,
      drawer: drawer(context),
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
          IconButton(
              icon: Icon(Icons.shopping_bag),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => check_out()));
              }),
          // IconButton(
          //     icon: isDark ? dark : light,
          //     onPressed: () {
          //       setState(() {
          //         isDark = !isDark;
          //       });
          //     })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "Images/image4.png",
                scale: 0.5,
              ),
            )),
            Card(
              elevation: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.green,
                  width: 350,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "مجموع نقاطك",
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.w600,
                              color: Colora().white,
                              fontSize: TextSized().textTitle),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "نقطة  " + "100 ",
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.w600,
                              color: Colora().white,
                              fontSize: TextSized().textTitle),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "JD كاش : 1 ",
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.w600,
                              color: Colora().white,
                              fontSize: TextSized().textTitle),
                        ),
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

drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Image.asset(
            "Images/logo.png",
            width: 52,
          ),
        ),
        ListTile(
          leading: Icon(Icons.home_outlined),
          title: Text('الرئيسية'),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyApp()));
          },
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart_outlined),
          title: Text('العربة'),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => check_out()));
          },
        ),
        ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text('حسابي'),
            onTap: () async {
              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.remove('phone');
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => chose()));
            }),
        ListTile(
          leading: Icon(Icons.loyalty_outlined),
          title: Text('نقاطي'),
          onTap: () {
            _scafcfoldKey.currentState.openEndDrawer();
          },
        ),
      ],
    ),
  );
}
