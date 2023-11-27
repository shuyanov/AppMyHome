import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/Payment/Data/expences.dart';
import '/Payment/paymentDetalPage.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: expences.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PaymentDetalPage(expence: expences[index])));
                },
          child: Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            expences[index].name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                              expences[index].sumCost.toStringAsFixed(2) +
                                  " руб.",
                              style: TextStyle(
                                fontSize: 18,
                              ))
                        ],
                      ),
                    ),
                    // SizedBox(height: 8,),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                color:
                                    expences[index].status.contains("Оплачено")
                                        ? Colors.green
                                        : expences[index]
                                                .status
                                                .contains("Не оплачено")
                                            ? Colors.red
                                            : Colors.orange,
                                child: Text(expences[index].status,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14))),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(DateFormat('dd.MM.yyyy')
                                .format(expences[index].dateTime)
                                .toString()),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      
    );
  }
}
