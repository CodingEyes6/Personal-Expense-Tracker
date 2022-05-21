import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTransaction;

  NewTransaction(this._addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

   DateTime? _dateSelected;

  void submitData() {
if(amountController.text.isEmpty){
  return;
}

    final titleEntered = titleController.text;
    final amountEntered = double.parse(amountController.text);


    if (titleEntered.isEmpty || amountEntered <= 0 || _dateSelected == null) {
      return;
    }

    widget._addTransaction(
        titleController.text, double.parse(amountController.text),_dateSelected);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(
        2019,
      ),
      lastDate: DateTime.now(),
    ).then((datePicked) {
      if(datePicked == null){
        return;
      }
      else{
        setState(() {
           _dateSelected = datePicked;
        });
       
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
            Container(
              height: 70,
              child: Row(
                children: [
                   Expanded(child: Text(_dateSelected == null ? 'No Date Chosen!': 'Picked Date : ${DateFormat.yMd().format(_dateSelected!)}')),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: submitData,
              child: const Text("Add Transaction"),
            )
          ],
        ),
      ),
    );
  }
}
