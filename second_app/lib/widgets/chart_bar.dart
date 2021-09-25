import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingamount;
  final double spendingPctotal;

  const ChartBar(this.label, this.spendingamount, this.spendingPctotal);

  @override
  Widget build(BuildContext context) {
        print('build() chartbar');
    return LayoutBuilder(builder: (ctx,constraints){
      return Column(
      children: <Widget>[
        Container(
          height:  constraints.maxHeight * 0.115,
          child: FittedBox(
            child: Text('Rs${spendingamount.toStringAsFixed(0)}')
            ),
        ),
        SizedBox(
          height:  constraints.maxHeight * 0.05,
        ),
        Container(
          height: constraints.maxHeight * 0.5,
          width: 10,
          child: Stack(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              heightFactor: spendingPctotal,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
          ]),
        ),
        SizedBox(
          height:  constraints.maxHeight * 0.05,
        ),
        FittedBox(child: Text(label)),
      ],
    );
    }); 
  }
}
