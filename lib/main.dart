import 'dart:async';

import 'package:badges/badges.dart';
import 'package:bun_wa_hal/Splash/Splash.dart';
import 'package:bun_wa_hal/auth/chose.dart';
import 'package:bun_wa_hal/auth/myAcount.dart';
import 'package:bun_wa_hal/model/cart.dart';
import 'package:bun_wa_hal/model/item.dart';
import 'package:bun_wa_hal/screens/turkt_coffe.dart';
import 'package:bun_wa_hal/style/styli.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => Cart(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    ),
  ));
}

int points;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

final List<String> imgList = [
  'Images/image1.png',
  'Images/image2.png',
];

Widget _shoppingCartBadge() {
  return Consumer<Cart>(
    builder: (context, cart, child) {
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => check_out()));
          },
        ),
      );
    },
  );
}

bool isDark = true;
Icon light = Icon(Icons.wb_sunny);
Icon dark = Icon(Icons.bedtime);

List<FireBaseItem> getDataFromFireBase() {
  final List<FireBaseItem> fireBaseItem = [];
  return fireBaseItem;
}

int _currentPage = 0;
PageController _pageController = PageController(
  initialPage: 0,
);

class _MyAppState extends State<MyApp> {
  String tokeID;

  @override
  void initState() {
    super.initState();
    Timer.periodic(
      Duration(seconds: 2),
      (Timer timer) {
        if (_currentPage < 2) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeOut,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    GlobalObjectKey<ScaffoldState> _scaffoldKey =
        GlobalObjectKey<ScaffoldState>(context);

    Query query = FirebaseFirestore.instance.collection('Items');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<Cart>(
        builder: (
          context,
          cart,
          child,
        ) {
          return Scaffold(
            key: _scaffoldKey,
            drawer: Container(
              width: 220,
              child: Drawer(
                elevation: 5,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Container(
                      height: 200,
                      width: 100,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Hero(
                              tag: logoTage,
                              child: Image.asset(
                                'Images/logo.png',
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.home_outlined,
                        color: Colors.black,
                      ),
                      title: Text(
                        'الرئيسية',
                        style: GoogleFonts.cairo(
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        _scaffoldKey.currentState.openEndDrawer();
                      },
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyAccount()));
                      },
                      leading: Icon(
                        Icons.account_box_outlined,
                        color: Colors.black,
                      ),
                      title: Text(
                        'حسابي',
                        style: GoogleFonts.cairo(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.black,
                      ),
                      title: Text(
                        'العربة',
                        style: GoogleFonts.cairo(
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => check_out()));
                      },
                    ),
                    ListTile(
                        leading: Icon(
                          Icons.account_circle_outlined,
                          color: Colors.black,
                        ),
                        title: Text(
                          'تسديل الخروج',
                          style: GoogleFonts.cairo(
                            color: Colors.black,
                          ),
                        ),
                        onTap: () async {
                          final SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.remove('phone');
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => chose()));
                        }),
                  ],
                ),
              ),
            ),
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
                cart.basketItems.length == 0
                    ? IconButton(
                        icon: Icon(
                          Icons.shopping_cart,
                        ),
                        tooltip: 'cart',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => check_out()));
                        })
                    : _shoppingCartBadge(),
              ],
            ),
            // body:
            body: ListView.builder(
              physics: ScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Slider(),
                      Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Text(
                          'منتجاتنا',
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              color: Colora().green,
                              fontSize: TextSized().textTitle + 5),
                        ),
                      ),
                      MainItem(),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class Slider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection('slider');

    return StreamBuilder<QuerySnapshot>(
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
        return Container(
          height: 200,
          child: ListView.builder(
            itemCount: 1,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                height: 200,
                child: PageView(
                  controller: _pageController,
                  allowImplicitScrolling: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: new NetworkImage(
                              querySnapshot.docs[index]['img1']),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: new NetworkImage(
                              querySnapshot.docs[index]['img2']),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: new NetworkImage(
                              querySnapshot.docs[index]['img3']),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
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

class MainItem extends StatefulWidget {
  @override
  _MainItemState createState() => _MainItemState();
}

class _MainItemState extends State<MainItem> {
  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection('Items');

    return StreamBuilder<QuerySnapshot>(
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
        return Container(
          height: MediaQuery.of(context).size.height + 400,
          child: ListView.builder(
            physics: ScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return Container(
                height: MediaQuery.of(context).size.height + 400,
                width: double.infinity,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: querySnapshot.size,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              price = querySnapshot.docs[index]['price'];
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => coffee1()));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                    color: Colora().brown, width: 3)),
                            child: Container(
                              height: 200,
                              width: 125,
                              child: Row(
                                children: [
                                  Container(
                                    height: 150,
                                    width: 150,
                                    child: Image.network(
                                      querySnapshot.docs[index]['imgpath'] ??
                                          "",
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Text(
                                              querySnapshot.docs[index]
                                                      ['name'] ??
                                                  'error',
                                              style: GoogleFonts.cairo(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colora().green,
                                                  fontSize:
                                                      TextSized().textTitle),
                                            ),
                                            Text(
                                              querySnapshot.docs[index]
                                                      ['des'] ??
                                                  'error',
                                              style: GoogleFonts.cairo(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colora().grey,
                                                  fontSize:
                                                      TextSized().textSmall),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Text(
                                              querySnapshot.docs[index]
                                                          ['stander'] +
                                                      "g    " ??
                                                  'error',
                                              style: GoogleFonts.cairo(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colora().green,
                                                  fontSize:
                                                      TextSized().textMediam +
                                                          5),
                                            ),
                                            Text(
                                              querySnapshot.docs[index]['price']
                                                          .toString() +
                                                      "JD    " ??
                                                  'error',
                                              style: GoogleFonts.cairo(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colora().green,
                                                  fontSize:
                                                      TextSized().textMediam),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
