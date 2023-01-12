import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final int amount;
  final double percent;
  final int credit;
  final int debit;
  ChartBar(this.label, this.amount, this.percent,this.credit,this.debit);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('+$credit'),
        const SizedBox(
          height: 5,
        ),
        Container(
            height: 120,
            width: 12,
            child: Stack(
              children: <Widget>[
                (credit == 0 && debit == 0) ? Container(
                    decoration:  BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),

                    )

                ) : Container(
                    decoration:  BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),

                    )

                ),
                (credit == 0 && debit == 0) ? Container(
                  child :  null
                ) :FractionallySizedBox(
                  heightFactor: (credit / (credit + debit.abs())) as double ,child:Container(
                  decoration: BoxDecoration(color : Colors.lightGreenAccent,borderRadius: BorderRadius.circular(10),),

                ),
                ),

              ],
            ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text('$debit'),
        const SizedBox(
          height: 5,
        ),

        Text(label),
      ],
    );
  }
}
