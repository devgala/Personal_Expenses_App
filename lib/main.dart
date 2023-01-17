import 'package:flutter/material.dart';
import 'package:personal_expenses/transaction_helper.dart';
import 'package:personal_expenses/widgets/TransactionList.dart';
import 'package:personal_expenses/widgets/UserInput.dart';
import 'package:personal_expenses/widgets/chart.dart';

import 'model/transaction.dart';
import 'widgets/TransactionCard.dart';

TransactionHelper transactionHelper = TransactionHelper();
Future<List<Transactions>>? futureList;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expenses",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Raleway',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    transactionHelper.initializeDatabase().then((value) {
      print("db initialized");
      print(value);
    });
    futureList = transactionHelper.getList();
    super.initState();
  }

  List<Transactions> transactionList = [];

  List<Transactions> get _recentTransactions {
    return transactionList.where((element) {
      return element.dateTime.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }
  List<Transactions> get _recentMonthTransactions {
    return transactionList.where((element) {
      return element.dateTime.isAfter(
        DateTime.now().subtract(
          Duration(days: 28),
        ),
      );
    }).toList();
  }

  void addTransact(String name, int amount, DateTime dt) {
    final Trx = new Transactions(id: 0,name: name, amount: amount, dateTime: dt);
    setState(() {
      transactionList.add(Trx);
    });
    transactionHelper.insertTransaction(Trx);
    futureList = transactionHelper.getList();
    print('added');
  }

  void deleteTransaction(int index) async {
    print(transactionList.elementAt(index).id);

    await transactionHelper.deleteTransaction(transactionList.elementAt(index).id!);
    futureList = transactionHelper.getList();
    setState(()  {

      transactionList.removeAt(index);
    });
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
                  EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
              child: GestureDetector(
                  onTap: () {},
                  behavior: HitTestBehavior.opaque,
                  child: UserInput(addTransact)),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.deepPurple,
      title: const Text("Personal Expenses"),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              showInputArea(context);
            },
            icon: Icon(Icons.add))
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: FutureBuilder<List<Transactions>>(
        future: futureList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            transactionList = snapshot.data!;

            if(transactionList.isNotEmpty){return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        (0.2),s
                    margin: const EdgeInsets.fromLTRB(10, 20, 10, 15),
                    child: Chart(_recentTransactions,_recentMonthTransactions),
                  ),
                  Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          (0.62),
                      child:
                          TransactionList(transactionList, deleteTransaction)),
                ],
              ),
            );}else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text('No Transactions Found',
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.grey)),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        height: 50,
                        child: Image.asset(
                          'assets/images/empty.png',
                          fit: BoxFit.cover,
                        )),
                  ],
                ),
              );
            }

          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text('No Transactions Found',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.grey)),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      height: 50,
                      child: Image.asset(
                        'assets/images/empty.png',
                        fit: BoxFit.cover,
                      )),
                ],
              ),
            );
          }
        },
      ),


      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showInputArea(context);
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
      ),
    );
  }
}
