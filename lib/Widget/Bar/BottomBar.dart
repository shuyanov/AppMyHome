// import 'package:flutter/material.dart';
// import 'Profile.dart';
//
// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({super.key});
//
//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }
//
// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   int _selectedIndex =0;
//   static const TextStyle optionStyle = TextStyle(fontSize: 35, fontWeight: FontWeight.bold);
//   static const List<Widget> _WidgetOption = <Widget>[
//     Text(
//       'Index 0: Home',
//       style: optionStyle,
//     ),
//     Text(
//       'Index 1: Чаты',
//       style: optionStyle,
//     ),
//     ProfilePage(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueAccent,
//         leading: IconButton(
//           icon: const Icon(Icons.person_pin),
//           tooltip: 'Профиль',
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute<void>(
//                 builder: (BuildContext){
//                   return Scaffold(
//                     appBar: AppBar(
//                       title: const Text('Профиль'),
//                       backgroundColor: Colors.blueAccent,//Color.fromARGB(255, 210, 227, 246)
//                     ),
//                     body: SafeArea(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Column(
//                             children: [
//                               Padding(padding: EdgeInsets.only(top: 30)),
//                               CircleAvatar(
//                                 backgroundImage: AssetImage('image/llll.jpg'),
//                                 //backgroundColor: Colors.white,
//                                 radius: 60,
//                               ),
//                               Text('Имя пользователя', style: TextStyle(fontSize: 32)),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 }
//             ));
//           },
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.add_alert_rounded),
//             tooltip: 'Уведомления',
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute<void>(
//                 builder: (BuildContext){
//                   return Scaffold(
//                     appBar: AppBar(
//                       title: const Text('Уведомления'),
//                       backgroundColor: Colors.blueAccent,
//                     ),
//                   );
//                 }
//               ));
//             },
//           )
//         ],
//       ),
//       body: Center(
//         child: _WidgetOption.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: <BottomNavigationBarItem> [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_filled),
//             label: 'Главная',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat),
//             label: 'Чаты',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.monetization_on),
//             label: 'Профиль',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.black,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
