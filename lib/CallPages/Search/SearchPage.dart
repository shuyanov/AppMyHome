import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Styles/Colors.dart';
import '../CallInformation.dart';
import 'package:flutter/material.dart';

class SearchCallPage extends StatefulWidget {
  @override
  _SearchCallPageState createState() => _SearchCallPageState();
}

class _SearchCallPageState extends State<SearchCallPage> {
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult = [];
  bool isLoading = false;

  void onSearch() async {
    setState(() {
      searchResult = [];
      isLoading = true;
    });

    await FirebaseFirestore.instance
        .collection('calls')
        .where("name", isEqualTo: searchController.text.trim())
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        setState(() {
          isLoading = false;
        });
      }
      value.docs.forEach((call) {
        searchResult.clear();
        searchResult.add(call.data());
      });
      setState(() {
        isLoading = false;
      });
    });

    await FirebaseFirestore.instance
        .collection('calls')
        .where("name",
            isEqualTo: searchController.text[0].toUpperCase() +
                searchController.text.substring(1).toLowerCase().trim())
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Нет такой службы.\n(Возможно Вы ввели название службы не полностью)"),
        ));
        setState(() {
          isLoading = false;
        });
      }
      value.docs.forEach((call) {
        searchResult.clear();
        searchResult.add(call.data());
      });
      setState(() {
        isLoading = false;
      });
    });
  }

  void onSearchChanged() async {
    searchResult.clear();
    setState(() {
      searchResult = [];
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('calls')
        .where("name",
            isEqualTo: searchController.text[0].toUpperCase() +
                searchController.text.substring(1).toLowerCase().trim())
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        setState(() {
          isLoading = false;
        });
      }
      value.docs.forEach((call) {
        searchResult.clear();
        searchResult.add(call.data());
      });
      setState(() {
        isLoading = false;
      });
    });
    await FirebaseFirestore.instance
        .collection('calls')
        .where("name", isEqualTo: searchController.text.trim())
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        setState(() {
          isLoading = false;
        });
      }
      value.docs.forEach((call) {
        searchResult.clear();
        searchResult.add(call.data());
      });
      setState(() {
        isLoading = false;
      });
    });
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
          onChanged: (value) {
            onSearchChanged();
          },
          onSubmitted: (value) {
            onSearch();
          },
        ),
      ),
      body: Column(
        children: [
          if (searchResult.length > 0)
            Expanded(
                child: ListView.builder(
                    itemCount: searchResult.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.all(10),
                        title: Text(
                          searchResult[index]['name'],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: greyText),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CallInformation(
                                  city: searchResult[index]['city'],
                                  name: searchResult[index]['name'],
                                  description: searchResult[index]
                                      ['description'],
                                  street: searchResult[index]['street'],
                                  tel: searchResult[index]['tel'])));
                        },
                      );
                    }))
          else if (isLoading == true)
            Center(
              child: CircularProgressIndicator(
                color: purpleColor,
              ),
            )
        ],
      ),
    );
  }
}
