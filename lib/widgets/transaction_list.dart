import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  const TransactionList(
      {required this.transactions, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return (transactions.isNotEmpty)
        ? SizedBox(
            
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text(
                            transactions[index].amount.toStringAsFixed(2),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deleteTransaction(transactions[index].id),
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
                // children: transactions.map((tx) {
                //   return transactionCard(
                //       title: tx.title, amount: tx.amount, date: tx.date);
                // }).toList(),
              },
              itemCount: transactions.length,
            ),
          )
        : LayoutBuilder(builder: (ctx,constarints){
          return   Column(children: [
              Container(
                height: constarints.maxHeight * 0.20,
                child: Text(
                  "We have no transactions yet",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
               SizedBox(
                height: constarints.maxHeight * 0.05,
              ),
              SizedBox(
                child: Image.asset(
                  "assets/images/waiting.png",
                  fit: BoxFit.cover,
                ),
                height: constarints.maxHeight * 0.45,
              ),
            ]);
        });
      
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
    print(amount.toStringAsFixed(0));
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
