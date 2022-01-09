import 'package:CoffeeAppUI/Screens/Cart_TT.dart';
import 'package:CoffeeAppUI/Screens/Profile.dart';
import 'package:CoffeeAppUI/Screens/SearchCF.dart';
import 'package:CoffeeAppUI/constants.dart';
import 'package:CoffeeAppUI/provider/cf_provider.dart';
import 'package:CoffeeAppUI/model/coffee_model.dart';
import 'package:CoffeeAppUI/Screens//Cart.dart';
import 'package:CoffeeAppUI/widgets/cf_Widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;
  List<Coffee> singleFoodList = [];
  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    CFProvider provider = Provider.of<CFProvider>(context);

    //////////////single food list/////////
    provider.getCFList();
    singleFoodList = provider.throwCFList;
    return Scaffold(
        drawer: Drawer(
          backgroundColor: kPrimaryLightColor,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(''),
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.jpg'),
                ),
                accountName: Text("${user.displayName}"),
                accountEmail: Text("${user.email}"),
              ),
              Divider(
                thickness: 2,
                color: Colors.white,
              ),
              Column(children: [
                ListTile(
                  leading: Icon(Icons.contacts),
                  title: Text(" Profile"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(" Đăng Xuất"),
                  onTap: () => signOut(),
                ),
              ]),
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0.0,
          actions: [
            Padding(
                padding: const EdgeInsets.all(9.0),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );
                  },
                ))
          ],
        ),
        body: Container(
          child: !isloggedin
              ? CircularProgressIndicator()
              : Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchList()),
                              );
                            },
                            decoration: InputDecoration(
                                hintText: "Bạn muốn uống gì,,,",
                                hintStyle: TextStyle(color: kPrimaryColor),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: kPrimaryColor,
                                ),
                                filled: true,
                                fillColor: kPrimaryLightColor,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 560,
                          child: GridView.count(
                              shrinkWrap: false,
                              primary: false,
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              children: singleFoodList
                                  .map(
                                    (e) => CFWidget(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) => DetailPage(
                                              image: e.image,
                                              name: e.name,
                                              price: e.price,
                                              description: e.description,
                                            ),
                                          ),
                                        );
                                      },
                                      image: e.image,
                                      price: e.price,
                                      name: e.name,
                                      description: e.description,
                                    ),
                                  )
                                  .toList()),
                        )
                      ],
                    ),
                  ],
                ),
        ));
  }
}
