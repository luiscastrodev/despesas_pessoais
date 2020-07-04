import 'dart:math';

import 'package:despesas_pessoais/components/chart.dart';
import 'package:despesas_pessoais/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/transaction_list.dart';
import 'models/transaction.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
     // DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: TextTheme().copyWith(
          headline6: ThemeData.light().textTheme.headline6,
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                ),
                button: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transations = <Transaction>[
    new Transaction(
        id: 'k1',
        title: 'Cartão de credito',
        value: 9.90,
        date: DateTime.now()),
    new Transaction(
        id: 'k2',
        title: 'Cartão de credito',
        value: 9.90,
        date: DateTime.now()),
    new Transaction(
        id: 'k3',
        title: 'Cartão de credito',
        value: 9.90,
        date: DateTime.now()),
    new Transaction(
        id: 'k4',
        title: 'Cartão de credito',
        value: 9.90,
        date: DateTime.now()),
    new Transaction(
        id: 'k5',
        title: 'Cartão de credito',
        value: 9.90,
        date: DateTime.now()),
    new Transaction(
        id: 'k6',
        title: 'Cartão de credito',
        value: 9.90,
        date: DateTime.now()),
    new Transaction(
        id: 'k7',
        title: 'Cartão de credito',
        value: 9.90,
        date: DateTime.now()),
  ];

  bool _showChart = false;

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  List<Transaction> get _recenteTransactions {
    return _transations.where((tr) {
    return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
   }).toList();

  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble.toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transations.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transations.removeWhere((tr) {
        return tr.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    bool isLandascape = MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          color: Colors.white,
          onPressed: () => _openTransactionFormModal(context),
        ),
        if(isLandascape)
        IconButton(
          icon: Icon(_showChart ? Icons.list : Icons.pie_chart),
          color: Colors.white,
          onPressed: () {
            setState(() {
                _showChart = !_showChart;
            });
          },
        ),
      ],
      title: Text(
        'Despesas Pessoais',
        style: TextStyle(
          fontSize: 15 * MediaQuery.of(context).textScaleFactor,
        ),
      ),
    );

    final availableHeigth = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if(isLandascape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Exibir Grafico'),
                Switch(
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                ),
              ],
            ),
            if(_showChart || !isLandascape) 
            Container(
              height: availableHeigth * (isLandascape?0.7 : 0.30),
              child: Chart(
                _recenteTransactions,
              ),
            ),
            if(!_showChart || !isLandascape)
            Column(
              children: <Widget>[
                //TransactionForm(_addTransaction),
                Container(
                  height: availableHeigth * 0.70,
                  child: TransacionList(
                    _transations,
                    _deleteTransaction,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _openTransactionFormModal(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
