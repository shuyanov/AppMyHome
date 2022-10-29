import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:command_flutter/Chats/Data/Admin.dart';
import 'package:command_flutter/Chats/Pages/ChatPage.dart';

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
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("\"Поисковик\" в разработке")));
        searchController.text = '';
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .where("name", isEqualTo: searchController.text)
    //     .get()
    //     .then((value) {
    //   if (value.docs.length < 1) {
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(SnackBar(content: Text("Нет такого пользователя.\n(Возможно вы ввели имя не полностью)")));
    //     setState(() {
    //       isLoading = false;
    //     });
    //     return;
    //   }
    //   value.docs.forEach((user) {
    //     if (user.data()['name'] != myUsername) {
    //       searchResult.add(user.data());
    //     }
    //   });
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Найти"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: "Что вы хотите найти?",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    onSearch();
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          // if (searchResult.length > 0)
          // Expanded(
          //     child: ListView.builder(
          //         itemCount: searchResult.length,
          //         shrinkWrap: true,
          //         itemBuilder: (context, index) {
          //           return ListTile(
          //             leading: CircleAvatar(
          //               child:
          //                   Image.network(searchResult[index]['urlAvatar']),
          //             ),
          //             title: Text(searchResult[index]['name']),
          //             subtitle: Text(searchResult[index]['description']),
          //             onTap: (){
          //               setState(() {
          //                     searchController.text = "";
          //                   });
          //                   Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                           builder: (context) => ChatPage(
          //                               currentUserId: myId,
          //                               friendId: searchResult[index]
          //                                   ['idUser'],
          //                               friendName: searchResult[index]
          //                                   ['name'],
          //                               friendDescription: searchResult[index]
          //                                   ['description'],
          //                               friendImage: searchResult[index]
          //                                   ['urlAvatar'])));
          //             },
          //             trailing: Icon(Icons.message)
          //           );
          //         })
          //         )
          // else if (isLoading == true)
          //   Center(
          //     child: CircularProgressIndicator(),
          //   )
        ],
      ),
    );
  }
}
