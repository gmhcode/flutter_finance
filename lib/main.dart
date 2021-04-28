import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finance/widgets/chart.dart';
import 'package:flutter_finance/widgets/new_transaction.dart';
import 'package:flutter_finance/widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  // //force portrait mode VV
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // //force portrait mode ^^
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didUpdateWidget(covariant MyApp oldWidget) {
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: "OpensSans",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        ),
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  bool showChart = false;
  @override
  void initState() {
    print('init state');
    //WHEN THIS WIDGET LOADS, CALL THE didChangeAppLifecycleState BY ADDING THIS OBSERVER
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  //Whenever the app enters background.. etc
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('🥑 cycle changed to $state');
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    //When this class is disposed we remove the didChangeAppLifecycleState observer
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: "t1",
    //   title: "new shoes",
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "t2",
    //   title: "Groceries",
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

//....###....########..########.....##....##.########.##......##....########.########.
//...##.##...##.....##.##.....##....###...##.##.......##..##..##.......##....##.....##
//..##...##..##.....##.##.....##....####..##.##.......##..##..##.......##....##.....##
//.##.....##.##.....##.##.....##....##.##.##.######...##..##..##.......##....########.
//.#########.##.....##.##.....##....##..####.##.......##..##..##.......##....##...##..
//.##.....##.##.....##.##.....##....##...###.##.......##..##..##.......##....##....##.
//.##.....##.########..########.....##....##.########..###..###........##....##.....##
  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: chosenDate);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void deleteNewTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  ///SHOWS THE MODAL SHEET
  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bctx) {
        return GestureDetector(
          child: NewTransaction(addTx: _addNewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

//.########..##.....##.####.##.......########.....##..........###....##....##.########...######...######.....###....########..########
//.##.....##.##.....##..##..##.......##.....##....##.........##.##...###...##.##.....##.##....##.##....##...##.##...##.....##.##......
//.##.....##.##.....##..##..##.......##.....##....##........##...##..####..##.##.....##.##.......##........##...##..##.....##.##......
//.########..##.....##..##..##.......##.....##....##.......##.....##.##.##.##.##.....##..######..##.......##.....##.########..######..
//.##.....##.##.....##..##..##.......##.....##....##.......#########.##..####.##.....##.......##.##.......#########.##........##......
//.##.....##.##.....##..##..##.......##.....##....##.......##.....##.##...###.##.....##.##....##.##....##.##.....##.##........##......
//.########...#######..####.########.########.....########.##.....##.##....##.########...######...######..##.....##.##........########
  List<Widget> _buildLandscapeContent(
    MediaQueryData mediaQuery,
    PreferredSizeWidget appBar,
    Widget txListWidget,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Show Chart",
            style: Theme.of(context).textTheme.headline6,
          ),
          Switch.adaptive(
            value: showChart,
            onChanged: (val) {
              setState(() {
                showChart = val;
              });
            },
          ),
        ],
      ),
      showChart
          ? Container(

              ///height of the device
              height: (mediaQuery.size.height -
                      //minus the app bar
                      appBar.preferredSize.height -
                      //minus the status bar
                      mediaQuery.padding.top) *
                  //times 40% of the remaining height
                  0.7,
              child: Chart(_recentTransactions))
          : txListWidget
    ];
  }

//.########..##.....##.####.##.......########..........########...#######..########..########.########.....###....####.########
//.##.....##.##.....##..##..##.......##.....##.........##.....##.##.....##.##.....##....##....##.....##...##.##....##.....##...
//.##.....##.##.....##..##..##.......##.....##.........##.....##.##.....##.##.....##....##....##.....##..##...##...##.....##...
//.########..##.....##..##..##.......##.....##.........########..##.....##.########.....##....########..##.....##..##.....##...
//.##.....##.##.....##..##..##.......##.....##.........##........##.....##.##...##......##....##...##...#########..##.....##...
//.##.....##.##.....##..##..##.......##.....##.........##........##.....##.##....##.....##....##....##..##.....##..##.....##...
//.########...#######..####.########.########..#######.##.........#######..##.....##....##....##.....##.##.....##.####....##...
  List<Widget> _buildPortraitContent(
    MediaQueryData mediaQuery,
    PreferredSizeWidget appBar,
    Widget txListWidget,
  ) {
    return [
      Container(
        ///height of the device
        height: (mediaQuery.size.height -
                //minus the app bar
                appBar.preferredSize.height -
                //minus the status bar
                mediaQuery.padding.top) *
            //times 40% of the remaining height
            0.3,
        child: Chart(_recentTransactions),
      ),
      txListWidget
    ];
  }

  @override
  // .########..##.....##.####.##.......########.
  // .##.....##.##.....##..##..##.......##.....##
  // .##.....##.##.....##..##..##.......##.....##
  // .########..##.....##..##..##.......##.....##
  // .##.....##.##.....##..##..##.......##.....##
  // .##.....##.##.....##..##..##.......##.....##
  // .########...#######..####.########.########.
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Personal Expenses"),
            trailing: Row(
              //HERE WE ARE SHRINKING THE ROW SO WE CAN SEE THE "PERSONAL EXPENSES TEXT"
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text("Personal Expenses"),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => startAddNewTransaction(context),
              )
            ],
          );

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(
        transactions: _userTransactions,
        deleteTx: deleteNewTransaction,
      ),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              ..._buildLandscapeContent(mediaQuery, appBar, txListWidget),
            if (!isLandscape)
              ..._buildPortraitContent(mediaQuery, appBar, txListWidget),
            // if (!isLandscape) ,
            // if (isLandscape),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => startAddNewTransaction(context),
                  ),
          );
  }
}
