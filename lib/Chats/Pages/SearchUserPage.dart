import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
        .where("name",
            isEqualTo: searchController.text[0].toUpperCase() +
                searchController.text.substring(1).toLowerCase().trim())
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
          searchResult.clear();
          searchResult.add(user.data());
        }
      });
      setState(() {
        isLoading = false;
      });
    });
    await FirebaseFirestore.instance
        .collection('users')
        .where("name", isEqualTo: searchController.text.trim())
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        setState(() {
          isLoading = false;
        });
      }
      value.docs.forEach((user) {
        if (user.data()['name'] != myUserName) {
          searchResult.clear();
          searchResult.add(user.data());
        }
      });
      setState(() {
        isLoading = false;
      });
    });

    await FirebaseFirestore.instance
        .collection('users')
        .where("surname",
            isEqualTo: searchController.text[0].toUpperCase() +
                searchController.text.substring(1).toLowerCase().trim())
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Нет такого пользователя.\n(Возможно вы ввели фамилию не полностью)"),
        ));
        setState(() {
          isLoading = false;
        });
      }
      value.docs.forEach((user) {
        if (user.data()['surname'] != myUserSurname) {
          searchResult.clear();
          searchResult.add(user.data());
        }
      });
      setState(() {
        isLoading = false;
      });
    });

    await FirebaseFirestore.instance
        .collection('users')
        .where("surname", isEqualTo: searchController.text.trim())
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        setState(() {
          isLoading = false;
        });
      }
      value.docs.forEach((user) {
        if (user.data()['surname'] != myUserSurname) {
          searchResult.clear();
          searchResult.add(user.data());
        }
      });
      setState(() {
        isLoading = false;
      });
    });

    await FirebaseFirestore.instance
        .collection('users')
        .where("middle_name",
            isEqualTo: searchController.text[0].toUpperCase() +
                searchController.text.substring(1).toLowerCase().trim())
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Нет такого пользователя.\n(Возможно вы ввели отчество не полностью)"),
        ));
        setState(() {
          isLoading = false;
        });
      }
      value.docs.forEach((user) {
        if (user.data()['middle_name'] != myUserMiddle_name) {
          searchResult.clear();
          searchResult.add(user.data());
        }
      });
      setState(() {
        isLoading = false;
      });
    });

    await FirebaseFirestore.instance
        .collection('users')
        .where("middle_name", isEqualTo: searchController.text.trim())
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        setState(() {
          isLoading = false;
        });
      }
      value.docs.forEach((user) {
        if (user.data()['middle_name'] != myUserMiddle_name) {
          searchResult.clear();
          searchResult.add(user.data());
        }
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
        .collection('users')
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
      value.docs.forEach((user) {
        if (user.data()['name'] != myUserName) {
          searchResult.clear();
          searchResult.add(user.data());
        }
      });
      setState(() {
        isLoading = false;
      });
    });

    await FirebaseFirestore.instance
        .collection('users')
        .where("name", isEqualTo: searchController.text[0].trim())
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        setState(() {
          isLoading = false;
        });
      }
      value.docs.forEach((user) {
        if (user.data()['name'] != myUserName) {
          searchResult.clear();
          searchResult.add(user.data());
        }
      });
      setState(() {
        isLoading = false;
      });
    });

    await FirebaseFirestore.instance
        .collection('users')
        .where("surname",
            isEqualTo: searchController.text[0].toUpperCase() +
                searchController.text.substring(1).toLowerCase().trim())
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        setState(() {
          isLoading = false;
        });
      }
      value.docs.forEach((user) {
        if (user.data()['surname'] != myUserSurname) {
          searchResult.clear();
          searchResult.add(user.data());
        }
      });
      setState(() {
        isLoading = false;
      });
    });

    await FirebaseFirestore.instance
        .collection('users')
        .where("surname", isEqualTo: searchController.text.trim())
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        setState(() {
          isLoading = false;
        });
      }
      value.docs.forEach((user) {
        if (user.data()['surname'] != myUserSurname) {
          searchResult.clear();
          searchResult.add(user.data());
        }
      });
      setState(() {
        isLoading = false;
      });
    });

    await FirebaseFirestore.instance
        .collection('users')
        .where("middle_name",
            isEqualTo: searchController.text[0].toUpperCase() +
                searchController.text.substring(1).toLowerCase().trim())
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        setState(() {
          isLoading = false;
        });
      }
      value.docs.forEach((user) {
        if (user.data()['middle_name'] != myUserMiddle_name) {
          searchResult.clear();
          searchResult.add(user.data());
        }
      });
      setState(() {
        isLoading = false;
      });
    });

    await FirebaseFirestore.instance
        .collection('users')
        .where("middle_name", isEqualTo: searchController.text.trim())
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        setState(() {
          isLoading = false;
        });
      }
      value.docs.forEach((user) {
        if (user.data()['middle_name'] != myUserMiddle_name) {
          searchResult.clear();
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
        foregroundColor: Colors.white,
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
                      return searchResult[index]['surname'] == "" ? ListTile(
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
                          // subtitle: Text(
                          //     '${searchResult[index]['name']} ${searchResult[index]['middle_name']}'),
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
                                            ['middle_name'])));
                          },
                          trailing: Icon(Icons.message)) : ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: Image.asset('assets/chat/resource29.png'),
                          // leading: CircleAvatar(
                          //   child:
                          //       Image.network(searchResult[index]['urlAvatar']),
                          // ),
                          title: Text(
                            searchResult[index]['surname'],
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700]),
                          ),
                          subtitle: Text(
                              '${searchResult[index]['name']} ${searchResult[index]['middle_name']}'),
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
                                            ['middle_name'])));
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
