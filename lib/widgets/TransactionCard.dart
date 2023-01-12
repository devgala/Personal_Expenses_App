import 'package:flutter/material.dart';
import 'package:personal_expenses/model/transaction.dart';
import 'package:intl/intl.dart';

Widget displayText(int amount) {
  TextStyle credit = const TextStyle(
      fontSize: 25, fontWeight: FontWeight.bold, color: Colors.green);
  TextStyle debit = const TextStyle(
      fontSize: 25, fontWeight: FontWeight.bold, color: Colors.redAccent);
  if (amount > 0) {
    return FittedBox(
        child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text("\u{20B9}$amount", style: credit),
    ));
  } else {
    return FittedBox(
        child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        "-\u{20B9}${amount.abs()}",
        style: debit,
      ),
    ));
  }
}

class TransactionCard extends StatelessWidget {
  int index=-1;
  Function delete =(){};
  String name = "NAME";
  String dateTime = '';
  DateFormat df = DateFormat("yyyy-MM-dd HH:mm");
  int amount = 0;
  TransactionCard(Transactions transaction,int index,Function delete) {
    this.name = transaction.name;
    this.amount = transaction.amount;
    this.dateTime = DateFormat.yMMMd().format(transaction.dateTime);
    this.index=index;
    this.delete=delete;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
      child: Card(
        elevation: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(onPressed: (){
              delete(index);
              print('deleted');
            }, icon: const Icon(Icons.delete,color: Colors.red,)),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  Text(
                    dateTime.toString(),
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
                child: displayText(amount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
