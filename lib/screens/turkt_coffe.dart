import 'package:badges/badges.dart';
import 'package:bun_wa_hal/Splash/Splash.dart';
import 'package:bun_wa_hal/model/cart.dart';
import 'package:bun_wa_hal/model/item.dart';
import 'package:bun_wa_hal/order/finalscreen.dart';
import 'package:bun_wa_hal/order/getfrompalce.dart';
import 'package:bun_wa_hal/style/styli.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cloud;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../main.dart';

void min() {
  runApp(ChangeNotifierProvider(
    create: (context) => Cart(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: coffee1(),
    ),
  ));
}

int qun = 1;
bool getFromPlaces = false;
final List<FireBaseItem> fbitem = [];
double currentsliderval = 250;
double price;
double containHeal = 0.5;
String getFromPlaced = '';
String groupval3;
// ignore: unused_element
DatabaseReference _counterRef;
double th = 9;
double fth = 13;
String quarter;
String half;
String one;
bool heal = false;
int indexs = fbitem.length;
double maxValue = maxValue > 0 ? maxValue : 1000;
String groubVal = cookinglevels;
String groubVal2 = '';
String cookinglevels;
int size = 250;
back(BuildContext context) {
  IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      });
}

// ignore: unused_element
final Future<FirebaseApp> _initialization = Firebase.initializeApp();

// ignore: camel_case_types
class coffee1 extends StatefulWidget {
  @override
  _coffee1State createState() => _coffee1State();
}

// ignore: camel_case_types
class _coffee1State extends State<coffee1> {
  var query = cloud.FirebaseFirestore.instance.collection('Items');

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<UserItem> items = [
      UserItem(
        image: InkWell(
          child: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/bun-wa-hal-app.appspot.com/o/169069594_136042641804149_3404306237808873753_n.png?alt=media&token=6a167d79-3f20-47bf-8ac2-0cee6f702f59"),
        ),
        price: 2.0,
        half: Radio(
          activeColor: Colors.brown,
          hoverColor: Colors.brown,
          value: '2',
          groupValue: groubVal2,
          onChanged: (val) {
            groubVal2 = val;
            setState(() {
              size = 500;
              if (size == 500) {
                setState(() {
                  price = 4;
                });
              }
            });
          },
        ),
        title: "قهوة سعودية",
        one: Radio(
          activeColor: Colors.brown,
          hoverColor: Colors.brown,
          value: '3',
          groupValue: groubVal2,
          onChanged: (val) {
            groubVal2 = val;
            setState(() {
              size = 1000;
              if (size == 1000) {
                setState(() {
                  price = 8;
                });
              }
            });
          },
        ),
        dark: Radio(
          activeColor: Colors.brown,
          hoverColor: Colors.brown,
          value: "Dark",
          groupValue: groubVal,
          onChanged: (val) {
            groubVal = val;
            setState(() {
              cookinglevels = "غامقة";
            });
          },
        ),
        dep: ListTile(
          trailing: CircularCheckBox(
            activeColor: Colors.brown,
            value: heal,
            onChanged: (newValue) {
              setState(() {
                heal = newValue;
                if (heal == true) {
                  price += containHeal;
                } else {
                  price -= containHeal;
                }
              });
            },
          ),
          title: Text(
            "مع هيل",
            textAlign: TextAlign.right,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ];

    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return MaterialApp(
      theme: isDark ? ThemeData.light() : ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Consumer<Cart>(
        builder: (
          context,
          cart,
          child,
        ) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              leading: IconButton(
                  color: Colora().brown,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                  }),
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
                cart.basketItems.length == 0
                    ? IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => check_out()));
                        })
                    : _shoppingCartBadge()
              ],
            ),
            body: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 20,
                    child: Column(
                      children: [
                        //Image
                        StreamBuilder<cloud.QuerySnapshot>(
                          stream: query.snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            if (snapshot.hasError) {
                              print(snapshot.error);
                              return Center(
                                  child: Text(snapshot.error.toString()));
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            cloud.QuerySnapshot querySnapshot = snapshot.data;

                            return Hero(
                              tag: logoTage,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {});
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => coffee1()));
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: BorderSide(
                                              color: Colora().brown, width: 3)),
                                      child: Container(
                                        height: 150,
                                        width: 325,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 18.0, bottom: 18),
                                              child: Container(
                                                height: 150,
                                                width: 150,
                                                child: Image.network(
                                                  querySnapshot.docs[index]
                                                          ['imgpath'] ??
                                                      "",
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Spacer(),
                                                Center(
                                                  child: Container(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          querySnapshot.docs[
                                                                      index]
                                                                  ['name'] ??
                                                              'error',
                                                          style: GoogleFonts.cairo(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colora()
                                                                  .green,
                                                              fontSize:
                                                                  TextSized()
                                                                      .textTitle),
                                                        ),
                                                        Text(
                                                          querySnapshot.docs[
                                                                      index]
                                                                  ['des'] ??
                                                              'error',
                                                          style: GoogleFonts.cairo(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colora().grey,
                                                              fontSize:
                                                                  TextSized()
                                                                      .textSmall),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Container(
                          width: double.infinity,
                          height: 30,
                          color: Colora().green,
                          child: Center(
                            child: Text(
                              "الوزن",
                              style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Spacer(),
                            Container(
                              child: Row(
                                children: [
                                  StreamBuilder<cloud.QuerySnapshot>(
                                      stream: query.snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }

                                        if (snapshot.hasError) {
                                          print(snapshot.error);
                                          return Center(
                                              child: Text(
                                                  snapshot.error.toString()));
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                        cloud.QuerySnapshot querySnapshot =
                                            snapshot.data;

                                        return Text(
                                          querySnapshot.docs[indexs]['size']
                                                  ['وقية']
                                              .toString(),
                                          style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        );
                                      }),
                                  Radio(
                                    activeColor: Colors.brown,
                                    hoverColor: Colors.brown,
                                    value: '1',
                                    groupValue: groubVal2,
                                    onChanged: (val) {
                                      groubVal2 = val;
                                      setState(() {
                                        size = 250;
                                        if (size == 250) {
                                          setState(() {
                                            price = 2;
                                          });
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            StreamBuilder<cloud.QuerySnapshot>(
                                stream: query.snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }

                                  if (snapshot.hasError) {
                                    print(snapshot.error);
                                    return Center(
                                      child: Text(
                                        snapshot.error.toString(),
                                      ),
                                    );
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  cloud.QuerySnapshot querySnapshot =
                                      snapshot.data;

                                  return Container(
                                    child: Row(
                                      children: [
                                        Text(
                                            querySnapshot.docs[indexs]['size']
                                                    ['نص كيلو']
                                                .toString(),
                                            style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            )),
                                        (items[indexs].half)
                                      ],
                                    ),
                                  );
                                }),
                            Spacer(),
                            StreamBuilder<cloud.QuerySnapshot>(
                                stream: query.snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }

                                  if (snapshot.hasError) {
                                    print(snapshot.error);
                                    return Center(
                                        child: Text(snapshot.error.toString()));
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  cloud.QuerySnapshot querySnapshot =
                                      snapshot.data;

                                  return Container(
                                    child: Row(
                                      children: [
                                        Text(
                                            querySnapshot.docs[indexs]['size']
                                                    ['كيلو']
                                                .toString(),
                                            style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            )),
                                        (items[indexs].one)
                                      ],
                                    ),
                                  );
                                }),
                            Spacer(),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          height: 30,
                          color: Colora().green,
                          child: Center(
                            child: Text(
                              "درجة التحميص",
                              style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Spacer(),
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    "فاتحة",
                                    style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Radio(
                                    activeColor: Colors.brown,
                                    hoverColor: Colors.brown,
                                    value: "blond",
                                    groupValue: groubVal,
                                    onChanged: (val) {
                                      groubVal = val;
                                      setState(() {
                                        cookinglevels = "شقراء";
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    "وسط",
                                    style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Radio(
                                    activeColor: Colors.brown,
                                    hoverColor: Colors.brown,
                                    value: "meadiam",
                                    groupValue: groubVal,
                                    onChanged: (val) {
                                      groubVal = val;
                                      setState(() {
                                        cookinglevels = "وسط";
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              child: Row(
                                children: [
                                  Text("غامقة",
                                      style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      )),
                                  (items[indexs].dark)
                                ],
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          height: 30,
                          color: Colora().green,
                          child: Center(
                            child: Text(
                              "اضافات",
                              style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        (items[indexs].dep),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30.0, right: 30),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      color: Colora().brown,
                                      height: 60,
                                      width: 100,
                                      child: Row(
                                        children: [
                                          Text(
                                            "   " + price.toString(),
                                            style: GoogleFonts.cairo(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                                fontSize: TextSized().textLarg),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              "  JD",
                                              style: GoogleFonts.cairo(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "السعر",
                                    style: GoogleFonts.cairo(
                                      color: Colors.grey,
                                      fontSize: 10,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30.0, right: 30),
                              child: Column(
                                children: [
                                  InkWell(
                                    child: Image.asset(
                                      "Images/add.png",
                                      scale: 2,
                                    ),
                                    onTap: () {
                                      setState(
                                        () {
                                          cart.add(items[indexs]);
                                          displayAdd(context);
                                          setState(
                                            () {
                                              fbitem.add(
                                                FireBaseItem(
                                                  title: (items[indexs].title),
                                                  price: (items[indexs].price),
                                                  cookingLevel: cookinglevels,
                                                  containHeal: heal,
                                                  size: currentsliderval,
                                                ),
                                              );

                                              print(
                                                FireBaseItem(
                                                  title: (items[indexs].title),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "اضافة للسلة",
                                        style: GoogleFonts.cairo(
                                          color: Colors.grey,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

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

void displayAdd(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => check_out(),
                      ),
                    );
                  },
                  color: Colors.brown,
                  child: Text(
                    "تاكيد الطلب",
                    style: GoogleFonts.cairo(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                  },
                  color: Colors.green,
                  child: Text(
                    "استمرار",
                    style: GoogleFonts.cairo(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        elevation: 20,
        title: Center(
          child: Text(
            "تمت اضافة هاذا المنتج بنجاح",
            textAlign: TextAlign.right,
            style: GoogleFonts.cairo(fontSize: 15, color: Colors.black),
          ),
        ),
      );
    },
  );
}

String textsize;

// ignore: camel_case_types
class check_out extends StatefulWidget {
  @override
  _check_outState createState() => _check_outState();
}

// ignore: camel_case_types
class _check_outState extends State<check_out> {
  @override
  void initState() {
    super.initState();
    setState(
      () {
        if (size == 1000) {
          setState(
            () {
              textsize = "كيلو";
            },
          );
        } else if (size == 500) {
          setState(
            () {
              textsize = "نص كيلو";
            },
          );
        } else if (size == 250) {
          setState(
            () {
              textsize = "وقية";
            },
          );
        }
      },
    );
    Firebase.initializeApp().whenComplete(
      () {
        print("completed");
        setState(() {});
      },
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String heall;
  @override
  Widget build(BuildContext context) {
    if (heal == false) {
      setState(() {
        heall = "بدون هيل";
      });
    } else {
      setState(() {
        heall = "مع هيل";
      });
    }
    return Consumer<Cart>(
      builder: (context, cart, child) {
        double total = cart.totalPrice;
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
                color: Colora().brown,
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
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
                  cart.basketItems.length == 0
                      ? Container(
                          height: 1,
                          width: 1,
                        )
                      : IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              cart.basketItems.length = 0;
                            });
                          })
                ],
              ),
            ],
          ),
          body: cart.basketItems.length == 0
              ? Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 170,
                      ),
                      Center(
                        child: Text(
                          "السلة فارغة",
                          style: GoogleFonts.cairo(
                              color: Colors.black, fontSize: 28),
                        ),
                      ),
                      SizedBox(
                        height: TextSized().textLarg,
                      ),
                      Center(
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          color: Colora().green,
                          child: Text(
                            "تسوق الان",
                            style: GoogleFonts.cairo(
                                color: Colors.white, fontSize: 28),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()));
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 300,
                        child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  child: ListView.builder(
                                    physics: ScrollPhysics(),
                                    itemCount: cart.basketItems.length,
                                    itemBuilder: (context, index) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        coffee1()));
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                side: BorderSide(
                                                    color: Colora().brown,
                                                    width: 3)),
                                            child: Container(
                                              height: 222,
                                              width: 125,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Container(
                                                          height: 140,
                                                          child: Image.network(
                                                            "https://firebasestorage.googleapis.com/v0/b/bun-wa-hal-app.appspot.com/o/169069594_136042641804149_3404306237808873753_n.png?alt=media&token=6a167d79-3f20-47bf-8ac2-0cee6f702f59",
                                                            scale: 5,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                      .green,
                                                                  child:
                                                                      GestureDetector(
                                                                    child: Icon(
                                                                      Icons
                                                                          .remove,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    onTap: () {
                                                                      setState(
                                                                        () {
                                                                          qun--;
                                                                        },
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              qun.toString(),
                                                              style: GoogleFonts
                                                                  .cairo(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colora()
                                                                          .green),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                      .green,
                                                                  child:
                                                                      GestureDetector(
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    onTap: () {
                                                                      setState(
                                                                        () {
                                                                          qun++;
                                                                        },
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 14.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text(
                                                          (cart
                                                                  .basketItems[
                                                                      index]
                                                                  .title) ??
                                                              'error',
                                                          style: GoogleFonts.cairo(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colora()
                                                                  .green,
                                                              fontSize: TextSized()
                                                                      .textMediam +
                                                                  5),
                                                        ),
                                                        SizedBox(
                                                          height: 0,
                                                        ),
                                                        Container(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                textsize +
                                                                        " - " ??
                                                                    'error',
                                                                style:
                                                                    GoogleFonts
                                                                        .cairo(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colora()
                                                                      .green,
                                                                  fontSize:
                                                                      TextSized()
                                                                              .textMediam -
                                                                          3,
                                                                ),
                                                              ),
                                                              Text(
                                                                cookinglevels +
                                                                        " - " ??
                                                                    'error',
                                                                style:
                                                                    GoogleFonts
                                                                        .cairo(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colora()
                                                                      .green,
                                                                  fontSize:
                                                                      TextSized()
                                                                              .textMediam -
                                                                          3,
                                                                ),
                                                              ),
                                                              Text(
                                                                heall + " -  " ??
                                                                    'error',
                                                                style:
                                                                    GoogleFonts
                                                                        .cairo(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colora()
                                                                      .green,
                                                                  fontSize:
                                                                      TextSized()
                                                                              .textMediam -
                                                                          3,
                                                                ),
                                                              ),
                                                              Text(
                                                                price.toString() +
                                                                        " JD" +
                                                                        " - " ??
                                                                    'error',
                                                                style:
                                                                    GoogleFonts
                                                                        .cairo(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colora()
                                                                      .green,
                                                                  fontSize:
                                                                      TextSized()
                                                                              .textMediam -
                                                                          3,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        " اجمالي المكونات بالسلة" +
                            "  " +
                            cart.count.toString(),
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.w600,
                          color: Colora().black,
                          fontSize: TextSized().textMediam - 5,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Container(
                          width: 150,
                          child: Row(
                            children: [
                              Spacer(),
                              Text(
                                "استلام من الفرع",
                                style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              Radio(
                                activeColor: Colora().brown,
                                groupValue: getFromPlaced,
                                onChanged: (val) {
                                  getFromPlaced = val;
                                  setState(
                                    () {
                                      getFromPlaces = true;
                                      if (getFromPlaces == true) {}
                                    },
                                  );
                                },
                                value: 'getfrom',
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        Spacer(),
                        Center(
                          child: Container(
                            width: 150,
                            child: Row(
                              children: [
                                Spacer(),
                                Text(
                                  "توصيل",
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                Radio(
                                  activeColor: Colora().brown,
                                  groupValue: getFromPlaced,
                                  onChanged: (val) {
                                    getFromPlaced = val;

                                    setState(
                                      () {
                                        getFromPlaces = false;
                                        if (getFromPlaces == false) {}
                                      },
                                    );
                                  },
                                  value: 'delevery',
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.brown,
                              height: 60,
                              width: 140,
                              child: Center(
                                child: Text(
                                  cart.totalPrice.toString() + " JD",
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: TextSized().textLarg,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            height: 60,
                            width: 140,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                color: Colora().green,
                                onPressed: () {
                                  if (getFromPlaces == false) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (contaxt) =>
                                            checkout_Screen_final(),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (contaxt) => getFromPlace(),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  "متابعة",
                                  style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ],
                ),
        );
      },
    );
  }
}
