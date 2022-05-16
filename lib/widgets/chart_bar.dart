import 'package:flutter/material.dart';


class ChartBar extends StatelessWidget {
  
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar({required this.label,required this.spendingAmount,required this.spendingPctOfTotal});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('\$${spendingAmount.toStringAsFixed(0)}'),
        const SizedBox(height: 4,),
        Container(

          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 1),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                
                
              ),
              FractionallySizedBox()
            ],
          ),
        ),
       Text(label),
      ],
    );
  }




}