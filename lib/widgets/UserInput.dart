import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum typeOfTransact { credit, debit }

class UserInput extends StatefulWidget {
  final Function addtransact;

  UserInput(this.addtransact);
  @override
  State<StatefulWidget> createState() {
    return UserInputState(addtransact);
  }
}

class UserInputState extends State<UserInput> {
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
  UserInputState(this.addtransactChild);
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 420,
      padding: EdgeInsets.all(10),
      child: Card(

          elevation: 0,
          child: Column(

//           crossAxisAlignment: CrossAxisAlignment.end,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 4, 0, 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      height: 1.0,
                      color: Colors.black,
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                    )),
                    Text(
                      'New Transaction',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                        child: Container(
                      height: 1.0,
                      color: Colors.black,
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                    )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Transaction Name',
                  ),
                  controller: nameController,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                  ),
                  controller: amountController,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    DateFormat.yMMMd().format(selectedDate),
                    style: TextStyle(fontSize: 18),
                  ),
                  ElevatedButton(
                    onPressed: showCalender,
                    child: Text(
                      "Choose Date",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Type:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Flexible(
                    child: ListTile(
                      horizontalTitleGap: 0,
                      title: Text(
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
                      title: Text(
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
                          int.parse(amountController.text), selectedDate);}
                    else if(type == typeOfTransact.debit){
                      if(int.parse(amountController.text)>0)
                      this.addtransactChild(nameController.text,
                          -(int.parse(amountController.text)), selectedDate);
                      else if(int.parse(amountController.text)<0){
                        this.addtransactChild(nameController.text,
                           (int.parse(amountController.text)), selectedDate);
                      }
                    }
                    }
                  } catch (e) {
                    print(e);
                  }
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Text(
                    'ADD TRANSACTION',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                style: TextButton.styleFrom(primary: Colors.purple),
              )
            ],
          )),
    );
  }
}
