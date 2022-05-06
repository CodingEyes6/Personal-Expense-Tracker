// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   var names = [
//     "usama",
//     "Ali",
//     "Imran",
//     "Chedda Ji",
//     "Balveer",
//     "Alladin",
//     "KD Pathak",
//     "Captain Jack Sparrow"
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text("My App"),
//         ),
//         body: Container(
//         //  height: 300,
//           child: Card(
//             margin: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 20.0,),
//             color: Colors.blue,
//             child: Container(
//               padding: EdgeInsets.only(
//                 left: 20.0,
//                 top: 20.0,
//               ),
//               child: Column(
//                 //mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ...names.map((e) {
//                     return Text(e);
//                   }),
//                   Container(
//                     width: 200,
//                     height: 200,
//                     margin: EdgeInsets.only(top: 10.0,right: 10.0,),
//                     alignment: Alignment.center,
//                     color: Colors.amberAccent,
//                     child: Text("Usama Sarfraz"),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// import 'dart:ffi';

import 'package:flutter/material.dart';
import './transaction.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
  DateTime d = DateTime.now();
  print(d);
}

class MyApp extends StatelessWidget {
  List<Transaction> transactions = [
    Transaction(id: "t1", title: "New Shoes", amount: 25, date: DateTime.now()),
    Transaction(
        id: "t2", title: "Weekly Groceries", amount: 90, date: DateTime.now()),
    Transaction(
        id: "t3", title: "Royal Watch", amount: 50, date: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: showAppBar(),
        body: Column(
          //  crossAxisAlignment: CrossAxisAlignment.stretch,
          //    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            showChart(),
            userInputTransaction(),
            userTransactionsList(),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  PreferredSizeWidget? showAppBar() {
    return AppBar(
      title: const Text(
        "Personal Expense App",
      ),
    );
  }

  Widget showChart() {
    return const Card(
      color: Colors.blue,
      margin: EdgeInsets.all(5.0),
      child: Text(
        "Chart2",
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget userTransactionsList() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: transactions.map((tx) {
          return transactionCard(
              title: tx.title, amount: tx.amount, date: tx.date);
        }).toList(),
      ),
    );
  }

  Widget transactionCard(
      {required String title, required double amount, required DateTime date}) {
    return Card(
      margin: const EdgeInsets.all(
        5.0,
      ),
      child: Row(
        children: [
          showAmount(amount),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                DateFormat.yMMMMd().format(date),
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget showAmount(double amount) {
    return Container(
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 10,
        top: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.purple,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(
        10.0,
      ),
      child: Text(
        "\$ $amount",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.purple,
        ),
      ),
    );
  }

  Widget userInputTransaction() {

String titleInput;

    return Card(
      child: Container(
        padding: const EdgeInsets.all(
          10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: "title",
              ),
              onChanged: (title){ 
                titleInput = title;
                print(titleInput);
                },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Amount",
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text("Add Transaction"), 
            )
          ],
        ),
      ),
    );
  }
}
