import 'package:flutter/material.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({Key key}) : super(key: key);

  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About me"),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  child: Image(
                    image: AssetImage("assets/images/banner.jpg"),
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  child: Column(children: [
                    Text(
                      'Ứng Dụng Oder Cafe 2022',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black),
                    ),
                    Text("Mã Nguồn : github.com/mido/coffee"),
                    Text("Liên hệ : thuananhmido@gmail.com")
                  ]),
                ),
              ],
            ),
          ),
        ));
  }
}
