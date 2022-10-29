// import 'package:command_flutter/Models/User.dart';
// import 'package:command_flutter/Pages/ChatPage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import '../Chats.dart';
// import '../Data/users.dart';

// class SearchPage extends StatelessWidget {
//   const SearchPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
//           keyboardType: TextInputType.url,
//           decoration: InputDecoration(
//               border: InputBorder.none, hintText: "Поиск по ФИО"),
//         ), //Text("Поиск"),
//       ),
//       body: SafeArea(
//           child: StreamBuilder<List<User>>(
//             stream: _Firebase.getUsers(),
//             builder: (context, snapshot) {
//               switch (snapshot.connectionState) {
//                 case ConnectionState.waiting:
//                   return Center(child: CircularProgressIndicator());
//                 default:
//                   if (snapshot.hasError) {
//                     print(snapshot.error);
//                     return buildText('Something Went Wrong Try later');
//                   } else {
//                     final users = snapshot.data;

//                     if (users.isEmpty) {
//                       return buildText('No Users Found');
//                     } else
//                       return Column(
//                         children: [
//                           ChatHeaderWidget(users: users),
//                           ChatBodyWidget(users: users)
//                         ],
//                       );
//                   }
//               }
//             },
//           ),
//         ),
//     );
//   }
//     Widget buildText(String text) => Center(
//         child: Text(
//           text,
//           style: TextStyle(fontSize: 24, color: Colors.white),
//         ),
//       );
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:command_flutter/Chats/Data/Admin.dart';
import 'package:command_flutter/Chats/Pages/ChatPage.dart';

import 'package:flutter/material.dart';

import '../Models/User.dart';

class SearchPage extends StatefulWidget {
  //User user;
  SearchPage();

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
    await FirebaseFirestore.instance
        .collection('users')
        .where("name", isEqualTo: searchController.text)
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("No User Found")));
        setState(() {
          isLoading = false;
        });
        return;
      }
      value.docs.forEach((user) {
        if (user.data()['name'] != myUsername) {
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
        title: Text("Search your Friend"),
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
                        hintText: "type username....",
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
          if (searchResult.length > 0)
            Expanded(
                child: ListView.builder(
                    itemCount: searchResult.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child:
                              Image.network(searchResult[index]['urlAvatar']),
                        ),
                        title: Text(searchResult[index]['name']),
                        subtitle: Text(searchResult[index]['description']),
                        onTap: (){
                          setState(() {
                                searchController.text = "";
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatPage(
                                          currentUserId: myId,
                                          friendId: searchResult[index]
                                              ['idUser'],
                                          friendName: searchResult[index]
                                              ['name'],
                                          friendDescription: searchResult[index]
                                              ['description'],
                                          friendImage: searchResult[index]
                                              ['urlAvatar'])));
                        },
                        trailing: Icon(Icons.message)
                            //onPressed: () {
                              // setState(() {
                              //   searchController.text = "";
                              // });
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => ChatPage(
                              //             currentUserId: myId,
                              //             friendId: searchResult[index]
                              //                 ['idUser'],
                              //             friendName: searchResult[index]
                              //                 ['name'],
                              //             friendDescription: searchResult[index]
                              //                 ['description'],
                              //             friendImage: searchResult[index]
                              //                 ['urlAvatar'])));
                            //},
                            //icon: Icon(Icons.message)),
                      );
                    }))
          else if (isLoading == true)
            Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
