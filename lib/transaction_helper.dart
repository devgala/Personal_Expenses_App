import 'package:sqflite/sqflite.dart' ;
import 'model/transaction.dart' ;
final String tableName = 'transactiontable';
final String idCol = 'id';
final String nameCol = 'name';
final String amountCol = 'amount';
final String dateCol = 'datetime';
class TransactionHelper {


  static Database ? _database= null;


  Future<Database?> get getDatabase async{
    if(_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async{
    var dir = await getDatabasesPath() ;
    var path = "${dir}transaction.db";

var database = await openDatabase(path,
    version: 1,
      onCreate: (db,version) async{
         await db.execute('''
            create table $tableName(
            $idCol INTEGER PRIMARY KEY AUTOINCREMENT,
            $nameCol VARCHAR(255) NOT NULL,
            $amountCol INTEGER NOT NULL,
            $dateCol INTEGER NOT NULL)''');
      }
    );
    return database;
  }
    Future<void> insertTransaction(Transactions t) async {


      final db = await getDatabase;
      var result = await db?.insert(tableName,
        t.toMap()
        );

      print(t);
      print(result);

    }
   Future<List<Transactions>> getList() async{
        final db= await getDatabase;
        final List<Map<String, dynamic>>? mapList = await db?.query(tableName);
        print(mapList);
        return List.generate(mapList?.length as int, (index) => Transactions(id : mapList![index]['id'],name: mapList[index]['name'], amount: mapList[index]['amount'], dateTime: DateTime.fromMillisecondsSinceEpoch(mapList[index]['datetime'])));
   }
    Future<void> deleteTransaction(int id) async{
      final db = await getDatabase;
    var count=  await db?.delete(tableName,where: '$idCol = ?',whereArgs: [id]);
    print(count);

    }

}