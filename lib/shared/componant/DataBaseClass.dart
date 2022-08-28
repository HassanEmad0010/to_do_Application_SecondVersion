import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  String? DatabasePath;
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDatabase();
      return _db;
    } else {
      return _db;
    }
  }

  initialDatabase() async {
    String databaseName = 'LocalDataBase';
    String path = await getDatabasesPath();
    DatabasePath = path;
    String databasePath = join(path, databaseName);

    var mydb = await openDatabase(
      databasePath,
      version: 5,
      onCreate: _oncreateMethode,
      //onUpgrade: _onUpgradeMethode,
    );
    print("DB created");

    return mydb;
  }

  _oncreateMethode(Database db, int version) async {
    print("___________on Create");

    // Batch().execute(sql)
    //TITLE,DATA,TIME,STATUS
    await db.execute(
        "CREATE TABLE TASKS (id INTEGER PRIMARY KEY, TITLE TEXT, DATE TEXT, TIME STRING, STATUS STRING)");
    await db.execute(
        "CREATE TABLE DoneTASKS (id INTEGER PRIMARY KEY, TITLE TEXT, DATE TEXT, TIME STRING, STATUS STRING)");
    await db.execute(
        "CREATE TABLE DraftTASKS (id INTEGER PRIMARY KEY, TITLE TEXT, DATE TEXT, TIME STRING, STATUS STRING)");
  }
/*
  _onUpgradeMethode( Database database, int oldVersion, int newVersion)
  async {
    print("___________on upgrade");

    await database.execute("CREATE TABLE DraftTASKS (id INTEGER PRIMARY KEY, TITLE TEXT, DATE TEXT, TIME STRING, STATUS STRING)");


  }*/

  Future<List<Map>> readData({required String sqlCommand}) async {
    print("trying to read data");
    Database? myDb = await db;
    Future<List<Map<String, Object?>>> responce = myDb!.rawQuery(sqlCommand);
    return responce;
  }

  Future<List<Map<String, Object?>>> insertData({
    required String tableName,
    required title,
    required date,
    required time,
    required status,
  }) async {
    print("trying to insert data");

    String sqlCommand =
        'INSERT INTO $tableName(TITLE,DATE,TIME,STATUS) VALUES("$title", "$date", "$time","$status")';
    Database? mydb = await db;
    var response = await mydb!.rawQuery(sqlCommand);
    return response;
  }

  Future<int> DeleteData(
      {required String rowData, required String tableName}) async {
    print("trying to Delete data");

    Database? mydb = await db;
    int responce = await mydb!
        .rawDelete('DELETE FROM $tableName WHERE TITLE = "$rowData"');
    return responce;
  }

  Future<int> DeleteTableData({required String tableName}) async {
    print("trying to Delete data");

    Database? mydb = await db;
    int responce = await mydb!.rawDelete('DELETE FROM "$tableName"');
    return responce;
  }

/*Future<void> DeleteDataBase() async {
    print("trying to Delete database");

    Database? mydb = await db;
     await deleteDatabase(DatabasePath!).then((value) {

     }).catchError((e) {
      print('Got error: $e');
      return 42; // Future completes with 42.
      });

  }*/
}
