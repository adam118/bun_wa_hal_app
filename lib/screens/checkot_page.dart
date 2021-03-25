import 'package:bun_wa_hal/auth/chose.dart';
import 'package:bun_wa_hal/model/cart.dart';
import 'package:bun_wa_hal/screens/turkt_coffe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class check_out extends StatefulWidget {
  @override
  _check_outState createState() => _check_outState();
}

bool basjd = false;
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

// ignore: camel_case_types
class _check_outState extends State<check_out> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: false,
            actions: <Widget>[],
            title: Text("check out page"),
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
                ),
                ListTile(
                  leading: Icon(Icons.home_outlined),
                  title: Text('الرئيسية'),
                  onTap: () {
                    _scaffoldKey.currentState.openEndDrawer();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart_outlined),
                  title: Text('العربة'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => check_out()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.account_circle_outlined),
                  title: Text('حسابي'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => chose()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.loyalty_outlined),
                  title: Text('نقاطي'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => chose()));
                  },
                ),
              ],
            ),
          ),
          body: cart.basketItems.length == 0
              ? Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 170,
                      ),
                      Text("The cart is empty 😕"),
                      SizedBox(
                        height: 30,
                      ),
                      // ignore: deprecated_member_use
                      RaisedButton(
                        child: Text("Go and buy something"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Container(
                      height: 150,
                      child: ListView.builder(
                          itemCount: cart.basketItems.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              background: Container(
                                color: Colors.red,
                                child: ListTile(
                                  trailing: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onDismissed: (_) {
                                cart.remove(cart.basketItems[index]);
                              },
                              key: UniqueKey(),
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(10.0),
                                  subtitle: Column(
                                    children: [
                                      (cart.basketItems[index].dep),
                                      Text(currentsliderval.toInt().toString()),
                                      Text(cookinglevels),
                                    ],
                                  ),
                                  leading: (cart.basketItems[index].image),
                                  trailing: Text(cart
                                      .basketItems[index].quantity
                                      .toString()),
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
                              ),
                            );
                          }),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

void displayBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Center(
              child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 3.0, bottom: 5),
                  child: Text("no dATA")),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text("The Emergency meeting is dated secsfuly ☠☠"),
              ),
            ],
          )),
        );
      });
}

void done(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Center(
              child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 3.0, bottom: 5),
                  child: Text("no dATA")),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text("the order is plasd scsuffly ✔"),
              ),
            ],
          )),
        );
      });
}
