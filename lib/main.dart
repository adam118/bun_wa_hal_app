import 'package:badges/badges.dart';
import 'package:bun_wa_hal/auth/myAcount.dart';
import 'package:bun_wa_hal/screens/turkt_coffe.dart';
import 'package:bun_wa_hal/Splash/Splash.dart';
import 'package:bun_wa_hal/auth/chose.dart';
import 'package:bun_wa_hal/loyalty/loyalty.dart';
import 'package:bun_wa_hal/model/cart.dart';
import 'package:bun_wa_hal/model/item.dart';
import 'package:bun_wa_hal/style/styli.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

final List<String> imgList = [
  'Images/image1.png',
  'Images/image2.png',
];

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

bool isDark = true;
Icon light = Icon(Icons.wb_sunny);
Icon dark = Icon(Icons.bedtime);

List<FireBaseItem> getDataFromFireBase() {
  final List<FireBaseItem> fireBaseItem = [];
  return fireBaseItem;
}

class _MyAppState extends State<MyApp> {
  String tokeID;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalObjectKey<ScaffoldState> _scaffoldKey =
        GlobalObjectKey<ScaffoldState>(context);
    final List<UserItem> items = [
      UserItem(
        title: 'قهوة تركية',
        image: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => coffee1()));
          },
          child: Image.network(
            "https://www.mozzaik.shop/media/image/da/51/c2/DSC_0688.jpg",
          ),
        ),
        price: 2.0,
      ),
      UserItem(
        title: 'قهوة تركية',
        image: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => coffee1()));
          },
          child: Image.network(
            "https://feedo.shop/image/cache/catalog/Products%20Images/Soft-Drinks-Tea-Coffee/Tea-Coffee-Hot-Drinks/Coffee/Haseeb-Without-Cardamom-Coffee-200g-550x550.jpg",
          ),
        ),
        price: 1500,
      ),
      UserItem(
        title: 'قهوة تركية',
        image: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => coffee1()));
          },
          child: Image.network(
            "https://a.nooncdn.com/t_desktop-pdp-v1/v1532409190/N14456792A_1.jpg",
            scale: 6.5,
          ),
        ),
        price: 5.5,
      ),
      UserItem(
        title: 'قهوة تركية',
        image: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => coffee1()));
          },
          child: Image.network(
            "https://zamrad.shop/image/cache/catalog/product/coffee/4529685241-550x550.jpg",
          ),
        ),
        price: 310,
      ),
    ];
    return MaterialApp(
        theme: isDark ? ThemeData.light() : ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: Consumer<Cart>(builder: (
          context,
          cart,
          child,
        ) {
          return Scaffold(
              key: _scaffoldKey,
              drawer: Theme(
                data: Theme.of(context).copyWith(
                  // Set the transparency here
                  canvasColor: Colors.white.withOpacity(
                      0), //or any other color you want. e.g Colors.blue.withOpacity(0.5)
                ),
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
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: <Color>[
                              Colors.black.withOpacity(0),
                              Colora().green
                            ],
                          ),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: Hero(
                              tag: logoTage,
                              child: Image.asset(
                                'Images/logo.png',
                              ),
                            )),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.home_outlined,
                          color: Colors.white,
                        ),
                        title: Text(
                          'الرئيسية',
                          style: GoogleFonts.cairo(
                            color: Colors.white,
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
                          color: Colors.white,
                        ),
                        title: Text(
                          'حسابي',
                          style: GoogleFonts.cairo(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                        title: Text(
                          'العربة',
                          style: GoogleFonts.cairo(
                            color: Colors.white,
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
                            color: Colors.white,
                          ),
                          title: Text(
                            'تسديل الخروج',
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                            ),
                          ),
                          onTap: () async {
                            final SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.remove('phone');
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => chose()));
                          }),
                      ListTile(
                        leading: Icon(
                          Icons.loyalty_outlined,
                          color: Colors.white,
                        ),
                        title: Text(
                          'نقاطي',
                          style: GoogleFonts.cairo(
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Loyalty()));
                        },
                      ),
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
                  IconButton(
                      icon: isDark ? dark : light,
                      tooltip: 'dark/light mood',
                      onPressed: () {
                        setState(() {
                          isDark = !isDark;
                        });
                      })
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        height: 200,
                        child: CarouselSlider(
                          carouselController: CarouselController(),
                          options: CarouselOptions(
                            autoPlay: true,
                            height: 301,
                            initialPage: 2,
                          ),
                          items: imgList
                              .map((item) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      child: Container(
                                        child: Center(
                                            child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.asset(item,
                                              fit: BoxFit.contain,
                                              scale: 0.5,
                                              width: 1000),
                                        )),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Text(
                        "منتجاتنا",
                        style: GoogleFonts.cairo(
                            fontWeight: FontWeight.w600,
                            color: Colora().green,
                            fontSize: TextSized().textTitle),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Hero(
                              tag: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: InkWell(
                                    onTap: () {
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
                                              color: Colora().brown, width: 4)),
                                      child: Container(
                                        height: 160,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ClipRRect(
                                              child: Image.asset(
                                                'Images/coffee.png',
                                                scale: 7,
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
                                                        child: Text(
                                                          items[index].title,
                                                          style: GoogleFonts.cairo(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colora()
                                                                  .green,
                                                              fontSize: TextSized()
                                                                  .textMediam),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          "Turkish coffee",
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
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        }));
  }
}
