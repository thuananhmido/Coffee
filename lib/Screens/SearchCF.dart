import 'package:CoffeeAppUI/Screens/DetailPage.dart';
import 'package:CoffeeAppUI/model/coffee_model.dart';
import 'package:CoffeeAppUI/provider/cf_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchList extends StatefulWidget {
  SearchList({Key key}) : super(key: key);
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  Widget appBarTitle = Text(
    "Search Coffee",
    style: TextStyle(color: Colors.white),
  );
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  List<Coffee> _list;
  List<Coffee> _searchList = List();
  bool _IsSearching;
  String _searchText = "";
  _SearchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
          _buildSearchList();
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
          _buildSearchList();
        });
      }
    });
  }
  @override
  void initState() {
    super.initState();
    _IsSearching = false;
    Future.delayed(Duration.zero, () {
      this.init();
    });
  }

  @override
  Widget init() {
    _searchList = _list;
  }

  @override
  Widget build(BuildContext context) {
    CFProvider provider = Provider.of<CFProvider>(context);
    provider.getCFList();
    _list = provider.throwCFList;
    return Scaffold(
        key: key,
        appBar: buildBar(context),
        body: GridView.builder(
            itemCount: _searchList.length,
            itemBuilder: (context, index) {
              return Uiitem(_searchList[index]);
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            )));
  }

  // List<Coffee> _buildList() {
  //   return _list; //_list.map((contact) =>  Uiitem(contact)).toList();
  // }

  List<Coffee> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _searchList =
          _list; //_list.map((contact) =>  Uiitem(contact)).toList();
    } else {
      _searchList = _list
          .where((element) =>
              element.name.toLowerCase().contains(_searchText.toLowerCase()))
          .toList();
      print('${_searchList.length}');
      return _searchList; //_searchList.map((contact) =>  Uiitem(contact)).toList();
    }
  }

  Widget buildBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: appBarTitle,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFFF7643),
        actions: <Widget>[
          IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = Icon(
                    Icons.close,
                    color: Colors.orange,
                  );
                  this.appBarTitle = TextField(
                    controller: _searchQuery,
                    style: TextStyle(
                      color: Colors.orange,
                    ),
                    decoration: InputDecoration(
                        hintText: "Search here..",
                        hintStyle: TextStyle(color: Colors.white)),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ]);
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = Icon(
        Icons.search,
        color: Colors.orange,
      );
      this.appBarTitle = Text(
        " Search ",
        style: TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }
}

class Uiitem extends StatelessWidget {
  final Coffee coffee;
  Uiitem(this.coffee);
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 7),
      elevation: 10.0,
      child: InkWell(
        splashColor: Colors.orange,
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => DetailPage(
                image: coffee.image,
                name: coffee.name,
                price: coffee.price,
                description: coffee.description,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
                aspectRatio: 18.0 / 11.0,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(coffee.image),
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.coffee.name,
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
