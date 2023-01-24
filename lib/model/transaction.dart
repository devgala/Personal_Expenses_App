import 'package:flutter/material.dart';

class Transactions {
  final  int  id   ;
   String name;

   int amount;
   DateTime dateTime;
  Transactions(
      {required this.id,required this.name, required this.amount, required this.dateTime});


  @override
  String toString() {

    return 'Transaction{id: $id, name: $name, amount: $amount}';
  }


   Map<String, dynamic> toMap() {
    return {

      'name': name,
      'amount': amount,
      'datetime' : dateTime.millisecondsSinceEpoch,
    };
  }
}
