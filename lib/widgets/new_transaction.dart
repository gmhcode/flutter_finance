import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance/widgets/adaptive_button.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction({this.addTx}) {
    print('Contructor NewTransaction Widget');
  }

  @override
  _NewTransactionState createState() {
    print('createState() NewTransaction');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  _NewTransactionState() {
    print('Constructor NewTransaction State');
  }

  @override
  void initState() {
    //viewDidLoad
    super.initState();
    print('initState()');
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    //didLayoutSubviews
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    //viewDidDisappear
    print('dispose()');
    super.dispose();
  }

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      selectedDate,
    );

    //dismisses the drawerView
    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            //THIS TELLS US HOW MUCH SPACE THE KEYBOARD IS TAKING UP
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child:
              //  ListView(children: [
              Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                // onChanged: (value) {
                //   titleInput = value;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => submitData(),
                // onChanged: (value) {
                //   amountInput = value;
                // },
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(selectedDate == null
                          ? "No Date Chosen"
                          : "Picked Date: ${DateFormat.yMd().format(selectedDate)}"),
                    ),
                    AdaptiveFlatButton(
                      text: 'Choose Date',
                      handler: presentDatePicker,
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: submitData,
                child: Text(
                  " AddTransaction",
                ),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
              )
            ],
          ),
          // ]),
        ),
      )
    ]);
  }
}
