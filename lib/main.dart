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
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> _userTransactions = [
    // Transaction(id: "t1", title: "New Shoes", amount: 25, date: DateTime.now()),
    // Transaction(
    //     id: "t2", title: "Weekly Groceries", amount: 90, date: DateTime.now()),
  ];
  void _addTransaction(String title, double amount) {
     DateTime d = DateTime.now();
    

    setState(() {
      Transaction tx = Transaction(
          id: "1", title: title, amount: amount, date: DateTime.now());
      _userTransactions.add(tx);
    });
  }

  List<Transaction> get _recentTransaction{
    return _userTransactions.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
   
  }

  void _startAddNewTransaction(BuildContext ctx) {
    print("calling");
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange)
            .copyWith(secondary: Colors.amber),
            
            // fontFamily: 'Quicksand',
            appBarTheme: const AppBarTheme(
              // titleTextStyle: TextStyle(
              //   fontFamily: 'OpenSans',
              //   fontWeight: FontWeight.bold,
              //   fontSize: 40,
                
              // ),
              // toolbarTextStyle: TextStyle(
              //   fontFamily: 'OpenSans',
              //   fontWeight: FontWeight.bold
              // )
             titleTextStyle: TextStyle(
               fontFamily: "OpenSans",
               fontWeight: FontWeight.bold,
               fontSize: 20.0,
             )
            ),
            textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16.0,
                fontWeight: FontWeight.bold
              ),
              button: const TextStyle(
                color: Colors.white
              ),
            ),
      ),
      home: Scaffold(
        // backgroundColor: Colors.green,

        appBar: AppBar(
          actions: [
            // IconButton(
            //     onPressed: () => _startAddNewTransaction(context),
            //     icon: const Icon(Icons.add)),
            Builder(
              builder: (context) => IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: const Icon(Icons.add),
              ),
            )
          ],
          title: const Text(
            "Personal Expense App",
            // style: TextStyle(
            //   fontFamily: 'OpenSans',
            //   fontWeight: FontWeight.w700
            // ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Chart(_recentTransaction),
              TransactionList(transactions: _userTransactions)
            ],
          ),
        ),
        floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
                  onPressed: () => _startAddNewTransaction(context),
                  child: const Icon(Icons.add),
                )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  // Widget showChart() {
  //   return Container(
  //     width: double.infinity,
  //     child: const Card(
  //       elevation: 50.0,
  //       color: Colors.blue,
  //       margin: EdgeInsets.all(5.0),
  //       child: Text(
  //         "Chart",
  //         textAlign: TextAlign.center,
  //       ),
  //     ),
  //   );
  // }
}
