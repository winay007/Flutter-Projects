import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTX;

  NewTransaction(this.addTX);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime _pickeddate;

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _pickeddate = value;
      });
    });
  }

  void _submitData() {
    if (_amountcontroller == null) {
      return;
    }
    final enteredTitle = _titlecontroller.text;
    final enteredAmount = double.parse(_amountcontroller.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _pickeddate == null) {
      return;
    }
    widget.addTX(_titlecontroller.text, double.parse(_amountcontroller.text),
        _pickeddate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
              padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    //  onChanged: (val) => titleInput=val ,
                    controller: _titlecontroller,
                    onSubmitted: (_) => _submitData(),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    // onChanged: (val) => amountInput=val ,
                    controller: _amountcontroller,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => _submitData(),
                  ),
                  Container(
                      height: 70,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(_pickeddate == null
                                ? 'No date chosen !!'
                                : 'Picked date: ${DateFormat.yMd().format(_pickeddate)}'),
                          ),
                          FlatButton(
                            child: Text(
                              'Choose Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            textColor: Theme.of(context).primaryColor,
                            onPressed: _presentDatePicker,
                          )
                        ],
                      )),
                  RaisedButton(
                    child: Text('Add transaction'),
                    color: Colors.purple,
                    textColor: Colors.white,
                    onPressed: _submitData,
                  )
                ],
              ))),
    );
  }
}
