import 'package:command_flutter/Styles/Colors.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult = [];
  bool isLoading = false;

  void onSearch() async {
    setState(() {
      searchResult = [];
      isLoading = true;
    });

    searchController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          backgroundColor: purpleColor,
          title: TextField(
            autofocus: true,
            style: TextStyle(color: Colors.white),
            controller: searchController,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.white70),
              hintText: "Введите название службы....",
              border: InputBorder.none,
            ),
            textInputAction: TextInputAction.search,
            onChanged: (value) {},
            onSubmitted: (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("\"Поисковик\" в разработке")));
            },
          ),
        ),
        body: Container());
  }
}
