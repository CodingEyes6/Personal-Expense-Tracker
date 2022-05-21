import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {

  // block landsace mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  // );
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: Colors.purple),

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
        )),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
              button:
                  const TextStyle(color: Colors.white, fontFamily: 'QuickSand'),
            ),
      ),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: "t1",
        title: "New Shoes",
        amount: 25,
        date: DateTime.now().subtract(const Duration(days: 1))),
    // Transaction(
    //     id: "t2", title: "Weekly Groceries", amount: 90, date: DateTime.now()),
  ];
  void _addTransaction(String title, double amount, DateTime date) {
    setState(() {
      Transaction tx = Transaction(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          date: date);
      _userTransactions.add(tx);
    });
  }
bool _showChart = false;
  void deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {

 final isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
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
    );
final txListCode =  Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.6,
              child: TransactionList(
                transactions: _userTransactions,
                deleteTransaction: deleteTransaction,
              ),
            );
    return Scaffold(
      // backgroundColor: Colors.green,

      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(isLandScape)
                const Text('Show chart'),
                if(isLandScape) Switch(value: _showChart, onChanged: (value){
                  setState(() {
                    _showChart = value;
                  });
                })
              ],
            ),
            if(!isLandScape) Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.4,
              child: Chart(_recentTransaction),
            ),
            if(!isLandScape) txListCode,
          if(isLandScape) _showChart ? Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: Chart(_recentTransaction),
            ) : txListCode
           
          ],
        ),
      ),
      floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
                onPressed: () => _startAddNewTransaction(context),
                child: const Icon(Icons.add),
              )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
