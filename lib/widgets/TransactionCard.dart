import 'package:flutter/material.dart';
import 'package:personal_expenses/model/transaction.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/EditTransact.dart';


Widget displayText(int amount) {
  TextStyle credit = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green,fontFamily: 'Roboto');
  TextStyle debit = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.redAccent,fontFamily: 'Roboto',fontStyle: FontStyle.italic);
  if (amount > 0) {
    return FittedBox(
      fit : BoxFit.fitWidth,
        child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text("\u{20B9}$amount", style: credit),
    ));
  } else {
    return FittedBox(
        fit : BoxFit.fitWidth,
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
  Function editTransact;
  String name = "NAME";
  String dateTime = '';
  DateFormat df = DateFormat("yyyy-MM-dd HH:mm");
  int amount = 0;
  int id =-1;
  TransactionCard(Transactions transaction,int index,Function delete,this.editTransact) {
    this.name = transaction.name;
    this.amount = transaction.amount;
    this.dateTime = DateFormat.yMMMd().format(transaction.dateTime);
    this.index=index;
    this.delete=delete;
    this.id = transaction.id;
  }
  void showInputArea(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
        context: ctx,
        builder: (_) {
          return SingleChildScrollView(

            child: Container(
              padding:
              EdgeInsets.only(bottom: MediaQuery.of(_).viewInsets.bottom),
              child: GestureDetector(
                  onTap: () {},
                  behavior: HitTestBehavior.opaque,
                  child: EditTransact(editTransact: editTransact,amount: amount,name: name,id: id)),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Card(
        elevation: 4,
        child: InkWell(
          onLongPress: (){

            showInputArea(context);
          },
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
                    SizedBox(
                      width: 160,
                      child: Text(
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        name,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                      ),
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
      ),
    );
  }
}
