import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Styles/Colors.dart';
import '/Chats/Data/Admin.dart';
import '/Chats/Pages/ChatPage.dart';

import 'package:flutter/material.dart';

class SearchUserPage extends StatefulWidget {
  @override
  _SearchUserPageState createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult = [];
  bool isLoading = false;

  void onSearch() async {
    setState(() {
      searchResult = [];
      isLoading = true;
    });

    await FirebaseFirestore.instance
        .collection('users')
        .where("name", isEqualTo: searchController.text)
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Нет такого пользователя.\n(Возможно вы ввели имя не полностью)"),
        ));
        setState(() {
          isLoading = false;
        });
      }
      value.docs.forEach((user) {
        if (user.data()['name'] != myUserName) {
          //
          searchResult.add(user.data());
        }
      });
      setState(() {
        isLoading = false;
      });
    });
  }

  void onSearchChanged() async {
    setState(() {
      searchResult = [];
      isLoading = true;
    });

    await FirebaseFirestore.instance
        .collection('users')
        .where("name", isEqualTo: searchController.text)
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        setState(() {
          isLoading = false;
        });
      }
      value.docs.forEach((user) {
        if (user.data()['name'] != myUserName) {
          //
          searchResult.add(user.data());
        }
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
            hintText: "Введите имя пользователя....",
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
                          leading: Image.asset('assets/chat/resource29.png'),
                          // leading: CircleAvatar(
                          //   child:
                          //       Image.network(searchResult[index]['urlAvatar']),
                          // ),
                          title: Text(
                            searchResult[index]['name'],
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700]),
                          ),
                          // subtitle: Text(searchResult[index]['description']),
                          onTap: () {
                            setState(() {
                              searchController.text = "";
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                        currentUserId: myId,
                                        friendId: searchResult[index]['idUser'],
                                        friendName: searchResult[index]['name'],
                                        friendSurname: searchResult[index]
                                            ['surname'],
                                        friendMiddle_name: searchResult[index]
                                            ['middle_name'],
                                        friendImage: searchResult[index]
                                            ['urlAvatar'])));
                          },
                          trailing: Icon(Icons.message));
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
