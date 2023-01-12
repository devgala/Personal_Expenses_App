import 'package:flutter/material.dart';
import 'package:personal_expenses/model/transaction.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/ChartBar.dart';

class Chart extends StatefulWidget {
  final List<Transactions> recentTransactions;
  Chart(this.recentTransactions);


  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  int get totalCredit {

    return groupedTransactionValues.fold(0, (sum, element) {
      return sum +
          (element['creditValue'] as int) +
          (element['debitValue'] as int).abs();
    });
  }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalValue = 0;
      var creditValue = 0;
      var debitValue = 0;

      for (var i = 0; i < widget.recentTransactions.length; i++) {
        if (widget.recentTransactions[i].dateTime.day == weekDay.day &&
            widget.recentTransactions[i].dateTime.month == weekDay.month &&
            widget.recentTransactions[i].dateTime.year == weekDay.year &&
            widget.recentTransactions[i].dateTime.year == DateTime.now().year) {
          totalValue += widget.recentTransactions[i].amount;
          if (widget.recentTransactions[i].amount >= 0)
            creditValue += widget.recentTransactions[i].amount;
          else if (widget.recentTransactions[i].amount < 0)
            debitValue += widget.recentTransactions[i].amount;
        }
      }
      // print(DateFormat.E(weekDay));
     // print(totalValue);

      return {
        'day': DateFormat.E().format(weekDay),
        'totalValue': totalValue,
        'creditValue': creditValue,
        'debitValue': debitValue
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   // print(groupedTransactionValues);
    return Container(

      child: Card(
        elevation: 6,

        // margin: EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: groupedTransactionValues
                .map((data) => Row(
                      children: [
                        ChartBar(
                            data['day'] as String,
                            data['totalValue'] as int,
                            ((data['creditValue'] as int) / totalCredit)
                                as double,
                            data['creditValue'] as int,
                            data['debitValue'] as int),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
