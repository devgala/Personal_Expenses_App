import 'package:flutter/material.dart';

import '../model/transaction.dart';
import '../transaction_helper.dart';
import 'TransactionCard.dart';



class TransactionList extends StatelessWidget{


  List<Transactions> transactionlist;
Function deleteTransaction;
Function editTransact;
TransactionList(this.transactionlist,this.deleteTransaction,this.editTransact);


  @override
  Widget build(BuildContext context) {


    return Container(

      child: ListView.builder(
        itemBuilder: (ctx,index){
          return TransactionCard(transactionlist[transactionlist.length - index-1],transactionlist.length - index-1,deleteTransaction,editTransact);
        },
        itemCount: transactionlist.length,
      ),
    );
  }
}