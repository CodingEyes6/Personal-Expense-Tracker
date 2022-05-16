import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionList({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return (transactions.length > 0)
        ? Container(
            height: 200,
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return transactionCard(
                    title: transactions[index].title,
                    amount: transactions[index].amount,
                    date: transactions[index].date,
                    context: context);
              },
              // children: transactions.map((tx) {
              //   return transactionCard(
              //       title: tx.title, amount: tx.amount, date: tx.date);
              // }).toList(),
              itemCount: transactions.length,
            ),
          )
        : Column(children: [
            Text(
              "We have no transactions yet",
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 15.0,),
            Container(
              child: Image.asset(
                "assets/images/waiting.png",
                fit: BoxFit.cover,
              ),
              height: 300,
            ),
          ]);
  }

  //  Widget userTransactionsList() {
  //   return SingleChildScrollView(
  //     child: Container(
  //       height: 270,
  //       child: Card(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: transactions.map((tx) {
  //             return transactionCard(
  //                 title: tx.title, amount: tx.amount, date: tx.date);
  //           }).toList(),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget transactionCard(
      {required String title,
      required double amount,
      required DateTime date,
      required BuildContext context}) {
    return Card(
      margin: const EdgeInsets.all(
        5.0,
      ),
      child: Row(
        children: [
          showAmount(amount, context),
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
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget showAmount(double amount, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 10,
        top: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(
        10.0,
      ),
      child: Text(
        "\$ ${amount.toStringAsFixed(2)}",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.purple,
        ),
      ),
    );
  }
}
