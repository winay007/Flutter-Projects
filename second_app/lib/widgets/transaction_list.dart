import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';
import './TransactionItem.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletetransaction;
  TransactionList(this.transactions, this.deletetransaction);

  @override
  Widget build(BuildContext context) {
    print('build() transaction list');
    return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: ListView(children: [
          transactions.isEmpty
              ? Column(
                  children: <Widget>[
                    Text(
                      'No Transaction added yet!!',
                      style: Theme.of(context).textTheme.title,
                    ),
                    Image.asset(
                      'assets/images/image/z.jpg',
                      fit: BoxFit.cover,
                    ),
                  ],
                )
              : Column(
                  children: transactions.map((tx) {
                    return TransactionItem(deletetransaction: deletetransaction,transaction: tx,key: ValueKey(tx.id) ,);
                  }).toList(),
                )
        ]));
  }
}

