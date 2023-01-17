import 'package:flutter/material.dart';
import 'package:personal_expenses/model/transaction.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/ChartContent.dart';

class Chart extends StatefulWidget {
  final List<Transactions> recentTransactions;
  final List<Transactions> monthlyTransactions;
  Chart(this.recentTransactions,this.monthlyTransactions);


  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  int get totalMonthlyTransact {

    return groupedMonthlyTransactionValues.fold(0, (sum, element) {
      return sum +
          (element['creditValue'] as int) +
          (element['debitValue'] as int);
    });
  }
  int get totalTransact {

    return groupedTransactionValues.fold(0, (sum, element) {
      return sum +
          (element['creditValue'] as int) +
          (element['debitValue'] as int);
    });
  }
  List<Map<String, Object>> get groupedMonthlyTransactionValues {
    return List.generate(28, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalValue = 0;
      var creditValue = 0;
      var debitValue = 0;

      for (var i = 0; i < widget.monthlyTransactions.length; i++) {
        if (widget.monthlyTransactions[i].dateTime.day == weekDay.day &&
            widget.monthlyTransactions[i].dateTime.month == weekDay.month &&
            widget.monthlyTransactions[i].dateTime.year == weekDay.year ) {
          totalValue += widget.monthlyTransactions[i].amount;
          if (widget.monthlyTransactions[i].amount >= 0)
            creditValue += widget.monthlyTransactions[i].amount;
          else if (widget.monthlyTransactions[i].amount < 0)
            debitValue += widget.monthlyTransactions[i].amount;
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
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalValue = 0;
      var creditValue = 0;
      var debitValue = 0;

      for (var i = 0; i < widget.recentTransactions.length; i++) {
        if (widget.recentTransactions[i].dateTime.day == weekDay.day &&
            widget.recentTransactions[i].dateTime.month == weekDay.month &&
            widget.recentTransactions[i].dateTime.year == weekDay.year
            ) {
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
          child: ChartContent(totalTransact,totalMonthlyTransact),
        ),
      ),
    );
  }
}
