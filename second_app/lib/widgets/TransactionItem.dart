import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem(
      {Key key, @required this.deletetransaction, this.transaction})
      : super(key: key);

  final Transaction transaction;
  final Function deletetransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  Color _bgColor ;
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.blue,
      Colors.purple,
      Colors.green
    ];
    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      children: <Widget>[
        Container(
          height: 75,
          width: 85,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
              color: _bgColor,
              shape: BoxShape.circle,
              border:
                  Border.all(width: 2, color: _bgColor)),
          padding: EdgeInsets.all(10),
          child: FittedBox(
            child: Text(
              'RS ${widget.transaction.amount.toStringAsFixed(2)}',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                padding: EdgeInsets.all(0),
                child: Text(
                  widget.transaction.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16),
                ),
              ),
              Text(
                DateFormat('dd/MM/yyyy').format(widget.transaction.date),
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                textColor: Colors.red,
                label: const Text('Delete'),
                onPressed: () =>
                    widget.deletetransaction(widget.transaction.id),
              )
            : FlatButton(
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () =>
                    widget.deletetransaction(widget.transaction.id),
              ),
      ],
    ));
  }
}
