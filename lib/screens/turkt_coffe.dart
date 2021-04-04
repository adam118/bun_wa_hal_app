import 'package:badges/badges.dart';
import 'package:bun_wa_hal/model/cart.dart';
import 'package:bun_wa_hal/model/item.dart';
import 'package:bun_wa_hal/order/finalscreen.dart';
import 'package:bun_wa_hal/order/getfrompalce.dart';
import 'package:bun_wa_hal/style/styli.dart';
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

bool getFromPlaces = false;
final List<FireBaseItem> fbitem = [];
double currentsliderval = 250;
double price = 2;
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
        title: 'قهوة تركية',
        image: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => coffee1()));
          },
          child: Image.asset(
            "Images/coffee.png",
            scale: 0.5,
          ),
        ),
        blond: Radio(
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
        medium: Radio(
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
        quarter: Radio(
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
        dep: CheckboxListTile(
          activeColor: Colors.brown,
          title: Text("مع هيل",
              textAlign: TextAlign.left,
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              )),
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
          controlAffinity: ListTileControlAffinity.leading,
        ),
        containHeal: heal,
        price: price,
      ),
    ];
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    void _showSnackBar() {
      print("Show Snackbar here !");
      final snackBar = new SnackBar(
        content: new Text("This is a SnackBar"),
        duration: new Duration(seconds: 3),
        backgroundColor: Colora().green,
        action: new SnackBarAction(
            label: 'Ok',
            onPressed: () {
              print('press Ok on SnackBar');
            }),
      );
      //How to display Snackbar ?
      // ignore: deprecated_member_use
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

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
            body: StreamBuilder<cloud.QuerySnapshot>(
              stream: query.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                cloud.QuerySnapshot querySnapshot = snapshot.data;
                if (snapshot.connectionState == ConnectionState.active) {
                  return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) => Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              //Image
                              Hero(
                                tag: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          querySnapshot.docs[index]['points'] +
                                              2;
                                        });
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
                                                width: 4)),
                                        child: Container(
                                          height: 160,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ClipRRect(
                                                child: Image.network(
                                                  querySnapshot.docs[index]
                                                      ['imgpath'],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Center(
                                                    child: Column(
                                                      children: [
                                                        Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              querySnapshot
                                                                          .docs[
                                                                      index]
                                                                  ['name'],
                                                              style: GoogleFonts.cairo(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colora()
                                                                      .green,
                                                                  fontSize:
                                                                      TextSized()
                                                                              .textSmall +
                                                                          10),
                                                            ),
                                                          ),
                                                        ),
                                                        Center(
                                                          child: Text(
                                                            querySnapshot
                                                                    .docs[index]
                                                                        [
                                                                        'points']
                                                                    .toString() +
                                                                "عدد النقاط ",
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
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                color: Colora().green,
                                child: Center(
                                  child: Text(
                                    "الوزن",
                                    style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 20),
                                  ),
                                ),
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Spacer(),
                                  Container(
                                    height: 70,
                                    child: Row(
                                      children: [
                                        Text(
                                            querySnapshot.docs[indexs]['size']
                                                        ['وقية']
                                                    .toString() +
                                                "kg",
                                            style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            )),
                                        (items[indexs].quarter)
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 70,
                                    child: Row(
                                      children: [
                                        Text(
                                            querySnapshot.docs[indexs]['size']
                                                        ['نص كيلو']
                                                    .toString() +
                                                "kg",
                                            style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            )),
                                        (items[indexs].half)
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 70,
                                    child: Row(
                                      children: [
                                        Text(
                                            querySnapshot.docs[indexs]['size']
                                                        ['كيلو']
                                                    .toString() +
                                                "kg",
                                            style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            )),
                                        (items[indexs].one)
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),

                              //end addons(size)

                              //addons(cookinglevel)

                              Container(
                                width: double.infinity,
                                color: Colora().green,
                                child: Center(
                                  child: Text(
                                    "درجة التحميص",
                                    style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 20),
                                  ),
                                ),
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Spacer(),
                                  Container(
                                    height: 70,
                                    child: Row(
                                      children: [
                                        Text(
                                          "فاتحة",
                                          style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        (items[indexs].blond)
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 70,
                                    child: Row(
                                      children: [
                                        Text(
                                          "وسط",
                                          style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        (items[indexs].medium)
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 70,
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
                                color: Colora().green,
                                child: Center(
                                  child: Text(
                                    "اضافات",
                                    style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 20),
                                    /*
                                        color : Colors.blue*/
                                  ),
                                ),
                              ),
                              (items[indexs].dep),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              // ignore: deprecated_member_use
                                              child: FlatButton(
                                                  color: Colora().green,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        price.toString(),
                                                        style: GoogleFonts.cairo(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                            fontSize:
                                                                TextSized()
                                                                    .textLarg),
                                                      ),
                                                      Text(
                                                        "  JD",
                                                        style:
                                                            GoogleFonts.cairo(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .brown,
                                                                fontSize: 22),
                                                      ),
                                                    ],
                                                  ),
                                                  splashColor: Colora().green,
                                                  onPressed: () {}),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      // ignore: deprecated_member_use
                                      child: FlatButton(
                                        color: Colora().green,
                                        child: Row(
                                          children: [
                                            Text(
                                              "اضافة للسلة",
                                              style: GoogleFonts.cairo(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                  fontSize:
                                                      TextSized().textLarg - 5),
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          _showSnackBar();

                                          setState(
                                            () {
                                              cart.add(items[indexs]);
                                              displayAddd(context);
                                              setState(
                                                () {
                                                  fbitem.add(
                                                    FireBaseItem(
                                                      title:
                                                          (items[indexs].title),
                                                      price:
                                                          (items[indexs].price),
                                                      cookingLevel:
                                                          cookinglevels,
                                                      containHeal: heal,
                                                      size: currentsliderval,
                                                    ),
                                                  );

                                                  print(
                                                    FireBaseItem(
                                                      title:
                                                          (items[indexs].title),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
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

void displayAddd(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actions: [
          Container(
            width: MediaQuery.of(context).size.width / 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => check_out()));
                },
                color: Colors.brown,
                child: Text("تاكيد الطلب"),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
                color: Colors.green,
                child: Text("استمرار"),
              ),
            ),
          ),
        ],
        elevation: TextSized().textLarg,
        title: Text(
          "تمت اضافة هاذا المنتج بنجاح",
          textAlign: TextAlign.right,
          style: GoogleFonts.cairo(fontSize: 15, color: Colors.black),
        ),
      );
    },
  );
}

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
    Firebase.initializeApp().whenComplete(
      () {
        print("completed");
        setState(() {});
      },
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
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
                        height: 350,
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
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            side: BorderSide(
                                                color: Colors.brown,
                                                width: 2.5)),
                                        child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.all(10.0),
                                          subtitle: Column(
                                            children: [
                                              (cart.basketItems[index].dep),
                                              Text(currentsliderval
                                                  .toInt()
                                                  .toString()),
                                              Text(cookinglevels),
                                            ],
                                          ),
                                          trailing:
                                              (cart.basketItems[index].image),
                                          leading: IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () {
                                                cart.remove(
                                                    cart.basketItems[index]);
                                              }),
                                          title: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                cart.basketItems[index].title,
                                                textAlign: TextAlign.right,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  cart.basketItems[index].price
                                                      .toString(),
                                                  textAlign: TextAlign.right),
                                            ],
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
                    Row(
                      children: [
                        Spacer(),
                        Container(
                          width: 150,
                          child: Row(
                            children: [
                              Spacer(),
                              Text("استلام من الفرع",
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  )),
                              Radio(
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
                                height: 70,
                                width: 150,
                                child: Center(
                                  child: Container(
                                    child: Text(
                                      cart.totalPrice.toString(),
                                      style: GoogleFonts.cairo(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize: TextSized().textLarg),
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            height: 70,
                            width: 150,
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
                                                checkout_Screen_final()));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (contaxt) =>
                                                getFromPlace()));
                                  }
                                },
                                child: Text("متابعة",
                                    style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 20)),
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
