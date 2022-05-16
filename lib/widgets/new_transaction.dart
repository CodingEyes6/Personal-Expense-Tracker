import 'dart:ffi';

import 'package:flutter/material.dart';


class NewTransaction extends StatefulWidget {
  
  final Function _addTransaction;

 NewTransaction(this._addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
    final titleController = TextEditingController();

final amountController = TextEditingController();

void submitData(){

final titleEntered = titleController.text;
final amountEntered = double.parse(amountController.text);

if(titleEntered.isEmpty || amountEntered <= 0){
  return;
}

widget._addTransaction(titleController.text,double.parse(amountController.text));
Navigator.of(context).pop();
}

  @override
  Widget build(BuildContext context) {

 

    return  Card(
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
              // onChanged: (title){ 
              //   titleInput = title;
              //   print(titleInput);
              //   },
              controller: titleController,
              
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Amount",
                
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
onFieldSubmitted: (_) => submitData(),
            ),
            TextButton(
              onPressed: submitData,
              child: const Text("Add Transaction"), 
              
            )
          ],
        ),
      ),
    );
  }
}