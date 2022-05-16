import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
class Chart extends StatelessWidget {

final List<Transaction> recentTransactions;

Chart(this.recentTransactions);

List<Map<String,Object>> get groupedTransactionValues{



return List.generate(7, (index) {

final weekDay = DateTime.now().subtract(Duration(days: index));
var amount = 0.0;
for(var i=0;i<recentTransactions.length;i++){
  if(recentTransactions[i].date.day == weekDay.day){
    if(recentTransactions[i].date.month == weekDay.month){
      if(recentTransactions[i].date.year == weekDay.year){
          amount += recentTransactions[i].amount;
      }
    }
  
  }
}

  return {
   'day' : DateFormat.E().format(weekDay).substring(0,1),
   'amount' : amount,
  };
});
}

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20.0),
      child: Row(
        children: groupedTransactionValues.map((tx) {
          return Text('${tx['day']} : ${tx['amount']}');
        }).toList(),
      ),
    );
  }
}