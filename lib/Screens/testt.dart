import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Learning',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  bool state = false;
  @override
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          leading: CupertinoNavigationBarBackButton(
            onPressed: () {},
            color: CupertinoColors.label,
          ),
          middle: Text("Flutter Cupertino Switch")),
      child: Material(
        child: Container(
            margin: EdgeInsets.only(top: 100, left: 20, right: 20),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Text(
                          "Wifi",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: CupertinoSwitch(
                          value: state,
                          onChanged: (value) {
                            state = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 1,
                  color: CupertinoColors.systemGrey5,
                ),
                SizedBox(height: 30),
                Text(
                  state == true ? "Wifi turned on" : "Wifi turned off",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: state == true
                          ? CupertinoColors.activeGreen
                          : CupertinoColors.destructiveRed),
                ),
              ],
            )),
      ),
    );
  }
}
