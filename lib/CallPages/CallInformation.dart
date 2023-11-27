import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Styles/Colors.dart';

class CallInformation extends StatefulWidget {
  final String city;
  final String name;
  final String description;
  final String street;
  final List<dynamic> tel;
  const CallInformation(
      {required this.city,
      required this.name,
      required this.description,
      required this.street,
      required this.tel,
      super.key});

  @override
  State<CallInformation> createState() => _CallInformationState();
}

class _CallInformationState extends State<CallInformation> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                // bottomLeft: Radius.circular(10),
                // bottomRight: Radius.circular(10)
                )),
        backgroundColor: purpleColor,
        // title: Text("Информация о службе"),
      ),
      body: Container(
        child: Column(children: [
          Container(
            padding: EdgeInsets.only(
              bottom: size.height * 0.05,
            ),
            color: purpleColor,
            alignment: Alignment.center,
            width: size.width,
            height: size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: size.width,
            //height: size.height * 0.3,
            child: Text(
              widget.description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: Container(              
              height: size.height * 0.3,
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.tel.length,
                  itemBuilder: (context, index) => ListTile(
                        title: Text(widget.tel[index],
                            style: TextStyle(fontSize: 18)),
                        onTap: () async {
                          launchUrl(Uri.parse('tel:${widget.tel[index]}'));
                        },
                        trailing: ElevatedButton(
                          child: Icon(Icons.call, color: Colors.white,),
                          onPressed: () async {
                            launchUrl(Uri.parse('tel:${widget.tel[index]}'));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: purpleColor,
                            shape: const CircleBorder(),
                          ),
                        ),
                      )),
            ),
          )
        ]),
      ),
    );
  }
}
