import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum typeOfTransact { credit, debit }

class EditTransact extends StatefulWidget {
  final Function editTransact;
  final String name;
  final int amount;
  final int id;

  EditTransact({required this.editTransact,required this.amount,required this.name,required this.id});
  @override
  State<StatefulWidget> createState() {
    return EditTransactState(editTransact,name,amount,id);
  }
}

class EditTransactState extends State<EditTransact> {

   final String name ;
  final int amount;
  final int id;
  typeOfTransact? type;

  DateTime selectedDate = DateTime.now();
  void showCalender() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      setState(() {
        selectedDate = value;
      });
    });
  }

  final Function addtransactChild;
  EditTransactState(this.addtransactChild,this.name,this.amount,this.id);
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 420,
      padding: const EdgeInsets.all(10),
      child: Card(
          elevation: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.end,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                          height: 1.0,
                          color: Colors.black,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        )),
                    const Text(
                      'Edit Transaction',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                        child: Container(
                          height: 1.0,
                          color: Colors.black,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        )),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: TextFormField(


                  decoration: const InputDecoration(
                    labelText: 'Transaction Name',

                  ),
                  controller: nameController,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                  ),
                  controller: amountController,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    DateFormat.yMMMd().format(selectedDate),
                    style: const TextStyle(fontSize: 18),
                  ),
                  ElevatedButton(
                    onPressed: showCalender,
                    child: const Text(
                      "Choose Date",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Type:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Flexible(
                    child: ListTile(
                      horizontalTitleGap: 0,
                      title: const Text(
                        'Credit',
                        style: TextStyle(fontSize: 17),
                      ),
                      leading: Radio<typeOfTransact>(
                          value: typeOfTransact.credit,
                          groupValue: type,
                          onChanged: (typeOfTransact? value) {
                            setState(() {
                              type = value;
                            });
                          }),
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      horizontalTitleGap: 0,
                      title: const Text(
                        'Debit',
                        style: TextStyle(fontSize: 17),
                      ),
                      leading: Radio<typeOfTransact>(
                          value: typeOfTransact.debit,
                          groupValue: type,
                          onChanged: (typeOfTransact? value) {
                            setState(() {
                              type = value;
                            });
                          }),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  print(nameController.text);
                  print(amountController.text);
                  try {
                    if (nameController.text.toString().trim() != '' &&
                        amountController.text != null){
                      if(type == typeOfTransact.credit){
                        this.addtransactChild(nameController.text,
                            int.parse(amountController.text), id,selectedDate);}
                      else if(type == typeOfTransact.debit){
                        if(int.parse(amountController.text)>0)
                          this.addtransactChild(nameController.text,
                              -(int.parse(amountController.text)), id,selectedDate);
                        else if(int.parse(amountController.text)<0){
                          this.addtransactChild(nameController.text,
                              (int.parse(amountController.text)), id,selectedDate);
                        }
                      }
                    }
                  } catch (e) {
                    print(e);
                  }
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(primary: Colors.purple),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: const Text(
                    'EDIT TRANSACTION',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            ],
          )),
    );
  }
}


