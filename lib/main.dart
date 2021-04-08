import 'package:flutter/material.dart';
import 'package:flutter_finance/widgets/new_transaction.dart';
import 'package:flutter_finance/widgets/transaction_list.dart';

import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MaterialApp(
        title: 'Flutter Demo Home Page',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
//..######..##.....##....###....########..########
//.##....##.##.....##...##.##...##.....##....##...
//.##.......##.....##..##...##..##.....##....##...
//.##.......#########.##.....##.########.....##...
//.##.......##.....##.#########.##...##......##...
//.##....##.##.....##.##.....##.##....##.....##...
//..######..##.....##.##.....##.##.....##....##...

  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: "t1",
      title: "new shoes",
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Groceries",
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bctx) {
        return NewTransaction(addTx: _addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter App"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Card(
                  color: Colors.blue,
                  child: Text("Chart"),
                  elevation: 5,
                ),
              ),
            ),
            TransactionList(transactions: _userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
    );
  }
}
