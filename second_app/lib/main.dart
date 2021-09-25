import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:second_app/widgets/chart.dart';
import 'package:second_app/widgets/new_transaction.dart';
import 'package:second_app/widgets/transaction_list.dart';
import './models/transactions.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light()
              .textTheme
              .copyWith(button: TextStyle(color: Colors.white))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  void _addNewtransaction(
      String txtitle, double txamount, DateTime pickeddate) {
    final newTX = Transaction(
      title: txtitle,
      amount: txamount,
      date: pickeddate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTX);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void startAddNewTransaction(BuildContext ctX) {
    showModalBottomSheet(
        context: ctX,
        builder: (bCtx) {
          return GestureDetector(
            child: NewTransaction(_addNewtransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  Widget _buildAppbar() {
    return AppBar(
      title: Text('Flutter App'),
      actions: <Widget>[
        IconButton(
            onPressed: () => startAddNewTransaction(context),
            icon: Icon(Icons.add))
      ],
    );
  }

  List<Widget> _buildLandscapeContent(AppBar appBar, Widget txListwidget) {
    return [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Text('show chart'),
        Switch(
          value: _showchart,
          onChanged: (val) {
            setState(() {
              _showchart = val;
            });
          },
        ),
      ]),
      _showchart
          ? Container(
              child: Chart(_recentTransaction),
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.9)
          : txListwidget,
    ];
  }

  List<Widget> _buildPortraitContent(AppBar appBar, Widget txListwidget) {
    return [
      Container(
        child: Chart(_recentTransaction),
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.3,
      ),
      txListwidget
    ];
  }

  bool _showchart = false;

  @override
  Widget build(BuildContext context) {
    print('build() homepage');
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = _buildAppbar();
    final txwidget = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));
    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (isLandscape)  ..._buildLandscapeContent(appBar, txwidget),
            if (!isLandscape) ..._buildPortraitContent(appBar, txwidget),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => startAddNewTransaction(context),
        ));
  }
}
