import 'package:flutter/material.dart';

enum SingingCharacter { file, eform }

class form extends StatefulWidget {
  const form({super.key});

  @override
  State<form> createState() => _formState();
}


class _formState extends State<form> {
  int? selectedRadioTile;

  @override
  void initState() {
    super.initState();
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SingingCharacter? _character = SingingCharacter.eform;
    return ListView(
          padding: EdgeInsets.all(10),
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "От кого:",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Кому:",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Text("Заявление в виде файла или электронная форма?"),
                  RadioListTile(
                    title: const Text('Файл'),
                    value: 1,
                    groupValue: selectedRadioTile,
                    onChanged: (val) {
                      setSelectedRadioTile(val!);
                    },
                  ),
                  RadioListTile(
                    title: const Text('Электронная форма'),
                    value: 2,
                    groupValue: selectedRadioTile,
                    onChanged: (val) {
                      setSelectedRadioTile(val!);
                    },
                  ),
                ],
              ),
            ),
            selectedRadioTile == 2
                ? Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      minLines: 10,
                      maxLines: 1000,
                      textAlign: TextAlign.justify,
                      decoration: InputDecoration(
                          labelText: "Заявление",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  )
                : Container(),
            // Container(
            //   padding: EdgeInsets.only(bottom: 10),
            //   child: TextFormField(
            //     minLines: 10,
            //     maxLines: 1000,
            //     textAlign: TextAlign.justify,
            //     decoration: InputDecoration(
            //         labelText: "Заявление",
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(10),
            //         )),
            //   ),
            // ),
            ElevatedButton(
                onPressed: () {},
                child: Container(
                  width: size.width,
                  child: Text(
                    "Отправить",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                )),
          ],
        
    );
  }


}
