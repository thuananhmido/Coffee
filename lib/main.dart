import 'package:CoffeeAppUI/Screens/HomePage.dart';
import 'package:CoffeeAppUI/Screens/Login.dart';
import 'package:CoffeeAppUI/Screens/SignUp.dart';
import 'package:CoffeeAppUI/Screens/test.dart';
import 'package:CoffeeAppUI/fire_base/Start.dart';
import 'package:CoffeeAppUI/provider/cart_provider.dart';
import 'package:CoffeeAppUI/provider/cf_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CFProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coffee Oder App',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            color: Color(0xFFFF7643),
          ),
        ),
        home: HomePage(),
        routes: <String, WidgetBuilder>{
          "Login": (BuildContext context) => Login(),
          "SignUp": (BuildContext context) => SignUp(),
          "start": (BuildContext context) => Start(),
        },
      ),
    );
  }
}
