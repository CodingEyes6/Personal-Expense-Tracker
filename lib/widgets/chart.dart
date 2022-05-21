import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var amount = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day) {
          if (recentTransactions[i].date.month == weekDay.month) {
            if (recentTransactions[i].date.year == weekDay.year) {
              amount += recentTransactions[i].amount;
            }
          }
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': amount,
      };
    }).reversed.toList();
  }

  double get maxSpending {
    var value = 0.0;
    value = groupedTransactionValues.fold(0.0, (sum, item) {
      return sum += (item['amount'] as double);
    });
    if (value > 0.0) {
      
      return value;
    }

    return value;
  }

  @override
  Widget build(BuildContext context) {
  
    return Card(
      
      elevation: 6,
      margin: const EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: data['day'] as String,
                spendingAmount: data['amount'] as double,
                spendingPctOfTotal: ((data['amount'] as double ) > 0) ? ((data['amount'] as double) / maxSpending) : 0,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
