import 'package:flutter/material.dart';
import 'package:flutter_finance/widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

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

class MyHomePage extends StatelessWidget {
//..######..##.....##....###....########..########
//.##....##.##.....##...##.##...##.....##....##...
//.##.......##.....##..##...##..##.....##....##...
//.##.......#########.##.....##.########.....##...
//.##.......##.....##.#########.##...##......##...
//.##....##.##.....##.##.....##.##....##.....##...
//..######..##.....##.##.....##.##.....##....##...

  // String titleInput;
  // String amountInput;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter App"),
      ),
      body: Column(
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
          NewTransaction(),
          TransactionList()
        ],
      ),
    );
  }
}
